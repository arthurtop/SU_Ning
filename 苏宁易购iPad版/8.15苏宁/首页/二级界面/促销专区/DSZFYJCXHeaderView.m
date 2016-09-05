//
//  DSZFYJCXHeaderView.m
//  8.1苏宁ipad
//
//  Created by app05 on 15/8/4.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZFYJCXHeaderView.h"

@implementation DSZFYJCXHeaderView

+(id)FYJCXHeaderView
{
    return [[NSBundle mainBundle]loadNibNamed:@"DSZFYJCXHeaderView" owner:nil options:nil][0];
}

- (IBAction)fyjheaderBtn:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(clickFYJCXHeaderBtnWiteSender:)]) {
        [self.delegate clickFYJCXHeaderBtnWiteSender:sender];
    }
}
@end
