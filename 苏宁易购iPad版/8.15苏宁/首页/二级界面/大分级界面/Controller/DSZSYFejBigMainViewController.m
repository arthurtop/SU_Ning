//
//  ViewController.m
//  8.2二级界面
//
//  Created by lovena on 15/8/2.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZSYFejBigMainViewController.h"
#import "DSZSYFejModel.h"
#import "DSZSYFerBigCollectionViewCell.h"
#import "DPAPI.h"
#import "NSObject+Value.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"
#import "DSZSYFBigReusableView.h"
#import "DSZSYFtopejNavView.h"
#import "Common.h"
#import "DSZSYFSSViewController.h"
#import "DSZFYJDataTool.h"
#import "DSZDACXQController.h"
#import "DSZZHMMineViewController.h"
#import "DSZFYJSaoMiaoViewController.h"

#define kLiulanHistoryPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"liulanHistory.data"]



@interface DSZSYFejBigMainViewController ()<DPRequestDelegate,MJRefreshBaseViewDelegate,DSZSYFtopejNavViewDelegate>
@property(nonatomic,weak)MJRefreshHeaderView *header;//头部刷新
@property(nonatomic,weak)MJRefreshFooterView *footer;//尾部刷新
@property(nonatomic,assign)int page;//野马
@property(nonatomic,assign)int count;//总共多少
@property(nonatomic,retain)NSMutableArray *array2;

@property(nonatomic,retain)NSMutableArray *liulanHistoryArray;//浏览历史纪录



@end

@implementation DSZSYFejBigMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    //布局
    UICollectionViewFlowLayout *flow=[[UICollectionViewFlowLayout alloc]init];
    flow.itemSize=CGSizeMake(180, 260);
    flow.sectionInset=UIEdgeInsetsMake(10, 15, 10, 15);
    flow.minimumLineSpacing=10;
    flow.minimumInteritemSpacing=10;
    self.collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64) collectionViewLayout:flow];
    self.collectionView.delegate=self;
    self.collectionView.dataSource=self;
    self.collectionView.backgroundColor=[UIColor colorWithRed:239/255.0 green:239/255.0  blue:239/255.0  alpha:1];
    [self.view addSubview:self.collectionView];
    
    UINib *nib=[UINib nibWithNibName:@"DSZSYFerBigCollectionViewCell" bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:@"cell"];

    //头
    [self.collectionView registerNib:[UINib nibWithNibName:@"DSZSYFBigReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerview"];
    //加载刷新
    [self loadRefresh];
    [_header beginRefreshing];
//    [self changeTopBtn];

   
}
//-(void)changeTopBtn
//{
//    [self]
//}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    if (self.view.window==nil) {
        self.view=nil;
    }
}

-(void)viewWillAppear:(BOOL)animated{
    //加载自定义导航栏
    [super viewWillAppear:animated];
    [self loadnavView];
}
-(void)loadnavView
{
    DSZSYFtopejNavView *nav=[DSZSYFtopejNavView createNavView];
    [nav setbtnTitle];
    nav.frame=CGRectMake(0, 20, self.view.width, 44);
    nav.delegate=self;
    
    [self.view addSubview:nav];
    
    __weak DSZSYFejBigMainViewController *main=self;
    
    nav.myblock=^{
    
        DSZFYJSaoMiaoViewController *saomiao=[[DSZFYJSaoMiaoViewController alloc]init];
        saomiao.modalPresentationStyle=UIModalPresentationFormSheet;
        [main  presentViewController:saomiao animated:YES completion:nil];
    };
    
    
}
#pragma mark-----导航栏代理
-(void)returnDelegate
{
  [self.navigationController popToRootViewControllerAnimated:YES];
}
-(void)returnMainDelegate
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(void)searchBtnDelegate
{
    //模态
    UIStoryboard *story=[UIStoryboard storyboardWithName:@"DSZSYFSSViewController" bundle:nil];
    DSZSYFSSViewController *vc=[story instantiateViewControllerWithIdentifier:@"sousuo"];
    [self.navigationController pushViewController:vc animated:YES];
}

