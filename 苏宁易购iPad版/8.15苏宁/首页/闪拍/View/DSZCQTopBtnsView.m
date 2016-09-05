//
//  DSZCQTopBtnsView.m
//  8.1苏宁ipad
//
//  Created by app20 on 15/8/2.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZCQTopBtnsView.h"
#import "Common.h"

@interface DSZCQTopBtnsView ()

@property(nonatomic,weak) UIButton *lastBtn;

@end

@implementation DSZCQTopBtnsView

+(instancetype)createDSZCQTopBtnsView
{
    
    return [[[NSBundle mainBundle] loadNibNamed:@"DSZCQTopBtnsView" owner:nil options:nil] lastObject];
}

- (void)awakeFromNib
{
    self.lastBtn = self.firstBtn;
}

- (IBAction)buttons:(UIButton *)sender
{
    
    if (sender != _lastBtn)
    {
        
        // 改变按钮字体颜色
        [_lastBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [sender setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        _lastBtn = sender;
        
        // 改变背景视图位置
        CGFloat x = sender.tag - 101;
        _BGView.frame = CGRectMake(KDeviceWidth / 4 * x, self.height - 3, KDeviceWidth / 4, 3);
        
        if ([self.delegate respondsToSelector:@selector(clickTopBtnWithIndex:)])
        {
            
            [self.delegate clickTopBtnWithIndex:x];
        }

    }
    
}

@end
