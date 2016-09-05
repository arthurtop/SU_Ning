//
//  DSZSYFSSViewController.m
//  8.1苏宁ipad
//
//  Created by lovena on 15/8/3.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZSYFSSViewController.h"
#import "DSZMainController.h"
#import "DSZSYFSSViewCell.h"
#import "DSZSYFejMainViewController.h"
#import "DSZZYGBtn.h"
#import "DSZZYGshopDatabase.h"
#import "DSZZHMMineViewController.h"
#define SOUSUOPATH [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]stringByAppendingPathComponent:@"shops.data"]
@interface DSZSYFSSViewController ()<UIAlertViewDelegate>
@property(nonatomic,copy)NSString *contents;//输入的文字内容
@end

@implementation DSZSYFSSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //数组
    NSArray *rsArray=@[@"家电",@"生活用品",@"手机",@"内衣",@"服装",@"女士服装",@"鞋子",@"聚餐",@"火锅",@"兔子",@"洗浴",@"餐厅",@"电影院",@"婴儿用品",@"充值",@"话费",@"礼品",@"酒水",@"肉",@"野炊",@"旅游",@"生活",@"休息",@"酒店",@"KTV",@"网吧",@"景点",@"火鸡",@"吃饭",@"喝酒"];
    _rsArray=[NSMutableArray arrayWithArray:rsArray];
    //取出归档值

    NSArray *array=[NSKeyedUnarchiver unarchiveObjectWithFile:SOUSUOPATH];
    _titArray=[NSMutableArray arrayWithArray:array];
    //九宫格设置
    self.collectionView.dataSource=self;
    self.collectionView.delegate=self;
    UICollectionViewFlowLayout *flow=[[UICollectionViewFlowLayout alloc]init];
    flow.itemSize=CGSizeMake(206, 30);
    flow.sectionInset=UIEdgeInsetsMake(15, 50, 15,0);
    self.collectionView.collectionViewLayout=flow;
    
    //加载nib
    [self.collectionView registerNib:[UINib nibWithNibName:@"DSZSYFSSViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    
    //搜索框设置
    _search.delegate=self;
    
    //徽章
    _zygBtn=[[DSZZYGBtn alloc]initWithFrame:CGRectMake(900, 20, 0, 0)];
    
    [self.view addSubview:_zygBtn];
    [self setbtnTitle];
    
}

-(void)setbtnTitle{
    DSZZYGshopDatabase  *shopbase=[[DSZZYGshopDatabase alloc]init];
    [shopbase createDatabase];
    [shopbase createTable];
    NSArray *dataarray=  [shopbase query];
    [_zygBtn buyNumber:dataarray.count];
}
//添加搜索框
//-(void)loadSearch
//{
//    UISearchBar *search=[[UISearchBar alloc]initWithFrame:CGRectMake(300, 0, 200, 60)];
//    search.delegate=self;
//    search.backgroundColor=[UIColor redColor];
//    [self.topView addSubview:search];
//}

//刷新
int ind=0;
- (IBAction)reBtn {
    
    for(int i=ind;i<ind+10;i++)
    {
        UIButton *btn;
        if (i>=10) {
         btn=_btnRS[i-ind];
        }
        else
        {
            btn=_btnRS[i];
        }
       
        [btn setTitle:_rsArray[i] forState:UIControlStateNormal];
    }
 ind+=10;
 if (ind+10>self.rsArray.count) {
    ind=0;
}
}


//返回按钮

- (IBAction)returnMain {
    [self.navigationController popViewControllerAnimated:NO];
    [self dismissViewControllerAnimated:NO completion:nil];
}
//热搜按钮
- (IBAction)clickTitBtn:(UIButton *)sender {
    //取出选中的按钮的标题
    NSString *str=[sender titleForState:UIControlStateNormal];
    //加入数组中
    BOOL flag=YES;
    //数组加载内容,需要判断数组里面是否已经有这个string
    for(int i=0;i<self.titArray.count;i++)
    {
        if ([str isEqualToString:self.titArray[i]]) {
            //如果相等,把相等的挪到首位
            [self.titArray removeObject:str];
            [self.titArray insertObject:str atIndex:0];
            flag=NO;
            continue;//退出循环
            
        }
    }
    if (flag) {
       [self.titArray insertObject:str atIndex:0];
        
    }
    //刷表
    [self.collectionView reloadData];
    
    //归档
    [NSKeyedArchiver archiveRootObject:_titArray toFile:SOUSUOPATH];
    
    //通知
    NSDictionary *dic=@{@"catclass":str};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"sousuotomian" object:nil userInfo:dic];
    //传值
    DSZSYFejMainViewController *vc=[[DSZSYFejMainViewController alloc]init];
    vc.catClass=str;
    [self.navigationController pushViewController:vc animated:NO];

}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
//去我的
- (IBAction)gotoMy {
    DSZZHMMineViewController *mineVC = [[DSZZHMMineViewController alloc]init];
    [self.navigationController pushViewController:mineVC animated:YES];
}
//购物车
- (IBAction)gotoGWC {
    [self showShopCart];
}

