//
//  DSZCQOptionalView.m
//  8.1苏宁ipad
//
//  Created by app20 on 15/8/5.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZCQOptionalView.h"

@implementation DSZCQOptionalView

+ (instancetype)createDSZCQOptionalView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"DSZCQOptionalView" owner:nil options:nil] lastObject];
}

- (IBAction)protocolControllerBtn {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"protocol" object:self];
}

- (IBAction)protocolBtn:(UIButton *)sender {
    
    if (sender.selected) {
        
        sender.selected = NO;
        
    }else{
    
        sender.selected = YES;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"protocolBtn" object:self];
    }
}

- (IBAction)feesTipBtn:(UIButton *)sender {
    
    if (sender.selected) {
        
        sender.selected = NO;
    }else{
        
        sender.selected = YES;
    }
}



@end
