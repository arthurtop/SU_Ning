//
//  DSZZHMAddressHeaderView.m
//  8.1苏宁ipad
//
//  Created by app01 on 15/8/4.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZZHMAddressHeaderView.h"

@implementation DSZZHMAddressHeaderView

-(instancetype)init{
    return  [[NSBundle mainBundle]loadNibNamed:@"DSZZHMAddressHeaderView" owner:self options:nil][0];
}


//新增地址
- (IBAction)addNewAddress:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(addClick)]) {
        [self.delegate addClick];
    }
}
@end
