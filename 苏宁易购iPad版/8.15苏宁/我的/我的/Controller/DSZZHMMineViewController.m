//
//  DSZZHMMineViewController.m
//  8.1苏宁ipad
//
//  Created by app01 on 15/8/2.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZZHMMineViewController.h"
#import "DSZZHMCenterViewController.h"
#import "DSZZHMAdressViewController.h"
#import "DSZZHMYigouquanViewController.h"
#import "DSZZHMMyOrderViewController.h"
#import "DSZZHMCollectionViewController.h"
#import "DSZMainController.h"
#import "MBProgressHUD+MJ.h"
#import "DSZZHMNavBar.h"
#import "DSZZHMMineDock.h"
#import "Common.h"
#import "UIImage+Fit.h"
#import "TGCover.h"
#import "DSZSYFSSViewController.h"


#define DeivceWidth self.view.frame.size.width
#define DeivceHeight self.view.frame.size.height

#define kFilePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"login.data"]


@interface DSZZHMMineViewController ()<DSZFYJNavViewDelegate,DSZZHMDockDelegate>
{
    DSZZHMNavBar *navBar ;
}
@property(weak,nonatomic)DSZZHMMineDock *dockView;
@property(weak,nonatomic)DSZZHMNavBar *navBar;
@property(weak,nonatomic)UIView *contentView;

@property(copy,nonatomic)NSString  *tel;
@property(weak,nonatomic)TGCover  *cover;
@property(weak,nonatomic)DSZZHMLoginView  *loginView;

@end

@implementation DSZZHMMineViewController


-(void)viewWillLayoutSubviews{
    //NSLog(@"%@",kFilePath);
    _tel = [NSKeyedUnarchiver unarchiveObjectWithFile:kFilePath];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notice:) name:@"loginsuccessed" object:nil];

    
    [self loadna];

    //添加dock栏
    DSZZHMMineDock *dockView = [DSZZHMMineDock createDock];
    dockView.delegate = self;
    dockView.frame = CGRectMake(0, 64, 0, DeivceHeight - 64);
    [self.view addSubview:dockView];
    _dockView = dockView;
    
    UIView *contentView = [[UIView alloc]init];
    contentView.frame = CGRectMake(dockView.right, navBar.bottom, DeivceWidth - dockView.width,DeivceHeight - navBar.height);
    [self.view addSubview:contentView];
    _contentView = contentView;
//     NSLog(@"===========%@",NSStringFromCGRect(_contentView.frame));
    //添加字控制器
    [self addchildControllers];

    
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(void)loadna{
    //添加导航栏
    navBar = [DSZZHMNavBar createNavBar];
    [navBar setbtnTitle];
    navBar.delegate = self;
    navBar.backgroundColor = [UIColor redColor];
    navBar.frame = CGRectMake(0, 22, DeivceWidth , 44);
    [self.view addSubview:navBar];
    _navBar = navBar;
    __weak DSZZHMMineViewController *main=self;
    _navBar.myBlock=^
    {
        UIStoryboard *story=[UIStoryboard storyboardWithName:@"DSZSYFSSViewController" bundle:nil];
        DSZSYFSSViewController *vc=[story instantiateViewControllerWithIdentifier:@"sousuo"];
        [main.navigationController pushViewController:vc animated:NO];
    };
}
//添加字控制器
-(void)addchildControllers{
    
    //添加个人中心控制器
    DSZZHMCenterViewController *centerVC = [[DSZZHMCenterViewController alloc]init];
    //centerVC.view.bounds = _contentView.bounds; // 874 , 980
    centerVC.view.frame = CGRectMake(120, 64, 874, 2000);
    centerVC.view.backgroundColor = [UIColor clearColor];
    // NSLog(@"%@",NSStringFromCGRect(centerVC.view.frame));
    
    [self addChildViewController:centerVC];
    
    //添加订单控制器
    DSZZHMMyOrderViewController *orderVC = [[DSZZHMMyOrderViewController alloc]init];
    orderVC.view.backgroundColor = [UIColor clearColor];
    [self addChildViewController:orderVC];
    
    //添加我的易购券控制器
    DSZZHMYigouquanViewController *yigouVC = [[DSZZHMYigouquanViewController alloc]init];
    yigouVC.view.backgroundColor = [UIColor clearColor];
    [self addChildViewController:yigouVC];
    
    //添加我的收藏控制器
    DSZZHMCollectionViewController *collectionVC = [[DSZZHMCollectionViewController alloc]init];
    collectionVC.view.backgroundColor = [UIColor clearColor];
    [self addChildViewController:collectionVC];
    
    //添加地址管理控制器
    DSZZHMAdressViewController *addressVC = [[DSZZHMAdressViewController alloc]init];
    addressVC.view.backgroundColor = [UIColor clearColor];
    [self addChildViewController:addressVC];
    
    //设置默认选中的控制器
    [self dock:nil ViewChangeFrom:10 to:10];
   
    
}


