//
//  DSZCQHelpView.m
//  8.1苏宁ipad
//
//  Created by app20 on 15/8/5.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZCQHelpView.h"

@implementation DSZCQHelpView

+ (instancetype)createDSZCQHelpView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"DSZCQHelpView" owner:nil options:nil] lastObject];
}

-(void)awakeFromNib
{
    _textView.editable = NO;
}

@end
