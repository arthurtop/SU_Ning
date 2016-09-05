//
//  DSZMainController.m
//  8.1苏宁ipad
//
//  Created by lovena on 15/8/1.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZMainController.h"
#import "DSZSYFtopView.h"
#import "Common.h"
#import "DSZSYFFJView.h"
#import "TGCover.h"
#import "DSZFYJTotalPageView.h"
#import "DSZFYJSaoMiaoViewController.h"
#import "DSZSYFejMainViewController.h"
#import "DSZSYFSSViewController.h"
#import "DSZSYFejBigMainViewController.h"
#import "DSZFYJMapViewController.h"
#import "DSZFYJLocationTool.h"
#import "DSZFYJCuxiaoRoomViewController.h"
#import "DSZZYGshopDatabase.h"
#import "DSZZHMMineViewController.h"
#import "DSZSYFSSViewController.h"
#import "DSZCQRechargeViewController.h"
#import "DSZCQAuctionController.h"

#define kFilePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"login.data"]

@interface DSZMainController ()<DSZSYFtopViewDelegate,DSZFYJTotalPageViewDelegate,DSZSYFLeftviewDelegate,DSZSYFFJViewDelegate,MJRefreshBaseViewDelegate>
@property(nonatomic,weak)UIView *contentView;//主题部分
@property(nonatomic,strong)TGCover *cover;
@property(nonatomic,weak)DSZSYFFJView *conView;//表
@property(nonatomic,weak)MJRefreshHeaderView *headerView;
@end

@implementation DSZMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.view.backgroundColor=[UIColor blackColor];
    self.navigationController.navigationBarHidden=YES;
    DSZFYJLocationTool *location=[[DSZFYJLocationTool alloc]init];
    //代理

    
    _leftView.delegate=self;
    self.view.userInteractionEnabled=YES;
    //视图分为两部分，上部44高的头，下部的主题
    //头部
    //加载顶部视图
    DSZSYFtopView *topview=[DSZSYFtopView createTopView];
    _topview=topview;
    
    DSZZYGshopDatabase  *shopbase=[[DSZZYGshopDatabase alloc]init];
    [shopbase createDatabase];
    [shopbase createTable];
    NSArray *dataarray=  [shopbase query];
    [_topview.zygBtn buyNumber: dataarray.count];
    
    [self hiddenBuyNumBtn];
    //[self Buynum:2];
    _topview.frame=CGRectMake(_leftView.right, 20, self.view.width-_leftView.width,44);
    _topview.delegate=self;
    [self.view addSubview:_topview];
    __weak DSZMainController *main=self;
    
    //块
    _topview.myBlock=^{
    
        UIStoryboard *story=[UIStoryboard storyboardWithName:@"DSZSYFSSViewController" bundle:nil];
        DSZSYFSSViewController *vc=[story instantiateViewControllerWithIdentifier:@"sousuo"];
        [main.navigationController pushViewController:vc animated:NO];
        
    };
    
    //主题
    UIView *contentView=[[UIView alloc]initWithFrame:CGRectMake(_leftView.right, _topview.bottom, _topview.width, self.view.height-64)];
    contentView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:contentView];
    _contentView=contentView;
    
    DSZFYJTotalPageView *totalPage=[[DSZFYJTotalPageView alloc]initWithFrame:CGRectMake(0, 0, self.contentView.size.width, 2000)];
    totalPage.delegate=self;
    [self.contentView addSubview:totalPage];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(linkToClickSaoBtn) name:@"clickSaoMiaoBtn" object:nil];
   
    
    //接通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gotonext:) name:@"cellstr" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideDetail) name:@"hiddenView" object:nil];
    
    
    //刷新
    MJRefreshHeaderView *headerView=[MJRefreshHeaderView header];
    headerView.scrollView = totalPage;
    headerView.delegate = self;
    _headerView=headerView;
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    if (self.view.window==nil) {
        self.view=nil;
    }
}


- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    [self performSelector:@selector(stop) withObject:nil afterDelay:3];
}

