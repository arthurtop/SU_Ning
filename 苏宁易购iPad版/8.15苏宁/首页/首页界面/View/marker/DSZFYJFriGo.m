//
//  DSZFYJFriGo.m
//  8.1苏宁ipad
//
//  Created by app05 on 15/8/3.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZFYJFriGo.h"

@implementation DSZFYJFriGo

+(id)FYJFriGoView
{
    return [[NSBundle mainBundle]loadNibNamed:@"DSZFYJFriGo" owner:nil options:nil][0];
}

- (IBAction)FYJFriendGo:(id)sender {
    if ([self.delegate respondsToSelector:@selector(clickFriGoBtnWithSender:)]) {
        [self.delegate clickFriGoBtnWithSender:sender];
    }
    
}
@end
