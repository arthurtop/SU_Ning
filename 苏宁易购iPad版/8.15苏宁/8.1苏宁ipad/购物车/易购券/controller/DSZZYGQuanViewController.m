//
//  DSZZYGQuanViewController.m
//  8.1苏宁ipad
//
//  Created by app15 on 15/8/4.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZZYGQuanViewController.h"
#import "DSZZYGQuanshopView.h"
@interface DSZZYGQuanViewController ()

@end

@implementation DSZZYGQuanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"易购券";
    
    DSZZYGQuanshopView *view=[DSZZYGQuanshopView loadnib];
    view.frame=CGRectMake(0, 64, 1024, 1000);
    [self.view addSubview:view];
    
    [self loadnav];
    // Do any additional setup after loading the view.
}

-(void)loadnav{
    UIBarButtonItem *left=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"navBack"] landscapeImagePhone:nil style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    left.tintColor=[UIColor blackColor];
    self.navigationItem.leftBarButtonItem=left;
    
}

-(void)back{
    [self.navigationController popViewControllerAnimated:NO];
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
