//
//  DSZZHMNoHistoryView.m
//  8.1苏宁ipad
//
//  Created by app01 on 15/8/3.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZZHMNoHistoryView.h"

@implementation DSZZHMNoHistoryView


-(void)awakeFromNib{
    _goBtn.layer.cornerRadius = 3;
    _goBtn.layer.masksToBounds = YES;
}

-(instancetype)init{
    return [[NSBundle mainBundle]loadNibNamed:@"DSZZHMNoHistoryView" owner:self options:nil][0];
}



- (IBAction)goAction:(UIButton *)sender {
    if (_goBlock) {
        _goBlock();
    }
}
@end
