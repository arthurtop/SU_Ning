//
//  DSZFYJMiddleView.h
//  8.1苏宁ipad
//
//  Created by app05 on 15/8/3.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FYJMiddleDelegata <NSObject>

-(void)clickMiddleBtnWithSender:(UIButton *)sender;

@end
@interface DSZFYJMiddleView : UIView
- (IBAction)FyjmiddleBtn:(id)sender;

+(id)FYJMiddleView;
@property(nonatomic,weak)id<FYJMiddleDelegata>delegate;

@end
