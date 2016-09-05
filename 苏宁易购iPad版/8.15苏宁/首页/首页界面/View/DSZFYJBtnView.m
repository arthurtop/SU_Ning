//
//  DSZFYJBtnView.m
//  8.1苏宁ipad
//
//  Created by app05 on 15/8/3.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZFYJBtnView.h"


@implementation DSZFYJBtnView

+(id)FYJBtnView
{
    return [[NSBundle mainBundle] loadNibNamed:@"DSZFYJBtnView" owner:nil options:nil][0];
}

- (IBAction)FYJBtn:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(clickBtnWithSender:)]) {
        [self.delegate clickBtnWithSender:sender];
        
    }
}
@end
