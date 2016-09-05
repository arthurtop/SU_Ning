//
//  DSZCQAuctionController.m
//  8.1苏宁ipad
//
//  Created by app20 on 15/8/2.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZCQAuctionController.h"
#import "DSZCQTopBtnsView.h"
#import "DSZCQHotAuctionBtnsView.h"
#import "DSZCQTodayViewCell.h"
#import "DSZCQTomorrowViewCell.h"
#import "DSZCQHistoryViewCell.h"
#import "DSZCQAuctionmodel.h"
#import "DSZSYFejModel.h"
#import "DSZSYFtopView.h"
#import "DPAPI.h"
#import "Common.h"
#import "DSZSYFtopejNavView.h"
#import "DSZFYJSaoMiaoViewController.h"
#import "DSZSYFSSViewController.h"
#import "DSZZHMMineViewController.h"
@interface DSZCQAuctionController ()<DSZCQTopBtnsViewBtnClick,DSZCQHotAuctionBtnsView,DPRequestDelegate,DSZSYFtopejNavViewDelegate>

@property(nonatomic,weak) UIScrollView *scrollView;
@property(nonatomic,weak) UIView *mainView;
@property(nonatomic,weak) UIView *assistView;
@property(nonatomic,retain)NSMutableArray *array;

// 控件 Y 值
@property(nonatomic,assign) CGFloat viewY;

@end

@implementation DSZCQAuctionController

-(void)loadWebData
{
    // 1.封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObject:@(40) forKey:@"limit"];
    
    // 1.1.添加城市参数
    if(_citys == nil)
    {
        _citys = @"郑州";
    }
    
    [params setObject:_citys forKey:@"city"];

    DPAPI *api = [[DPAPI alloc] init];
    [api requestWithURL:@"v1/deal/find_deals" params:params delegate:self];
    
}

- (void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result
{
    NSArray *array = result[@"deals"];
    
    _array = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        
       DSZCQAuctionmodel *d = [[DSZCQAuctionmodel alloc]init];
        //DSZSYFejModel *d=[[DSZSYFejModel alloc]init];
       [d setValues:dict];
       
        [_array addObject:d];
    }
    
    [self loadScrollView];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText=@"加载中...";
    
    
    DSZSYFtopejNavView *nav=[DSZSYFtopejNavView createNavView];
    nav.frame=CGRectMake(0, 20, self.view.width, 44);
    [nav setbtnTitle];
    nav.delegate=self;
    [self.view addSubview:nav];
    
    __weak DSZCQAuctionController *main=self;
    
    nav.myblock=^{
        
        DSZFYJSaoMiaoViewController *saomiao=[[DSZFYJSaoMiaoViewController alloc]init];
        saomiao.modalPresentationStyle=UIModalPresentationFormSheet;
        [main  presentViewController:saomiao animated:YES completion:nil];
    };

    
    
    [self.view addSubview:nav];
    
    [self loadWebData];
}

#pragma mark----导航栏代理
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



- (void)loadScrollView
{
    // 加载scrollView
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height - 64)];
    scrollView.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    _scrollView = scrollView;
    [self.view addSubview:scrollView];
    
    // 向 scrollView 添加顶部热拍按钮
    DSZCQTopBtnsView *topBtnsView = [DSZCQTopBtnsView createDSZCQTopBtnsView];
    topBtnsView.frame = CGRectMake(0, 0, scrollView.width, 44);
    topBtnsView.delegate = self;
    [scrollView addSubview:topBtnsView];
    
    // 添加主视图
    UIView *mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 44, self.view.width, 10000)];
    mainView.userInteractionEnabled = YES;
    self.mainView = mainView;
    [scrollView addSubview:mainView];
    
    [self loadTodayHotAuctionBtnsView];
    
}

// 加载今日热拍
-(void)loadTodayHotAuctionBtnsView
{
    // 添加热拍按钮
    DSZCQHotAuctionBtnsView *hotAuctionBtnsView = [DSZCQHotAuctionBtnsView createDSZCQHotAuctionBtnsView];
    hotAuctionBtnsView.frame = CGRectMake(0, 0, self.view.width, 60);
    hotAuctionBtnsView.delegate = self;
    [_mainView addSubview:hotAuctionBtnsView];
    
    [self loadTodayHotAuctionView:0];
}

