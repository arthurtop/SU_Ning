//
//  DSZFYJYiGouView.h
//  8.1苏宁ipad
//
//  Created by app05 on 15/8/3.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol FYJYiGouBtnDelegate <NSObject>

-(void)clickYiGouBtnWithSender:(UIButton *)sender;

@end
@interface DSZFYJYiGouView : UIView
+(id)FYJYiGouView;
@property(nonatomic,weak)id<FYJYiGouBtnDelegate>delegate;

- (IBAction)FYJYiGouBtn:(id)sender;

@end
