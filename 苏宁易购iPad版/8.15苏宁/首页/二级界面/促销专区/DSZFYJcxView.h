//
//  DSZFYJcxView.h
//  8.1苏宁ipad
//
//  Created by app05 on 15/8/5.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol FYJCXMiddleBtnDelegate <NSObject>

-(void)clickFYJCXMiddleBtnWithSender:(UIButton *)sender;

@end
@interface DSZFYJcxView : UIView


@property(nonatomic,weak)id<FYJCXMiddleBtnDelegate>delegate;

+(id)FYJCXMiddleView;

- (IBAction)fyjchooseBtn:(id)sender;

@end