-(void)stop
{
    [_headerView endRefreshing];
}
//代理
-(void)FYJdidselectedController
{
    DSZSYFejBigMainViewController *vc=[[DSZSYFejBigMainViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
//购买数量
-(void)Buynum:(NSInteger)number{
    DSZZYGshopDatabase  *shopbase=[[DSZZYGshopDatabase alloc]init];
    [shopbase createDatabase];
    [shopbase createTable];
    NSArray *dataarray=  [shopbase query];
    [_topview.zygBtn buyNumber: dataarray.count];
   }

-(void)hiddenBuyNumBtn{
     _tel = [NSKeyedUnarchiver unarchiveObjectWithFile:kFilePath];
    int num=1;
    DSZZYGshopDatabase  *shopbase=[[DSZZYGshopDatabase alloc]init];
    [shopbase createDatabase];
    [shopbase createTable];
    NSArray *dataarray=  [shopbase query];
    int number=dataarray.count;
    if (num==1) {
        if (number==0) {
             _topview.buyNumBtn.hidden=YES;
        }else{
        _topview.buyNumBtn.hidden=NO;
        [_topview.buyNumBtn setTitle:[NSString stringWithFormat:@"%i",number] forState:UIControlStateNormal];
        }
    }else{
        _topview.buyNumBtn.hidden=YES;
    }
}
//通知方法
-(void)gotonext:(NSNotification *)user
{
    NSDictionary *dic=user.userInfo;
    NSString *str=dic[@"str"];
    DSZSYFejMainViewController *vc=[[DSZSYFejMainViewController alloc]init];
    vc.catClass=str;
    [self.navigationController pushViewController:vc animated:YES];
}


-(void)linkToClickSaoBtn
{
    DSZFYJSaoMiaoViewController *saomiao=[[DSZFYJSaoMiaoViewController alloc]init];
    saomiao.modalPresentationStyle=UIModalPresentationFormSheet;
    [self  presentViewController:saomiao animated:YES completion:nil];
}
#pragma mark--- 代理
//代理
-(void)didselectedCell
{
    [self showDetail];
}

-(void)sectionDidselectedNsttring:(NSString *)str
{
    DSZSYFejMainViewController *vc=[[DSZSYFejMainViewController alloc]init];
    vc.catClass=str;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)FYJdidBtnToControllerWithTag:(NSInteger)tag
{
    if (tag==0) {
        DSZFYJCuxiaoRoomViewController *root=[[DSZFYJCuxiaoRoomViewController alloc]init];
        [self.navigationController pushViewController:root animated:YES];
    }else if (tag==1) {
        
        DSZCQAuctionController *auctionVC = [[DSZCQAuctionController alloc]init];
        [self.navigationController pushViewController:auctionVC animated:YES];
    }else if (tag==2) {
        DSZZHMMineViewController *mineVC = [[DSZZHMMineViewController alloc]init];
        [self.navigationController pushViewController:mineVC animated:YES];
    }else if (tag==4) {
        DSZCQRechargeViewController *rechargeVC = [[DSZCQRechargeViewController alloc]init];
        [self.navigationController pushViewController:rechargeVC animated:YES];
    }
    else
    {
        DSZFYJCuxiaoRoomViewController *root=[[DSZFYJCuxiaoRoomViewController alloc]init];
        [self.navigationController pushViewController:root animated:YES];

    }
}
-(void)didclickTopBtn:(UIButton *)btn
{
    if (btn.tag==101) {
       // NSLog(@"这是主页");
    }
    else if (btn.tag==102)
    {
        [self showShopCart];
        //NSLog(@"这是购物车");
    }
    else if (btn.tag==104)
    {
        DSZFYJMapViewController *map=[[DSZFYJMapViewController alloc]init];
        [self.navigationController pushViewController:map animated:YES];
    }
    else
    {
        DSZZHMMineViewController *mineVC = [[DSZZHMMineViewController alloc]init];
        [self.navigationController pushViewController:mineVC animated:YES];

    }
}

//加载遮罩
#pragma mark 显示详情控制器
- (void)showDetail
{
    if (_conView!=nil) {
        _conView.alpha=0;
        [_conView removeFromSuperview];
        _conView=nil;
    }
    // 1.显示遮盖
    if (_cover == nil) {
        _cover = [TGCover coverWithTarget:self action:@selector(hideDetail)];
        //[[NSNotificationCenter defaultCenter] postNotificationName:@"leftViewDidSelected" object:nil];
        
    }
    _cover.frame = _contentView.bounds;
    _cover.alpha = 0;
    [UIView animateWithDuration:0.5 animations:^{
        [_cover reset];
        
    }];
    [_contentView addSubview:_cover];
    
    // 显示表
    DSZSYFFJView *conView=[[DSZSYFFJView alloc]initWithFrame:CGRectMake(-500, 0, 500,_contentView.height)];
    [_contentView addSubview:conView];
    _conView=conView;
    _conView.delegate=self;
    [self.view bringSubviewToFront:_leftView];
    [UIView animateWithDuration:0.5 animations:^{
        CGRect f = conView.frame;
        f.origin.x += 500;
        conView.frame = f;
    }];
}

#pragma mark 隐藏详情控制器
- (void)hideDetail
{
     [self.leftView didntSelected];
    [UIView animateWithDuration:0.5 animations:^{
        // 1.隐藏遮盖
        _cover.alpha = 0;
       
        // 2.隐藏控制器
        CGRect f = _conView.frame;
        f.origin.x -= 500;
        _conView.frame = f;
    } completion:^(BOOL finished) {
        [_cover removeFromSuperview];
        
        [_conView removeFromSuperview];
    }];
    
   
}


-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
