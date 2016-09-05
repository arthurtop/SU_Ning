//
//  DSZZHMMineDock.m
//  8.1苏宁ipad
//
//  Created by app01 on 15/8/2.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZZHMMineDock.h"
#import "DSZZHMButton.h"


#define DockItemW 150

@implementation DSZZHMMineDock

-(void)awakeFromNib{
    
    for (DSZZHMButton *btn in _btns) {
        btn.highlighted = NO;
        if (btn.tag == 10) {
            btn.selected = YES;
            self.selectedBtn = btn;
        }
    }
    
    _exitBtn.layer.cornerRadius = 5;
    _exitBtn.layer.masksToBounds = YES;
}



+(instancetype)createDock{
    return [[NSBundle mainBundle]loadNibNamed:@"DSZZHMMineDock" owner:self options:nil][0];
    
}

-(void)setFrame:(CGRect)frame{
    frame.size.width = DockItemW;
    [super setFrame:frame];
}
//退出登陆
- (IBAction)ExitAction:(DSZZHMButton *)sender {
    if ([self.delegate respondsToSelector:@selector(exit)]) {
        [self.delegate exit];
    }
}

//点击dock栏
- (IBAction)clickBtn:(DSZZHMButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(dock:ViewChangeFrom:to:)]) {
        [self.delegate dock:self ViewChangeFrom:_selectedBtn.tag to:sender.tag];
        //NSLog(@"from:%li ,to:%li",(long)_selectedBtn.tag,sender.tag);
    }
    
    self.selectedBtn.selected = NO;
    sender.selected = YES;
    self.selectedBtn = sender;
   
}
@end
