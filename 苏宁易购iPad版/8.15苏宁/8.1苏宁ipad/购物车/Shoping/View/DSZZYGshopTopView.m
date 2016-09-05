//
//  DSZZYGshopTopView.m
//  8.1苏宁ipad
//
//  Created by app15 on 15/8/6.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZZYGshopTopView.h"



@implementation DSZZYGshopTopView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)login:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(login)]) {
        [self.delegate login];
    }
  

}

-(void)awakeFromNib{
    _loginBtn.layer.cornerRadius=5;
}
+(instancetype)loadnib{
    return [[[NSBundle mainBundle]loadNibNamed:@"DSZZYGshopTopView" owner:nil options:nil]lastObject];
}

@end
