//
//  DSZZYGOrderHeader.m
//  8.1苏宁ipad
//
//  Created by app15 on 15/8/6.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZZYGOrderHeader.h"

@implementation DSZZYGOrderHeader

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+(instancetype)loadNib{
    return [[[NSBundle mainBundle]loadNibNamed:@"DSZZYGOrderHeader" owner:nil options:nil]lastObject];
}
@end
