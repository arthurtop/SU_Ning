//
//  DSZCQFeesView.m
//  8.1苏宁ipad
//
//  Created by app20 on 15/8/5.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZCQFeesView.h"

@implementation DSZCQFeesView

+ (instancetype)createDSZCQFeesView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"DSZCQFeesView" owner:nil options:nil] lastObject];
}

@end