- (IBAction)returnHome {
    //按照所有的进入都是push
    [self.navigationController popToRootViewControllerAnimated:YES];
}
//删除记录
- (IBAction)deleBtn {
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"是否删除搜索记录?" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    [alert show];
    
 }
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        //把数据清楚
        [_titArray removeAllObjects];
        //刷表
        [self.collectionView reloadData];
        //归档
        [NSKeyedArchiver archiveRootObject:_titArray toFile:SOUSUOPATH];

    }
}

#pragma mark----搜索代理
//舰艇搜索框文字改变
-(void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
    _contents=searchText;
}
//当搜索按钮点击的时候
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    BOOL flag=YES;
    //数组加载内容,需要判断数组里面是否已经有这个string
    for(int i=0;i<self.titArray.count;i++)
    {
        if ([_contents isEqualToString:self.titArray[i]]) {
            //如果相等,把相等的挪到首位
            [self.titArray removeObject:_contents];
            [self.titArray insertObject:_contents atIndex:0];
            flag=NO;
            continue;//退出循环
        }
    }
    if (flag) {
     [self.titArray insertObject:_contents atIndex:0];
    }
    //通知
    NSDictionary *dic=@{@"catclass":_contents};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"sousuotomian" object:nil userInfo:dic];
    //传值
    DSZSYFejMainViewController *vc=[[DSZSYFejMainViewController alloc]init];
    vc.catClass=_contents;
     [self.navigationController pushViewController:vc animated:NO];
    
    //刷表
    [self.collectionView reloadData];
    //归档
    [NSKeyedArchiver archiveRootObject:_titArray toFile:SOUSUOPATH];
}
#pragma mark 搜索框开始编辑（开始聚焦）
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    // 1.显示取消按钮
    //[searchBar setShowsCancelButton:YES animated:YES];
}
#pragma mark 当退出搜索框的键盘时（失去焦点）
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    // 2.隐藏取消按钮
      //  [_search setShowsCancelButton:NO animated:YES];
    //3.退出键盘
        [_search resignFirstResponder];
}

#pragma mark----九宫格代理
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.titArray.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DSZSYFSSViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.titLabel.text=self.titArray[indexPath.item];
    return cell;
}
//点击九宫格
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //取出对应数组元素
    NSString *str=self.titArray[indexPath.item];
    //通知
    NSDictionary *dic=@{@"catclass":str};
    //NSLog(@"%@",dic[@"catclass"]);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"sousuotomian2" object:nil userInfo:dic];
    
    DSZSYFejMainViewController *fmain=[[DSZSYFejMainViewController alloc]init];
    fmain.catClass=dic[@"catclass"];
    //传值
    DSZSYFejMainViewController *vc=[[DSZSYFejMainViewController alloc]init];
    
     [self.navigationController pushViewController:vc
                                          animated:NO];

    
    //交换数据
    [self.titArray exchangeObjectAtIndex:0 withObjectAtIndex:indexPath.item];
    
    [NSKeyedArchiver archiveRootObject:self.titArray toFile:SOUSUOPATH];
    
    //刷表
    [self.collectionView reloadData];
}
@end
