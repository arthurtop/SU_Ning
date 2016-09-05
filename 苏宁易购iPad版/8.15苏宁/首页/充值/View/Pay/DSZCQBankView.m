//
//  DSZCQBankView.m
//  8.1苏宁ipad
//
//  Created by app20 on 15/8/6.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZCQBankView.h"

@implementation DSZCQBankView

+ (instancetype)createDSZCQBankView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"DSZCQBankView" owner:nil options:nil] lastObject];
}

@end
