//
//  DSZFYJMiddleView.m
//  8.1苏宁ipad
//
//  Created by app05 on 15/8/3.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZFYJMiddleView.h"

@implementation DSZFYJMiddleView

+(id)FYJMiddleView
{
    return [[NSBundle mainBundle]loadNibNamed:@"DSZFYJMiddleView" owner:nil options:nil][0];
}


- (IBAction)FyjmiddleBtn:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(clickMiddleBtnWithSender:)]) {
        [self.delegate clickMiddleBtnWithSender:sender];
    }
}
@end
