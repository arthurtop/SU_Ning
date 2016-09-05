//
//  DSZCQPayViewController.m
//  8.1苏宁ipad
//
//  Created by app20 on 15/8/5.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZCQPayViewController.h"
#import "DSZCQBankView.h"
#import "Common.h"

@interface DSZCQPayViewController ()

@property(nonatomic,weak) UIImageView *imageView;
@property(nonatomic,weak) UIActivityIndicatorView *activityIndicatorView;
@end

@implementation DSZCQPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    imageView.image = [UIImage imageNamed:@"CellphonePay.png"];
    _imageView = imageView;
    [self.view addSubview:imageView];
    
    UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    _activityIndicatorView = activityIndicatorView;
    activityIndicatorView.origin = CGPointMake(self.view.width / 2 - 150, self.view.height / 2 + 100);
    [activityIndicatorView startAnimating];
    [self.view addSubview:activityIndicatorView];
    
    
    [self performSelector:@selector(loadMianView) withObject:nil afterDelay:2];
    
}

- (void)removeView
{
    [_imageView removeFromSuperview];
}

- (void)loadMianView
{
    [_activityIndicatorView stopAnimating];
    
    DSZCQBankView *payView = [DSZCQBankView createDSZCQBankView];
    payView.frame = CGRectMake(1024, 0, self.view.width, self.view.height);
    payView.price.text = _price;
    [self.view addSubview:payView];
    
    UIButton *cancelbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelbtn.frame = CGRectMake(20, 30, 50, 25);
    [cancelbtn setBackgroundImage:[UIImage imageNamed:@"blueBtn.png"] forState:UIControlStateNormal];
    [cancelbtn setTitle:@"取消" forState:UIControlStateNormal];
    [payView addSubview:cancelbtn];
    
    [cancelbtn addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.6];
    payView.frame = CGRectMake(0, 0, self.view.width, self.view.height);
    _imageView.frame = CGRectMake(-1024, 0, self.view.width, self.view.height);
    [UIView commitAnimations];
    
    [self performSelector:@selector(removeView) withObject:nil afterDelay:1];
}

- (void)cancel
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    if (self.view.window == nil)
    {
        self.view = nil;
    }
}

@end