//购物
-(void)gotoGW
{
    [self showShopCart];
    
}
//我的易购
-(void)myYG
{
    DSZZHMMineViewController *mineVC = [[DSZZHMMineViewController alloc]init];
    [self.navigationController pushViewController:mineVC animated:YES];

    
}

#pragma mark---刷新
-(void)loadRefresh
{
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    header.scrollView = _collectionView;
    header.delegate = self;
    _header = header;
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    footer.scrollView = _collectionView;
    footer.delegate = self;
    _footer = footer;

}
#pragma mark - 刷新代理方法

bool headertrue=NO;
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    BOOL isHeader = [refreshView isKindOfClass:[MJRefreshHeaderView class]];
    if (isHeader) { // 下拉刷新
        headertrue=YES;
        // 清除图片缓存
        // 1.清除内存中的缓存图片
        [[SDImageCache sharedImageCache] clearMemory];
        
        // 2.取消所有的下载请求
        [[SDWebImageManager sharedManager] cancelAll];
        //清理下载在沙河中的缓存图片
        [[SDImageCache sharedImageCache] cleanDisk];
        _page = 1; // 第一页
    } else { // 上拉加载更多
        _page++;
    }
    //申请数据
    [self loadWebData];
    
    // 加载第_page页的数据


}



-(void)loadWebData
{
    // 1.封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObject:@(30) forKey:@"limit"];
    //    // 1.1.添加城市参数
    NSString *city =[DSZFYJDataTool sharedDSZFYJDataTool].city;
    
    //////////
    if (city==nil) {
       city=@"郑州";
    }
    
    
    [params setObject:city forKey:@"city"];
    [params setObject:@(_page) forKey:@"page"];
    DPAPI *api = [[DPAPI alloc] init];
    [api requestWithURL:@"v1/deal/find_deals" params:params delegate:self];
    
}
- (void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result
{
    NSArray *array = result[@"deals"];
    NSNumber *count=result[@"total_count"];
    _count=[count floatValue];
    
    _array2 = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        DSZSYFejModel *d=[[DSZSYFejModel alloc]init];
        [d setValues:dict];
        [_array2 addObject:d];
        
    }
    
    if (headertrue==YES) {
        //防止下拉刷新崩，在下拉之后再把数组内容清空
        _EJarray = [NSMutableArray array];
        headertrue=NO;
    }
    // 1.添加数据
    [_EJarray addObjectsFromArray:self.array2];
    
//    //通知
//    NSDictionary *dic=@{@"array":_EJarray};
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"array" object:nil userInfo:dic];
    
    // 2.刷新表格
    [_collectionView reloadData];
    
    // 4.根据数量判断是否需要隐藏上拉控件
    _footer.hidden = _EJarray.count >= _count;
    [_footer endRefreshing];
    [_header endRefreshing];

}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.EJarray.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DSZSYFerBigCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.model=self.EJarray[indexPath.item];
    return cell;
}

//头
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    DSZSYFBigReusableView *view=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerview" forIndexPath:indexPath];
    return view;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(1024, 250);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DSZSYFejModel *model = self.EJarray[indexPath.item];
    
    _liulanHistoryArray = [NSKeyedUnarchiver unarchiveObjectWithFile:kLiulanHistoryPath];
    if(!_liulanHistoryArray){
        _liulanHistoryArray = [NSMutableArray array];
        [_liulanHistoryArray insertObject:model atIndex:0];
    }
//    for (DSZSYFejModel *m in _liulanHistoryArray) {
//        if ([m.deal_id isEqualToString:model.deal_id]) {
//            break;
//        }
    [_liulanHistoryArray insertObject:model atIndex:0];
    [NSKeyedArchiver archiveRootObject:_liulanHistoryArray toFile:kLiulanHistoryPath];

    UIStoryboard *story = [UIStoryboard storyboardWithName:@"DSZDACXQController" bundle:nil];
    DSZDACXQController *con = [story instantiateViewControllerWithIdentifier:@"XQ"];
    con.dealid = model.deal_id;
    [self.navigationController pushViewController:con animated:YES];
}
@end
