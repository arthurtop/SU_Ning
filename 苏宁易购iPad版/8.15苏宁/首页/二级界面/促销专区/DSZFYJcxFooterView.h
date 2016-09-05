//
//  DSZFYJcxFooterView.h
//  8.1苏宁ipad
//
//  Created by app05 on 15/8/5.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol FYJFooterDelegate <NSObject>

-(void)clickfyjFooterBtnWithSender:(UIButton *)sender;

@end
@interface DSZFYJcxFooterView : UIView

+(id)FYJFooterView;
@property(nonatomic,weak)id<FYJFooterDelegate>delegate;

- (IBAction)fyjfooterBtn:(id)sender;

@end
