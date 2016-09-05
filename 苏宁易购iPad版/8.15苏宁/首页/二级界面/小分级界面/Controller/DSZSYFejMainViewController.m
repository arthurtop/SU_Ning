//
//  ViewController.m
//  8.2二级界面
//
//  Created by lovena on 15/8/2.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZSYFejMainViewController.h"
#import "DSZSYFejModel.h"
#import "DSZSYFerCollectionViewCell.h"
#import "DPAPI.h"
#import "NSObject+Value.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"
#import "DSZSYFejTopView.h"
#import "DSZSYFtopejNavView.h"
#import "Common.h"
#import "DSZSYFSSViewController.h"
#import "DSZMainController.h"
#import "DSZFYJDataTool.h"
#import "DSZDACXQController.h"
#import "DSZZHMMineViewController.h"
#import "DSZFYJSaoMiaoViewController.h"

#define kLiulanHistoryPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"liulanHistory.data"]



@interface DSZSYFejMainViewController ()<DPRequestDelegate,MJRefreshBaseViewDelegate,DSZSYFtopejNavViewDelegate>
@property(nonatomic,weak)MJRefreshHeaderView *header;//头部刷新
@property(nonatomic,weak)MJRefreshFooterView *footer;//尾部刷新
@property(nonatomic,assign)int page;//野马
@property(nonatomic,assign)int count;//总共多少
@property(nonatomic,retain)NSMutableArray *array2;
@property(nonatomic,copy)NSString *citys;//选中的城市
@property(nonatomic,retain)NSNumber *sorts;//选中的排序

@property(nonatomic,retain)NSMutableArray *liulanHistoryArray;//浏览历史纪录

@end

