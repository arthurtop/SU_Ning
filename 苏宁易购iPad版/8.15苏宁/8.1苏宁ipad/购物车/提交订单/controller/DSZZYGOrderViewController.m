//
//  DSZZYGOrderViewController.m
//  8.1苏宁ipad
//
//  Created by app15 on 15/8/3.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZZYGOrderViewController.h"

//表
#import "DSZZYGOrderHeader.h"
#import "DSZZYGTableHeader.h"
#import "DSZZYGTOrderCell.h"
#import "DSZZYGOrderBottom.h"
//push
#import "DSZZYGAddressViewController.h"
#import "DSZZYGQuanViewController.h"
#import "DSZZYGSuccessController.h"
//数据库
#import "DSZZYGDataBase.h"
#import "DSZZYGshopDatabase.h"
//model
#import "DSZZHMOderModel.h"

#define FilePath3 [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]stringByAppendingPathComponent:@"oder.data"]
@interface DSZZYGOrderViewController ()<UITableViewDataSource,UITableViewDelegate,DSZZYGTableHeaderDelegate,DSZZYGOrderBottomDelegate,UIAlertViewDelegate>
{
    NSArray *array;
    
    DSZZYGTableHeader *header;
    DSZZYGOrderBottom *bottom;
    
    DSZZYGshopDatabase *orderbase;
    NSArray *orderarray;
    NSMutableArray *shopnameArray;//商店名字数组
    NSMutableArray *groupData;//每个商店的商品
}
@property(assign,nonatomic)CGFloat heightHeader;
@end

@implementation DSZZYGOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _heightHeader=437;
    self.title=@"确认订单";
    //加载数据
    orderbase=[[DSZZYGshopDatabase alloc]init];
    [orderbase createDatabase];
    [orderbase createTable];
    orderarray=  [orderbase queryselectthing:1];
    [self loadshopnameArray];
    [self loadgroupArray];
    
    //数据
    DSZZYGDataBase *daz=[[DSZZYGDataBase alloc]init];
    [daz createDatabase];
    [daz createTable];
    array=[daz query];
    
    //view
    [self loadnav];
    [self loadtable];
    [self peopleaddress];
    [self loadBottom];

    // Do any additional setup after loading the view.
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //数据
    DSZZYGDataBase *daz=[[DSZZYGDataBase alloc]init];
    [daz createDatabase];
    [daz createTable];
    array=[daz query];
    [self peopleaddress];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    //数据
    DSZZYGDataBase *daz=[[DSZZYGDataBase alloc]init];
    [daz createDatabase];
    [daz createTable];
    array=[daz query];
    [self loadtable];
}


#pragma mark--加载数据
//店铺名字数组
-(void)loadshopnameArray{
    shopnameArray=[NSMutableArray array];
    for (NSDictionary *dic in orderarray) {
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
        NSMutableArray *shoparray=[NSMutableArray array];
        NSString *string=shopnameArray[i];
        for (NSDictionary *dic in orderarray) {
            if ([string isEqualToString:dic[@"storename"]]) {
                [shoparray addObject:dic];
            }
        }
        [groupData addObject:shoparray];
    }
}

-(void)peopleaddress{
    for (int  i=0; i<array.count; i++) {
        NSDictionary *dic=array[i];

        if([header  setaddress:dic]){
            break;
        }
    }

}
-(void)loadBottom{
    bottom=[DSZZYGOrderBottom loadnib];
    
    CGRect frame=bottom.frame;
    frame.origin.y=self.view.frame.origin.y-129;
    bottom.frame=frame;
    bottom.delegate=self;
    [self.view addSubview: bottom];

    CGFloat priceAll = 0.0;
    int thingsnumber=0;
    for (NSDictionary *dic in orderarray) {
        if ([dic[@"selectthing"] intValue]==1) {
            priceAll=priceAll+[dic[@"thingprice"] floatValue ]*[dic[@"num"] intValue];
            thingsnumber++;
        }
    }
    
    bottom.AddPrice.text=[NSString stringWithFormat:@"¥%.2f",priceAll];
    bottom.priceAll.text=[NSString stringWithFormat:@"¥%.2f",priceAll];
    
    bottom.frame=CGRectMake(0,table.frame.size.height, self.view.frame.size.width, bottom.frame.size.height);
}

