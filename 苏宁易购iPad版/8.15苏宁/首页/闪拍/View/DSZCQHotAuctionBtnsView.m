//
//  DSZCQHotAuctionBtnsView.m
//  8.1苏宁ipad
//
//  Created by app20 on 15/8/2.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZCQHotAuctionBtnsView.h"

@implementation DSZCQHotAuctionBtnsView

- (IBAction)buttons:(UIButton *)sender
{
    if (sender != _lastBtn)
    {
        self.lastBtn.selected = NO;
        sender.selected = YES;
        self.lastBtn = sender;
        
        CGFloat x = sender.tag - 101;
        if ([self.delegate respondsToSelector:@selector(clickHotAuctionBtnWithIndex:)])
        {
            
            [self.delegate clickHotAuctionBtnWithIndex:x];
        }
    }
    
}

+ (instancetype)createDSZCQHotAuctionBtnsView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"DSZCQHotAuctionBtnsView" owner:nil options:nil] lastObject];
}

- (void)awakeFromNib
{
    self.lastBtn = self.firstBtn;
}

@end
