//
//  DSZFYJYiGouView.m
//  8.1苏宁ipad
//
//  Created by app05 on 15/8/3.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZFYJYiGouView.h"

@implementation DSZFYJYiGouView

+(id)FYJYiGouView
{
    return [[NSBundle mainBundle]loadNibNamed:@"DSZFYJYiGouView" owner:nil options:nil][0];
}

- (IBAction)FYJYiGouBtn:(id)sender {
    if ([self.delegate respondsToSelector:@selector(clickYiGouBtnWithSender:)]) {
        [self.delegate clickYiGouBtnWithSender:sender];
    }
}
@end
