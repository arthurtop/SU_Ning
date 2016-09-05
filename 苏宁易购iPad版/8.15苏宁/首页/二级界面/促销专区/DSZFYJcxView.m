//
//  DSZFYJcxView.m
//  8.1苏宁ipad
//
//  Created by app05 on 15/8/5.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZFYJcxView.h"

@implementation DSZFYJcxView

+(id)FYJCXMiddleView
{
    return [[NSBundle mainBundle]loadNibNamed:@"DSZFYJcxView" owner:nil options:nil][0];
}

- (IBAction)fyjchooseBtn:(id)sender {
    if ([self.delegate respondsToSelector:@selector(clickFYJCXMiddleBtnWithSender:)]) {
        [self.delegate clickFYJCXMiddleBtnWithSender:sender];
    }
}
@end
