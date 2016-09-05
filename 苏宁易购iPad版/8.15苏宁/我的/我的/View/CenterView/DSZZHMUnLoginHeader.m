//
//  DSZZHMUnLoginHeader.m
//  8.1苏宁ipad
//
//  Created by app01 on 15/8/3.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZZHMUnLoginHeader.h"

@implementation DSZZHMUnLoginHeader

- (void)awakeFromNib {
    
    _loginBtn.layer.cornerRadius = 3;
    _loginBtn.layer.masksToBounds = YES;
    
}

- (IBAction)loginAction:(UIButton *)sender {
    if (_loginBlock) {
        _loginBlock();
    }
}
@end
