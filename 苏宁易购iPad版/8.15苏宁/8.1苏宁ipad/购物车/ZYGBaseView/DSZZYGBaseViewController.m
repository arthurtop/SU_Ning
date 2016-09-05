//
//  DSZZYGBaseViewController.m
//  8.1苏宁ipad
//
//  Created by app15 on 15/8/2.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZZYGBaseViewController.h"
#import "TGCover.h"
#import "Common.h"
#import "DSZZYGViewController.h"
@interface DSZZYGBaseViewController ()
{
    UINavigationController *nav;
}
@property(nonatomic,weak)DSZZYGViewController *ZYGView;
@property(nonatomic,strong)TGCover *cover;
@end

@implementation DSZZYGBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//加载遮罩
#pragma mark 显示购物车控制器
- (void)showShopCart
{
    if (nav!=nil) {
        nav.view.alpha=0;
        [nav.view removeFromSuperview];
        nav=nil;
    }
    // 1.显示遮盖
    if (_cover == nil) {
        _cover = [TGCover coverWithTarget:self action:@selector(hideShopCart)];
        [self.view bringSubviewToFront:_cover];
    }
    _cover.frame = CGRectMake(0, 0, self.view.width, self.view.height);
    
    _cover.alpha = 0;
    [UIView animateWithDuration:0.5 animations:^{
        [_cover reset];
        
    }];
    [self.view addSubview:_cover];
    
    // 显示购物车
    DSZZYGViewController *conView=[[DSZZYGViewController alloc]init];
    _ZYGView=conView;
    UINavigationController *na=[[UINavigationController alloc]initWithRootViewController:_ZYGView];
    //[na.view setBackgroundColor:[UIColor blueColor]];
    na.view.frame=CGRectMake(self.view.width, 0, 800, self.view.height);
    nav=na;
    [self.view addSubview:nav.view];
    [self addChildViewController:nav];
    
    [UIView animateWithDuration:0.5 animations:^{
        CGRect f = na.view.frame;
        f.origin.x -=800;
        na.view.frame = f;
    }];
}


#pragma mark 隐藏详情控制器
- (void)hideShopCart
{
    //[self.leftView didntSelected];
    [UIView animateWithDuration:0.5 animations:^{
        // 1.隐藏遮盖
        _cover.alpha = 0;
        
        // 2.隐藏控制器
        CGRect f = nav.view.frame;
        f.origin.x += 800;
        nav.view.frame = f;
    } completion:^(BOOL finished) {
        [_cover removeFromSuperview];
        [nav.view removeFromSuperview];
        [nav removeFromParentViewController];
    }];
    
    
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