@implementation DSZSYFejMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    _EJarray = [NSMutableArray array];
    // 加载自定义导航
    [self loadNav];
    //布局
    UICollectionViewFlowLayout *flow=[[UICollectionViewFlowLayout alloc]init];
    flow.itemSize=CGSizeMake(240, 300);
    flow.sectionInset=UIEdgeInsetsMake(15, 15, 15, 15);
    flow.minimumLineSpacing=10;
    flow.minimumInteritemSpacing=10;
    self.collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 108, self.view.frame.size.width, self.view.frame.size.height-108) collectionViewLayout:flow];
    self.collectionView.delegate=self;
    self.collectionView.dataSource=self;
    self.collectionView.backgroundColor=[UIColor colorWithRed:239/255.0 green:239/255.0  blue:239/255.0  alpha:1];
    [self.view addSubview:self.collectionView];
    
    UINib *nib=[UINib nibWithNibName:@"DSZSYFerCollectionViewCell" bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:@"cell"];


    //加载刷新
    [self loadRefresh];
    [_header beginRefreshing];
   
    [self loadTopView];
    
    //接收通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeCitys:) name:@"btnname" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeSort:) name:@"sortsIndex" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeRefresh:) name:@"sousuotomian" object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeRefresh:) name:@"sousuotomian2" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeRefresh:) name:@"cxgoto" object:nil];
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    if (self.view.window==nil) {
        self.view=nil;
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hiddenView" object:nil];
     [self loadTopView];
}
//自定义导航栏
-(void)loadNav
{
    DSZSYFtopejNavView *nav=[DSZSYFtopejNavView createNavView];
    nav.frame=CGRectMake(0, 20, self.view.width, 44);
    nav.delegate=self;
    nav.titLabel.text=self.catClass;
    [nav setbtnTitle];
    [self.view addSubview:nav];
    
    __weak DSZSYFejMainViewController *main=self;
    
    nav.myblock=^{
        
        DSZFYJSaoMiaoViewController *saomiao=[[DSZFYJSaoMiaoViewController alloc]init];
        saomiao.modalPresentationStyle=UIModalPresentationFormSheet;
        [main  presentViewController:saomiao animated:YES completion:nil];
    };
}
#pragma mark----导航栏代理
-(void)returnDelegate
{
   if([self.navigationController popToRootViewControllerAnimated:YES])
   {
       return;
   }
    
    [self dismissViewControllerAnimated:NO completion:nil];
    
}
-(void)returnMainDelegate
{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}
-(void)searchBtnDelegate
{
    
    UIStoryboard *story=[UIStoryboard storyboardWithName:@"DSZSYFSSViewController" bundle:nil];
    DSZSYFSSViewController *vc=[story instantiateViewControllerWithIdentifier:@"sousuo"];
    [self.navigationController pushViewController:vc animated:NO];
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
#pragma mark----代理

-(void)changeCitys:(NSNotification *)user
{
    NSDictionary *dic=user.userInfo;
    _citys=dic[@"name"];
    [_header beginRefreshing];
}
-(void)changeSort:(NSNotification *)user
{
    NSDictionary *dic=user.userInfo;
    _sorts=dic[@"sortsIndex"];
    [_header beginRefreshing];
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
//加载top
-(void)loadTopView
{
    DSZSYFejTopView *top=[DSZSYFejTopView createTop];
    [top setbtnTitle];

    top.frame=CGRectMake(0, 64, self.view.frame.size.width, 44);
    [self.view addSubview:top];

    

}


-(void)changeRefresh:(NSNotification *)user
{
    NSDictionary *dic=user.userInfo;
    _catClass=dic[@"catclass"];
    //NSLog(@"2222%@",_catClass);
    [_header beginRefreshing];
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
bool headerflag=NO;
#pragma mark - 刷新代理方法
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    BOOL isHeader = [refreshView isKindOfClass:[MJRefreshHeaderView class]];
    if (isHeader) { // 下拉刷新
        headerflag=YES;
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
}



-(void)loadWebData
{
   
    // 1.封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObject:@(30) forKey:@"limit"];
    // 1.1.添加城市参数

        _citys =[DSZFYJDataTool sharedDSZFYJDataTool].city;
//        //测试用
        if (_citys==nil) {
            _citys=@"郑州";
        }
    
    //发个通知
    NSDictionary *dic=@{@"city":_citys};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"givecitys" object:nil userInfo:dic];
    
    [params setObject:_citys forKey:@"city"];
    //添加分类
    if (_sorts!=nil)
    {
    [params setObject:_sorts forKey:@"sort"];
    }
    //添加页书
    [params setObject:@(_page) forKey:@"page"];
    //添加分类
    if (_catClass!=nil) {
       
       [params setObject:_catClass forKey:@"keyword"];
    }
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
        //NSLog(@"%@",dict);
        DSZSYFejModel *d=[[DSZSYFejModel alloc]init];
        [d setValues:dict];
        [_array2 addObject:d];
        
    }
    if (headerflag) {
        //防止下拉刷新崩，在下拉之后再把数组内容清空
        _EJarray = [NSMutableArray array];
        headerflag=NO;
    }
    // 1.添加数据
    [_EJarray addObjectsFromArray:self.array2];
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
    DSZSYFerCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.model=self.EJarray[indexPath.item];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    
    DSZSYFejModel *model = self.EJarray[indexPath.item];
    
    
    _liulanHistoryArray = [NSKeyedUnarchiver unarchiveObjectWithFile:kLiulanHistoryPath];
        if(!_liulanHistoryArray){
            _liulanHistoryArray = [NSMutableArray array];
            [_liulanHistoryArray insertObject:model atIndex:0];
        }
//        for (DSZSYFejModel *m in _liulanHistoryArray) {
//            if ([m.deal_id isEqualToString:model.deal_id]) {
//                break;
//            }
        [_liulanHistoryArray insertObject:model atIndex:0];
        [NSKeyedArchiver archiveRootObject:_liulanHistoryArray toFile:kLiulanHistoryPath];

    
    
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"DSZDACXQController" bundle:nil];
    DSZDACXQController *con = [story instantiateViewControllerWithIdentifier:@"XQ"];
    con.dealid = model.deal_id;
    [self.navigationController pushViewController:con animated:YES];
}
@end
