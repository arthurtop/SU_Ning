//
//  DSZFYJCuxiaoRoomViewController.m
//  8.1苏宁ipad
//
//  Created by app05 on 15/8/4.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZFYJCuxiaoRoomViewController.h"
#import "DSZSYFtopejNavView.h"
#import "DSZFYJCXHeaderView.h"
#import "UIViewExt.h"
#import "DSZFYJcxFooterView.h"
#import "DSZFYJcxView.h"
#import "DSZZHMMineViewController.h"
#import "DSZSYFSSViewController.h"
#import "DSZSYFejMainViewController.h"
#import "DSZFYJSaoMiaoViewController.h"
@interface DSZFYJCuxiaoRoomViewController ()<DSZSYFtopejNavViewDelegate,FYJCXMiddleBtnDelegate,FYJCXHeaderDelegate,FYJFooterDelegate>

@property(nonatomic,retain)NSArray *labelArr;

@property(nonatomic,retain)UIScrollView *scrollView;
@property(nonatomic,retain)DSZFYJCXHeaderView *header;
@property(nonatomic,retain)DSZFYJcxView *middle;

@end

@implementation DSZFYJCuxiaoRoomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view .backgroundColor=[UIColor whiteColor];
    self.labelArr=[NSArray array];
    self.labelArr=@[@"手机",@"手机",@"手机",@"酒水",@"厨房",@"婴儿用品",@"生活用品",@"床上用品",@"生活用品",@"女装",@"内衣",@"男装",@"运动鞋服",@"户外",@"健身"];
    
    
    
    self.scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 44, self.view.width, self.view.height-44)];
    self.scrollView.contentSize=CGSizeMake(self.view.width, 2780);
    self.scrollView.showsVerticalScrollIndicator=NO;
    self.scrollView.showsHorizontalScrollIndicator=NO;
    self.scrollView.bounces=NO;
    
    [self.view addSubview:self.scrollView];
    
    [self addNav];
    
    [self addHeader];
    
    [self addMiddle];
    
    [self addFooter];
    
}

-(void)addNav
{
    DSZSYFtopejNavView *nav=[DSZSYFtopejNavView createNavView];
    nav.frame=CGRectMake(0, 20, self.view.width, 44);
    nav.delegate=self;
    [nav setbtnTitle];
    [self.view addSubview:nav];
    
    __weak DSZFYJCuxiaoRoomViewController *main=self;
    nav.myblock=^{
        
        DSZFYJSaoMiaoViewController *saomiao=[[DSZFYJSaoMiaoViewController alloc]init];
        saomiao.modalPresentationStyle=UIModalPresentationFormSheet;
        [main  presentViewController:saomiao animated:YES completion:nil];
    };

}

-(void)addHeader
{
    DSZFYJCXHeaderView *header=[DSZFYJCXHeaderView FYJCXHeaderView];
    header.delegate=self;
    self.header=header;
    self.header.frame=CGRectMake(0, 0, self.view.width, header.height);
    [self.scrollView addSubview:self.header];
}
-(void)addMiddle
{
    DSZFYJcxView *middle=[DSZFYJcxView FYJCXMiddleView];
    middle.delegate=self;
    middle.frame=CGRectMake(0, self.header.bottom, self.view.width, middle.height);
    self.middle=middle;
    [self.scrollView addSubview:self.middle];
    
}
-(void)addFooter
{
    DSZFYJcxFooterView *footer=[DSZFYJcxFooterView FYJFooterView];
    footer.delegate=self;
    footer.frame=CGRectMake(0, self.middle.bottom, self.view.width, footer.height);
    [self.scrollView addSubview:footer];
}
#pragma mark-----导航栏代理
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

-(void)returnDelegate
{
    [self.navigationController popViewControllerAnimated:YES];
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
    [self.navigationController pushViewController:vc animated:NO];
}
#pragma mark---view代理
-(void)clickFYJCXMiddleBtnWithSender:(UIButton *)sender
{
    NSString *str=_labelArr[sender.tag];
    //通知
    NSDictionary *dic=@{@"catclass":str};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"cxgoto" object:nil userInfo:dic];
    //传值
    DSZSYFejMainViewController *vc=[[DSZSYFejMainViewController alloc]init];
    vc.catClass=str;
    [self.navigationController pushViewController:vc animated:NO];
    //[self presentViewController:vc animated:NO completion:nil];
    
}
-(void)clickFYJCXHeaderBtnWiteSender:(UIButton *)sender
{
    NSString *str;
    if(sender.tag==0)
    {
      str=@"空调";
    }
    else
    {
        str=@"婴儿用品";
    }
    //通知
    NSDictionary *dic=@{@"catclass":str};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"cxgoto" object:nil userInfo:dic];
    //传值
    DSZSYFejMainViewController *vc=[[DSZSYFejMainViewController alloc]init];
    vc.catClass=str;
    [self.navigationController pushViewController:vc animated:NO];
    //[self presentViewController:vc animated:NO completion:nil];

}
-(void)clickfyjFooterBtnWithSender:(UIButton *)sender
{
    //通知
    NSDictionary *dic=@{@"catclass":@"电器"};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"cxgoto" object:nil userInfo:dic];
    //传值
    DSZSYFejMainViewController *vc=[[DSZSYFejMainViewController alloc]init];
    vc.catClass=@"电器";
    [self.navigationController pushViewController:vc animated:NO];
    //[self presentViewController:vc animated:NO completion:nil];
}
@end
