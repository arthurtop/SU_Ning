//
//  DSZFYJBottomView.h
//  8.1苏宁ipad
//
//  Created by app05 on 15/8/3.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol FYJBottomBtnDelegate <NSObject>

-(void)clickBottomBtnWithSender:(UIButton *)sender;

@end
@interface DSZFYJBottomView : UIView

+(id)FYJBottomBtnView;
@property(nonatomic,weak)id<FYJBottomBtnDelegate>delegate;
- (IBAction)FYJBottomBtn:(id)sender;

@end
