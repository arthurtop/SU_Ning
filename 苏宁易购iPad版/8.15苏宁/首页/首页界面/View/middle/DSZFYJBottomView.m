//
//  DSZFYJBottomView.m
//  8.1苏宁ipad
//
//  Created by app05 on 15/8/3.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZFYJBottomView.h"

@implementation DSZFYJBottomView

+(id)FYJBottomBtnView
{
    return [[NSBundle mainBundle]loadNibNamed:@"DSZFYJBottomView" owner:nil options:nil][0];
}

- (IBAction)FYJBottomBtn:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(clickBottomBtnWithSender:)]) {
        [self.delegate clickBottomBtnWithSender:sender];
    }
}
@end
