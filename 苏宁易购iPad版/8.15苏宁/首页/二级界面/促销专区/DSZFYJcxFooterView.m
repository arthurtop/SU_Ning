//
//  DSZFYJcxFooterView.m
//  8.1苏宁ipad
//
//  Created by app05 on 15/8/5.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZFYJcxFooterView.h"

@implementation DSZFYJcxFooterView

+(id)FYJFooterView

{
    return [[NSBundle mainBundle]loadNibNamed:@"DSZFYJcxFooterView" owner:nil options:nil][0];
}

- (IBAction)fyjfooterBtn:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(clickfyjFooterBtnWithSender:)]) {
        [self.delegate clickfyjFooterBtnWithSender:sender];
    }
}
@end
