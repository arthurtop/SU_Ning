//
//  DSZZYGshopTopView.h
//  8.1苏宁ipad
//
//  Created by app15 on 15/8/6.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DSZZYGshopTopView;
@protocol DSZZYGshopTopViewDelegate <NSObject>

-(void)login;

@end
@interface DSZZYGshopTopView : UIView
- (IBAction)login:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UILabel *loginLabel;
@property(nonatomic,weak)id<DSZZYGshopTopViewDelegate>delegate;
+(instancetype)loadnib;
@end
