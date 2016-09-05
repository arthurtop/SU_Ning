//
//  DSZFYJMarkerView.m
//  8.1苏宁ipad
//
//  Created by app05 on 15/8/3.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZFYJMarkerView.h"

@implementation DSZFYJMarkerView

+(id)FYJMarkerView
{
    return [[NSBundle mainBundle]loadNibNamed:@"DSZFYJMarkerView" owner:nil options:nil][0];
}

- (IBAction)FYJmarketBtn:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(clickMarkerBtnWithSender:)]) {
        [self.delegate clickMarkerBtnWithSender:sender];
    }
}
@end
