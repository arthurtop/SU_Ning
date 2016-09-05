//
//  DSZSYFLeftCell.m
//  8.1苏宁ipad
//
//  Created by lovena on 15/8/1.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZSYFLeftCell.h"

@implementation DSZSYFLeftCell

+(id)createCell
{
    return[[[NSBundle mainBundle]loadNibNamed:@"DSZSYFLeftCell" owner:nil options:nil] lastObject];
}

@end
