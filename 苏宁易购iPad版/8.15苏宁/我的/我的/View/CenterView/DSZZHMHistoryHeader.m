//
//  DSZZHMHistoryHeader.m
//  8.1苏宁ipad
//
//  Created by app01 on 15/8/7.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZZHMHistoryHeader.h"

@implementation DSZZHMHistoryHeader


-(instancetype)init{
    return  [[NSBundle mainBundle]loadNibNamed:@"DSZZHMHistoryHeader" owner:self options:nil][0];
}


//删除历史纪录
- (IBAction)deleteHistory:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(deleteHistoryAction)]) {
        [self.delegate deleteHistoryAction];
    }
}
@end
