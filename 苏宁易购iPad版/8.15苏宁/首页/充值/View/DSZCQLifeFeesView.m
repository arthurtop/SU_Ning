//
//  DSZCQLifeFeesView.m
//  8.1苏宁ipad
//
//  Created by app20 on 15/8/5.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZCQLifeFeesView.h"

@implementation DSZCQLifeFeesView

+ (instancetype)createDSZCQLifeFeesView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"DSZCQLifeFeesView" owner:nil options:nil] lastObject];
}

- (void)awakeFromNib
{
    _lastBtn = _firstBtn;

}

- (IBAction)feesTypeBtns:(UIButton *)sender {
    
    _lastBtn.selected = NO;
    sender.selected = YES;
    _lastBtn = sender;
            
    if ([self.delegate respondsToSelector:@selector(clickLifeFeesTypeBtn:)]) {
        
        [self.delegate clickLifeFeesTypeBtn:sender.tag];
    }
}

@end
