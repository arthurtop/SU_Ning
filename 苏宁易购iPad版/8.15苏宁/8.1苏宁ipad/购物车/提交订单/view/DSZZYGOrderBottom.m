//
//  DSZZYGOrderBottom.m
//  8.1苏宁ipad
//
//  Created by app15 on 15/8/3.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZZYGOrderBottom.h"

@implementation DSZZYGOrderBottom

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)awakeFromNib{
    _upOrder.layer.cornerRadius=5;
}

- (IBAction)upActionOrder:(UIButton *)sender {
    
    [self.delegate poshsuccess];
}

+(instancetype)loadnib{
    return [[[NSBundle mainBundle]loadNibNamed:@"DSZZYGOrderBottom" owner:nil options:nil]lastObject];
}
@end
