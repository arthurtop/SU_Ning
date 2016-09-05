//
//  askHeadView.m
//  8.2二级界面
//
//  Created by app33 on 15/8/4.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "askHeadView.h"

@implementation askHeadView

+(id)createAskHeadView
{
    return [[[NSBundle mainBundle]loadNibNamed:@"askHeadView" owner:nil options:nil]lastObject];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