- (void)loadTodayHotAuctionView:(NSInteger)index
{
    // 添加辅助视图
    UIView *assistView = [[UIView alloc] initWithFrame:CGRectMake(0, 60, self.view.width, 7000)];
    assistView.userInteractionEnabled = YES;
    self.assistView = assistView;
    [_mainView addSubview:assistView];
    
    self.viewY = 0;
    
    for (long i = _array.count / 4 * index; i < _array.count / 4 * (index + 1); i++)
    {
    
        self.viewY += 12;
        DSZCQAuctionmodel *model = self.array[i];
        //DSZSYFejModel *model=self.array[i];
        
        DSZCQTodayViewCell *todayHotAuctionView = [DSZCQTodayViewCell createDSZCQLotViewCell];
        todayHotAuctionView.frame = CGRectMake(12, self.viewY, 1000, 700);
        todayHotAuctionView.image_url = model.image_url;
        todayHotAuctionView.title = model.title;
        todayHotAuctionView.list_price = model.list_price;
        todayHotAuctionView.current_price = model.current_price;
        todayHotAuctionView.purchase_deadline = model.purchase_deadline;
        
        [self.assistView addSubview:todayHotAuctionView];
        
        self.viewY += todayHotAuctionView.height;
        
    }
    
    self.scrollView.contentSize = CGSizeMake(0, self.viewY + 104);

}

// 加载明日预拍
-(void)loadTomorrowAuctionView
{
    self.viewY = 0;
    for (long i = _array.count / 4; i < _array.count / 4 * 2; i++)
    {
        
        self.viewY += 12;
        DSZCQAuctionmodel *model = _array[i];
        DSZCQTomorrowViewCell *historyAuctionView = [DSZCQTomorrowViewCell createDSZCQTomorrowViewCell];
        historyAuctionView.frame = CGRectMake(12, self.viewY, 1000, 645);
        historyAuctionView.image_url = model.image_url;
        historyAuctionView.title = model.title;
        historyAuctionView.list_price = model.list_price;
        
        [self.mainView addSubview:historyAuctionView];
        
        self.viewY += historyAuctionView.height;
        
    }
}

- (void)loadHistoryAuctionView
{
    self.viewY = 0;
    for (long i = _array.count / 4 * 2; i < _array.count / 4 * 3; i++)
    {
        
        self.viewY += 12;
        DSZCQAuctionmodel *model = _array[i];
        DSZCQHistoryViewCell *tomorrowAuctionView = [DSZCQHistoryViewCell createDSZCQHistoryViewCell];
        tomorrowAuctionView.frame = CGRectMake(12, self.viewY, 1000, 645);
        tomorrowAuctionView.image_url = model.image_url;
        tomorrowAuctionView.title = model.title;
        tomorrowAuctionView.list_price = model.list_price;
        [self.mainView addSubview:tomorrowAuctionView];
        
        self.viewY += tomorrowAuctionView.height;
        
    }
}

- (void)loadMineAuctionView
{
    self.viewY = 0;
    for (long i = _array.count / 4 * 3; i < _array.count; i++)
    {
        
        self.viewY += 12;
        DSZCQAuctionmodel *model = _array[i];
        DSZCQHistoryViewCell *tomorrowAuctionView = [DSZCQHistoryViewCell createDSZCQHistoryViewCell];
        tomorrowAuctionView.frame = CGRectMake(12, self.viewY, 1000, 645);
        tomorrowAuctionView.image_url = model.image_url;
        tomorrowAuctionView.title = model.title;
        tomorrowAuctionView.list_price = model.list_price;
        [self.mainView addSubview:tomorrowAuctionView];
        
        self.viewY += tomorrowAuctionView.height;
        
    }
}

- (void)clickTopBtnWithIndex:(NSInteger)index
{
    [_mainView removeFromSuperview];
    
    // 添加主视图
    UIView *mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 44, self.view.width, 10000)];
    mainView.userInteractionEnabled = YES;
    self.mainView = mainView;
    [_scrollView addSubview:mainView];
    
    if (index == 0) {
        
        [self loadTodayHotAuctionBtnsView];
    }else if(index == 1){
    
        [self loadTomorrowAuctionView];
    }else if (index == 2){
    
        [self loadHistoryAuctionView];
    }else{
    
        [self loadMineAuctionView];
    }
    
    
}

- (void)clickHotAuctionBtnWithIndex:(NSInteger)index
{
    [self.assistView removeFromSuperview];
    
    [self loadTodayHotAuctionView:index];
}

//- (void)back
//{
//    
//    [self.navigationController popViewControllerAnimated:YES];
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    if (self.view.window == nil)
    {
        self.view = nil;
    }
}

@end
