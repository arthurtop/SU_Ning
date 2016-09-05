//
//  DSZFYJBtnView.h
//  8.1苏宁ipad
//
//  Created by app05 on 15/8/3.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FYJBtnDelegate <NSObject>

-(void)clickBtnWithSender:(UIButton *)sender;

@end
@interface DSZFYJBtnView : UIView


+(id)FYJBtnView;

- (IBAction)FYJBtn:(id)sender;

@property(nonatomic,weak)id<FYJBtnDelegate>delegate;


@end
