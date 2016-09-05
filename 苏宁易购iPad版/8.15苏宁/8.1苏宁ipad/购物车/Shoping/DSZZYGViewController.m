//
//  DSZSCViewController.m
//  8.1苏宁ipad
//
//  Created by app15 on 15/8/2.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZZYGViewController.h"
//view
#import "DSZZYGShopCell.h"
#import "DSZZYGShopHeaderView.h"
#import "DSZZYGShopBottom.h"
#import "DSZZYGshopTopView.h"
#import "DSZSYFtopView.h"
//第三方
#import "Common.h"
#import "MJExtension.h"
#import "DSZZYGNaView.h"
#import "DSZZYGshopDatabase.h"
#import "MBProgressHUD+MJ.h"
#import "MBProgressHUD.h"
#import "TGCover.h"
#import "DSZZHMLoginView.h"
//跳转视图
#import "DSZZYGOrderViewController.h"


#define kFilePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"login.data"]

static NSString *const name = @"ShopCell";
static NSString *const header=@"ZYGheader";
@interface DSZZYGViewController ()<UITableViewDataSource,UITableViewDelegate,DSZZYGShopBottomDelegate,DSZZYGShopCellDelegate,DSZZYGshopTopViewDelegate>
{
    DSZZYGShopBottom *bottom;
    DSZZYGshopDatabase *shopbase;
    
    NSArray *dataarray;//全部商品
    NSMutableArray *shopnameArray;//商店名字数组
    NSMutableArray *groupData;//每个商店的商品
}

//遮罩
@property(weak,nonatomic)TGCover *cover;
//登陆视图
@property(weak,nonatomic)DSZZHMLoginView *loginView;
@property(copy,nonatomic)NSString *tel;

@property(nonatomic,strong)UITableView  *table;



@end



@implementation DSZZYGViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"购物车";
    
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documents = [paths objectAtIndex:0];
//    NSLog(@"%@",paths);
    //加载数据
    shopbase=[[DSZZYGshopDatabase alloc]init];
    [shopbase createDatabase];
    [shopbase createTable];
    dataarray=  [shopbase query];
    [self loadshopnameArray];
    [self loadgroupArray];
    [self islogin];
    //通知  段头
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(roadheader:) name:@"shopselect" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(roadheaderdele:) name:@"shopdele" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notice:) name:@"loginsuccessed" object:nil];
        // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self tabledata];
    
}
-(void)islogin{
    _tel = [NSKeyedUnarchiver unarchiveObjectWithFile:kFilePath];
    if (!_tel||(dataarray.count==0&&_tel)) {
        [self  loadtop];
    }else{
        if (dataarray.count!=0&&_tel) {
            
            [self loadnav];
            [self loadCollection];
            [self loadBottomView];
            [self tabledata];
            
        }
    }
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}



-(void)loadtop{
    DSZZYGshopTopView *top=[DSZZYGshopTopView loadnib];
    top.delegate=self;
    
    _tel = [NSKeyedUnarchiver unarchiveObjectWithFile:kFilePath];
    if (!_tel) {
        top.loginBtn.hidden = NO;
        top.loginLabel.hidden = NO;
    }else{
        top.loginBtn.hidden = YES;
        top.loginLabel.hidden = YES;

    }
    self.view=top;
}
-(void)login
{
    
    //遮罩
    TGCover *cover = [TGCover coverWithTarget:self action:@selector(hide:)];
    cover.frame = CGRectMake(0, 0,self.view.bounds.size.width, self.view.bounds.size.height);
    [self.view addSubview:cover];
    _cover = cover;
    
    //登陆或注册
    DSZZHMLoginView *login = [[DSZZHMLoginView alloc]init];
    login.frame = CGRectMake(260, 200,0, 0);
    [self.view addSubview:login];
    _loginView = login;
    
    CAKeyframeAnimation *scale = [CAKeyframeAnimation animation];
    scale.keyPath = @"transform.scale";
    scale.values = @[@(0.0),@(1.0)];
    scale.duration = 0.6;
    scale.removedOnCompletion = NO;
    scale.fillMode = kCAFillModeForwards;
    [_loginView.layer addAnimation:scale forKey:nil];
}


//保留通知传递的参数
-(void)notice:(NSNotification *)notification{
    
    _tel = notification.object;
    
    [NSKeyedArchiver archiveRootObject:_tel toFile:kFilePath];
    
    //通知主页改变购物车徽章数
    [[NSNotificationCenter defaultCenter]postNotificationName:@"loginsuccess2" object:nil];
    
    [self hide:nil];
    
}