#pragma mark dock栏的点击代理

//点击dock栏
-(void)dock:(DSZZHMMineDock *)dock ViewChangeFrom:(NSInteger)from to:(NSInteger)to{
    
    UIViewController *old = self.childViewControllers[from-10];
    TGCover *cover =(TGCover *)[old.view viewWithTag:100];
    cover.hidden = YES;
    [cover removeFromSuperview];

    [old.view removeFromSuperview];
    UIViewController *new = self.childViewControllers[to-10];
    new.view.frame = _contentView.frame;
    new.view.origin = CGPointZero;
    
    if (_tel == nil && to != 10 ) {
        
        //if (_cover == nil) {
            TGCover *cover = [TGCover coverWithTarget:self action:@selector(hideCover:)];
            cover.frame = CGRectMake(0, 0, new.view.bounds.size.width, new.view.bounds.size.height);
            cover.tag = 100;
            _cover = cover;
        //}
            [new.view addSubview:_cover];
            _cover.hidden = NO;
        
        if (_loginView == nil) {
            DSZZHMLoginView *login = [[DSZZHMLoginView alloc]init];
            login.frame = CGRectMake(new.view.center.x-175, new.view.center.y-200,0, 0);
            _loginView = login;

        }
        CAKeyframeAnimation *scale = [CAKeyframeAnimation animation];
        scale.keyPath = @"transform.scale";
        scale.values = @[@(0.0),@(1.0)];
        scale.duration = 0.6;
        scale.removedOnCompletion = NO;
        scale.fillMode = kCAFillModeForwards;
        [_loginView.layer addAnimation:scale forKey:nil];
        
        //登陆或注册
        [new.view addSubview:_loginView];
        [new.view insertSubview:_loginView aboveSubview:_cover];


    }
    
    [_contentView addSubview:new.view];
    
    
    
}


//隐藏登录界面
-(void)hideCover:(UITapGestureRecognizer *)tap  {
    
    
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
    
    _cover.hidden = YES;
    [_cover removeFromSuperview];
    _cover = nil;
    
    
    [self loadna];
    
}

//保留通知传递的参数
-(void)notice:(NSNotification *)notification{
    
    _tel = notification.object;
    
    [NSKeyedArchiver archiveRootObject:_tel toFile:kFilePath];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"loginsuccess1" object:nil];
    
    [self hideCover:nil];
}



//退出登录
-(void)exit{
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"exit" object:nil];
    [MBProgressHUD showSuccess:@"退出成功" toView:self.view];
    
    [self loadna];
}




#pragma mark 导航栏的点击代理
-(void)didclickNavBtn:(UIButton *)btn{
    
    if(btn.tag == 101){

        //[self.navigationController popViewControllerAnimated:YES];
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }if (btn.tag == 102) {
        [self showShopCart];
    }
        
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
