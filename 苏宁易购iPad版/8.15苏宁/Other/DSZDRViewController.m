//
//  DSZDRViewController.m
//  8.1苏宁ipad
//
//  Created by app05 on 15/8/16.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZDRViewController.h"
#import "DSZMainController.h"
@interface DSZDRViewController ()

@end

@implementation DSZDRViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //滑动
    self.scrollView=[[UIScrollView alloc]initWithFrame:self.view.bounds];
    self.scrollView.pagingEnabled=YES;
    self.scrollView.delegate=self;
    self.scrollView.bounces=NO;
    self.scrollView.showsHorizontalScrollIndicator=NO;
    [self.view addSubview:self.scrollView];

    for (int i=0; i<4; i++) {
        UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(i*self.scrollView.frame.size.width, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height)];
        NSString *str=[NSString stringWithFormat:@"HELPER_%i",i+1];
        image.image=[UIImage imageNamed:str];
        [self.scrollView addSubview:image];
    }
    [self.scrollView setContentSize:CGSizeMake(4*self.scrollView.frame.size.width, 0)];
    
    
    //进入按钮
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(self.scrollView.frame.size.width*3+412, 643, 200, 40);
    //btn.backgroundColor=[UIColor redColor];
    [btn addTarget:self action:@selector(changeCon) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:btn];
    
}
//进入按钮
-(void)changeCon
{
    UIStoryboard *story=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DSZMainController *vc=[story instantiateViewControllerWithIdentifier:@"main"];
    UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:vc];
    [self presentViewController:nav animated:NO completion:nil];
}




@end
