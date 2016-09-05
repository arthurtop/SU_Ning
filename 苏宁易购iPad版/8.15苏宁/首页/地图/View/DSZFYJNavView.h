//
//  DSZFYJNavView.h
//  8.1苏宁ipad
//
//  Created by app05 on 15/8/2.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DSZFYJNavView;
@protocol DSZFYJNavViewDelegate <NSObject>

-(void)didclickNavBtn:(UIButton *)btn;//代理

@end
@interface DSZFYJNavView : UIView

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;//导航标题

@property (weak, nonatomic) IBOutlet UIButton *homeBtn;//主页按钮

- (IBAction)clickBtn:(UIButton *)sender;

@property(nonatomic,weak)id<DSZFYJNavViewDelegate>delegate;

@property(nonatomic,copy)NSString *titleLabelText;//导航栏标题接收内容参数

+(id)createNavView;

@end
