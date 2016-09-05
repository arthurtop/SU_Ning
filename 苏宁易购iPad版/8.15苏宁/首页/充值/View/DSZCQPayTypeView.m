//
//  DSZCQPayTypeView.m
//  8.1苏宁ipad
//
//  Created by app20 on 15/8/4.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZCQPayTypeView.h"

@implementation DSZCQPayTypeView

+ (instancetype)createDSZCQPayTypeView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"DSZCQpayTypeView" owner:nil options:nil] lastObject];
}

- (void)awakeFromNib
{
    
}

- (IBAction)efubaoBtn {
}

- (IBAction)bankBtn {
    
    if ([self.delegate respondsToSelector:@selector(clickBankBtn)]){
        
        [self.delegate clickBankBtn];
    }
    
//    self.myblock();
}

@end
