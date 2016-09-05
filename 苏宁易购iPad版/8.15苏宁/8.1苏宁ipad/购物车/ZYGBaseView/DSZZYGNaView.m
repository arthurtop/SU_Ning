//
//  DSZZYGNaView.m
//  8.1苏宁ipad
//
//  Created by app15 on 15/8/5.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZZYGNaView.h"

@implementation DSZZYGNaView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+(instancetype)loadnib{
    return [[[NSBundle mainBundle]loadNibNamed:@"DSZZYGNaView" owner:nil options:nil]lastObject];
}
@end