-(void)loadnav{
    UIBarButtonItem *left=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"navBack"] landscapeImagePhone:nil style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    left.tintColor=[UIColor blackColor];
    self.navigationItem.leftBarButtonItem=left;
}
-(void)back{
    [self.navigationController popViewControllerAnimated:NO];
}
-(void)loadtable{
    table=[[UITableView alloc]init];
    
    table.frame=CGRectMake(self.view.frame.origin.x
                           , self.view.frame.origin.y+64, self.view.frame.size.width, self.view.frame.size.height-129);
    table.dataSource=self;
    table.delegate=self;
    table.separatorStyle=0;
    table.backgroundColor=[UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    [self.view addSubview:table];
    
    header=[DSZZYGTableHeader loadnib];
    header.delegate=self;
    table.tableHeaderView=header;
    [self.view bringSubviewToFront:header];
    
}

#pragma mark--bottom 代理
-(void)poshsuccess{
    for (NSDictionary *dic in orderarray) {
        [self guidang:dic];
        orderbase=[[DSZZYGshopDatabase alloc]init];
        [orderbase createDatabase];
        [orderbase createTable];
        [orderbase delete:dic[@"thingid"]];
        
    }
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"恭喜你，本次购买商品成功" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        DSZZYGSuccessController *success=[[DSZZYGSuccessController alloc]init];
        success.price=bottom.priceAll.text;
        [self.navigationController pushViewController:success animated:NO];
    }
}
#pragma mark 订单归档
-(void)guidang:(NSDictionary*)dic
{
    //读档
    _muarray = [NSKeyedUnarchiver unarchiveObjectWithFile:FilePath3];
    //创建要归档的模型
    DSZZHMOderModel *odermodel = [[DSZZHMOderModel alloc]init];
    //日期
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    [format setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [NSDate date];
    NSString *time = [format stringFromDate:date];
    odermodel.updatetime = time;
    odermodel.orderid = dic[@"thingid"];
    //NSLog(@"%@",dic[@"thingid"]);
    NSString *str = dic[@"thingprice"];
    odermodel.listpricetext = str;
    odermodel.imageUrl = dic[@"thingimage"];
//        NSLog(@"-----%@",odermodel.updatetime);
//        NSLog(@"======%@",odermodel.orderid);
//        NSLog(@"*******%@",odermodel.listpricetext);
//        NSLog(@"&&&&&&&&&%@",odermodel.imageUrl);
    if (_muarray==NULL) {
        _muarray = [NSMutableArray array];
    }
    //    NSLog(@"%d",_muarray.count);
    //添加新数据
    [_muarray insertObject:odermodel atIndex:0];
    //归档
    [NSKeyedArchiver archiveRootObject:_muarray toFile:FilePath3];
}
#pragma mark--代理
-(void)pushQuan{
    DSZZYGQuanViewController *quan=[[DSZZYGQuanViewController alloc]init];
    [self.navigationController pushViewController:quan animated:NO];
}
-(void)pushAddress{
    DSZZYGAddressViewController *address=[[DSZZYGAddressViewController alloc]init];
    [self.navigationController pushViewController:address animated:NO];
}

-(void)HeaderHeight:(CGFloat)height{
    _heightHeader=height;
    CGRect frame= header.frame;
    frame.size.height=_heightHeader;
    header.frame=frame;
    table.tableHeaderView=header;

}

#pragma mark--tabledata
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return shopnameArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *oarray= groupData[section];
    return oarray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *string=@"cell";
    NSArray  *oarray= groupData[indexPath.section];
    NSDictionary *dic=oarray[indexPath.row];
    DSZZYGTOrderCell *cell=[tableView dequeueReusableCellWithIdentifier:string];
    if (cell==nil) {
        cell=[[DSZZYGTOrderCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:string];
    }
    [cell setcell:dic];
    cell.selectionStyle=0;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 160;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSString *name=shopnameArray[section];
    
    DSZZYGOrderHeader *headerview=[DSZZYGOrderHeader loadNib];
    headerview.nameLabel.text=name;
    return headerview;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 80;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
