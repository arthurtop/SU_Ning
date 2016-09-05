//
//  DSZHelpViewController.m
//  8.1苏宁ipad
//
//  Created by app20 on 15/8/5.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZHelpViewController.h"
#import "DSZSYFtopView.h"
#import "DSZCQHelpView.h"
#import "Common.h"
#import "DSZSYFtopejNavView.h"
#import "DSZFYJSaoMiaoViewController.h"
#import "DSZSYFSSViewController.h"
#import "DSZZHMMineViewController.h"
@interface DSZHelpViewController ()<DSZSYFtopejNavViewDelegate>

@end

@implementation DSZHelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
//    // 自定义导航栏
//    DSZSYFtopView *topView = [DSZSYFtopView createTopView];
//    topView.frame = CGRectMake(0, 20, self.view.width, 44);
//    topView.leftTextField.left = 45;
//    topView.myBtn.right = self.view.width - 30;
//    topView.buysBtn.right = self.view.width - 90;
//    topView.homeBtn.hidden = NO;
//    topView.homeBtn.right = self.view.width - 150;
//    [self.view addSubview:topView];
//    
//    [topView.homeBtn addTarget:self action:@selector(home) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    DSZSYFtopejNavView *nav=[DSZSYFtopejNavView createNavView];
    nav.frame=CGRectMake(0, 20, self.view.width, 44);
    [nav setbtnTitle];
    nav.delegate=self;
    [self.view addSubview:nav];
    
    __weak DSZHelpViewController *main=self;
    
    nav.myblock=^{
        
        DSZFYJSaoMiaoViewController *saomiao=[[DSZFYJSaoMiaoViewController alloc]init];
        saomiao.modalPresentationStyle=UIModalPresentationFormSheet;
        [main  presentViewController:saomiao animated:YES completion:nil];
    };
    
    
    
    [self.view addSubview:nav];
    
//    // 向导航栏添加返回按钮
//    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    backBtn.frame = CGRectMake(15, 12, 12, 20);
//    [backBtn setBackgroundImage:[UIImage imageNamed:@"nav_back_normal.png"] forState:UIControlStateNormal];
//    [topView addSubview:backBtn];
    
//    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    // 添加导航栏与主视图分割线
    UIView *topLine = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, 1)];
    topLine.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:topLine];
    
    // 添加帮助视图
    DSZCQHelpView *help = [DSZCQHelpView createDSZCQHelpView];
    help.frame = CGRectMake(0, 65, self.view.width, self.view.height);
    [self.view addSubview:help];
    
    if (_index == 101) {
        
        NSString *title = @"话费充值帮助";
        help.title.text = title;
//        help.textView.hidden = NO;
        
    }else if (_index == 102){
    
        NSString *title = @"水电煤缴费帮助";
        help.title.text = title;
        help.textView.hidden = YES;
    }else{
    
        NSString *title = @"自助缴费协议";
        help.title.text = title;
        help.protocol.hidden = NO;
    }
    
}

#pragma mark----导航栏代理
-(void)returnDelegate
{
    //[self.navigationController popToRootViewControllerAnimated:YES];
    [self.navigationController popViewControllerAnimated:YES];
    
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


@end