//隐藏登录界面
-(void)hide:(UITapGestureRecognizer *)tap  {
    
    
    CABasicAnimation *scale = [CABasicAnimation animation];
    scale.keyPath = @"transform.scale";
    scale.toValue = @(0.0);
    
    CABasicAnimation *move = [CABasicAnimation animation];
    move.keyPath = @"transform.translation";
    move.toValue = [NSValue valueWithCGPoint:CGPointMake(200,-100)];
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[scale,move];
    group.duration = 1.0;
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    [_loginView.layer addAnimation:group forKey:nil];
    
    _loginView = nil;
    
    [self performSelector:@selector(hideCover) withObject:nil afterDelay:1.0];
    
}
//隐藏遮罩
-(void)hideCover{
    [_cover removeFromSuperview];
    _cover = nil;
    [self islogin];
}


#pragma mark--加载数据
//店铺名字数组
-(void)loadshopnameArray{
    shopnameArray=[NSMutableArray array];
    for (NSDictionary *dic in dataarray) {
        BOOL havesame=NO;
        NSString *string= dic[@"storename"];
        if (shopnameArray.count==0) {
            [shopnameArray addObject:string];
        }
        for (int i=0; i<shopnameArray.count; i++) {
            if ([string isEqualToString:shopnameArray[i]]) {
                havesame=YES;
                break;
            }
        }
        if (havesame==NO) {
            [shopnameArray addObject:string];
        }
    }
}
//购物车店铺商品数组
-(void)loadgroupArray{
    groupData=[NSMutableArray array];
    for (int i=0; i<shopnameArray.count; i++) {
        NSMutableArray *array=[NSMutableArray array];
        NSString *string=shopnameArray[i];
        for (NSDictionary *dic in dataarray) {
            if ([string isEqualToString:dic[@"storename"]]) {
                [array addObject:dic];
            }
        }
        [groupData addObject:array];
    }
}


