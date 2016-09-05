//
//  DSZZYGQuanView.m
//  8.1苏宁ipad
//
//  Created by app15 on 15/8/5.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZZYGQuanshopView.h"

@implementation DSZZYGQuanshopView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)changeView:(UIButton *)sender {
    if (sender.tag==0) {
        self.detailLabel.text=@"无此订单可用优惠券";
        self.addView.hidden=NO;
        self.tuijianView.hidden=NO;
        CGRect frame =self.lineView.frame;
        frame.origin.x=0;
        self.lineView.frame=frame;
    }else{
        self.detailLabel.text=@"无此订单不可用优惠券";
        self.addView.hidden=YES;
        self.tuijianView.hidden=YES;
        CGRect frame =self.lineView.frame;
        frame.origin.x=400;
        self.lineView.frame=frame;
    }
}

+(instancetype)loadnib{
    return [[[NSBundle mainBundle]loadNibNamed:@"DSZZYGQuanshopView" owner:nil options:nil]lastObject];
}
@end
