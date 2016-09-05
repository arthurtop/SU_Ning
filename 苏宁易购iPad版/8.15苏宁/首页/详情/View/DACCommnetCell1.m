//
//  DACCommnetCell1.m
//  8.2二级界面
//
//  Created by app33 on 15/8/4.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DACCommnetCell1.h"

@implementation DACCommnetCell1

+(id)createCell1
{
    return [[[NSBundle mainBundle]loadNibNamed:@"DACComment1" owner:nil options:nil]lastObject];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