#pragma mark-- 子视图（表,bottom）
//导航
-(void)loadnav{
    BOOL yellow=NO;
    UIBarButtonItem *right;
    if (_tel) {
        right=[[UIBarButtonItem alloc]initWithTitle:@"删除" style:UIBarButtonItemStyleDone target:self action:@selector(deletedata)] ;
    }else{
    right=[[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStyleDone target:self action:@selector(deletedata)] ;
    }
    for (NSDictionary *dic in dataarray) {
        if ([dic[@"selectthing"] intValue]==1) {
            yellow=YES;
            break;
        }
    }
    if (yellow) {
        right.tintColor=[UIColor orangeColor];
    }else{
        right.tintColor=[UIColor grayColor];
    }
    
    self.navigationItem.rightBarButtonItem=right;
}
-(void)deletedata{
    for (NSDictionary *dic in dataarray) {
        NSString *thing=dic[@"thingid"];
        NSString  *thingid=thing ;
        if ([dic[@"selectthing"] intValue]==1) {
            [shopbase delete:thingid];
        }
    }
    [self tabledata];
}
//表
-(void)loadCollection{
    _table=[[UITableView alloc]init];
    _table.frame=CGRectMake(0, 0, 800, self.view.height-70);
    _table.backgroundColor=[UIColor whiteColor];
    _table.separatorStyle=0;
    [self.view addSubview:_table];
    _table.backgroundColor=[UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    _table.dataSource=self;
    _table.delegate=self;
}
//加载bottom
-(void)loadBottomView{
    bottom=[[DSZZYGShopBottom alloc]init];
    bottom=[DSZZYGShopBottom loadNib];
    bottom.frame=CGRectMake(0, self.view.height-70, self.view.width, 70);
    bottom.delegate=self;
    [self.view addSubview:bottom];
}




#pragma  mark--header通知方法
//选中商铺下所有商品
-(void)roadheader:(NSNotification*)text{
    NSString *string=text.userInfo[@"name"];
    for (int i=0;i<shopnameArray.count;i++) {
        if ([string isEqualToString:shopnameArray[i]]) {
             NSArray *array=groupData[i];
            for (NSDictionary *dic in array) {
                NSString *thing=dic[@"thingid"];
                NSString * thingid=thing;
                if ([dic[@"selectthing"] intValue]==0) {
                    [shopbase update:thingid selectthing:1];
                }
            }
            break;
        }
    }
    [self tabledata];
}
//取消选中商铺下所有商品
-(void)roadheaderdele:(NSNotification*)text{
    NSString *string=text.userInfo[@"name"];
    for (int i=0;i<shopnameArray.count;i++) {
        if ([string isEqualToString:shopnameArray[i]]) {
            NSArray *array=groupData[i];
            for (NSDictionary *dic in array) {
                NSString * thing=dic[@"thingid"];
                NSString *  thingid=thing ;
                if ([dic[@"selectthing"] intValue]==1) {
                    [shopbase update:thingid selectthing:0];
                }
            }
            break;
        }
    }
    [self tabledata];
}


#pragma mark--代理cell  刷表方法
//刷表
-(void)tabledata{
    
    shopbase=[[DSZZYGshopDatabase alloc]init];
    [shopbase createDatabase];
    [shopbase createTable];

    dataarray=  [shopbase query];

    [[NSNotificationCenter defaultCenter]postNotificationName:@"numberBuy" object:nil];
    if (dataarray.count==0) {
        [self  loadtop];
    }else{
    [self loadnav];
    //数组
    [self loadshopnameArray];
    [self loadgroupArray];
    
    [self changeBottomView];
    //刷表
    [self.table reloadData];
    }
}

//bottom 计算价格
-(void)changeBottomView{
    CGFloat priceAll = 0.0;
    int thingsnumber=0;
    for (NSDictionary *dic in dataarray) {
        if ([dic[@"selectthing"] intValue]==1) {
            priceAll=priceAll+([dic[@"thingprice"] floatValue] * [dic[@"num"] intValue]);
            thingsnumber++;
        }
    }
    
    bottom.selectNum.text=[NSString stringWithFormat:@"已选 %i 件",thingsnumber];
    bottom.price.text=[NSString stringWithFormat:@"¥%.2f",priceAll];
    if ([self judgeselectAll]) {
        bottom.BottomselectBtn.selected=YES;
    }else{
        bottom.BottomselectBtn.selected=NO;
    }

}
-(BOOL)judgeselectAll{
    BOOL judge=YES;
    for (NSDictionary *dic in dataarray) {
        if ([dic[@"selectthing"] intValue]==0) {
            judge=NO;
        }
    }
    return judge;
}



#pragma mark--bottom代理
//取消所有选中
-(void)delshopname{
    for (NSDictionary *dic in dataarray) {
        NSString *thing=dic[@"thingid"];
        NSString *thingid=thing;
        if ([dic[@"selectthing"] intValue]==1) {
           [shopbase update:thingid selectthing:0];
        }
    }
    [self tabledata];
    if (dataarray.count==0) {
        [bottom removeFromSuperview];
        [_table removeFromSuperview];
        [self loadtop];
    }
}
//选中所有
-(void)addshopname{
    for (NSDictionary *dic in dataarray) {
        NSString *thing=dic[@"thingid"];
        NSString *thingid=thing;
        if ([dic[@"selectthing"] intValue]==0) {
            [shopbase update:thingid selectthing:1];
        }
    }
    [self tabledata];
}
//push button的方法
-(void)pushOrder{
    
    [MBProgressHUD showMessage:@"加载中" toView:self.view];
//     MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    [hud hide:YES afterDelay:0.7];
    [self performSelector:@selector(nexttemp) withObject:nil afterDelay:1];

}
-(void)nexttemp
{
    if ([bottom.price.text isEqualToString:@"¥0.00"]) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"你还没有选择商品" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }else{
        //NSLog(@"%@",bottom.price.text);
        DSZZYGOrderViewController *order=[[DSZZYGOrderViewController alloc]init];
        [self.navigationController pushViewController:order animated:NO];
    }
}



#pragma mark--tabledata
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return shopnameArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
        NSArray  *array= groupData[section];
        return array.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        static NSString *string=@"cell";
        NSArray  *array= groupData[indexPath.section];
        NSDictionary *dic=array[indexPath.row];
    

       DSZZYGShopCell *cell=[tableView dequeueReusableCellWithIdentifier:string];
    if (cell==nil) {
        cell=[[DSZZYGShopCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:string];
    }
    
    cell.delegate=self;
    cell.selectionStyle=0;
    [cell setcell:dic];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
  NSArray *array=groupData[section];

    DSZZYGShopHeaderView *headerview=[DSZZYGShopHeaderView loadNib];
    [headerview  setheader:array];
    return headerview;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 84;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
