//
//  DSZZYGShopBottom.m
//  8.1苏宁ipad
//
//  Created by app15 on 15/8/2.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZZYGShopBottom.h"

@implementation DSZZYGShopBottom

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)awakeFromNib{
    _Paybtn.layer.cornerRadius=5;
}
- (IBAction)actionBtn:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(pushOrder)]) {
        [self.delegate pushOrder];
    }
}

- (IBAction)selectbtn:(UIButton *)sender {
    if(sender.selected){
        sender.selected=NO;
        [self.delegate delshopname];
    }
    else{
        sender.selected=YES;
        [self.delegate addshopname];
    }

    
}


+(instancetype)loadNib{
    
    return [[[NSBundle mainBundle]loadNibNamed:@"DSZZYGShopBottom" owner:nil options:nil]lastObject];
}

@end
