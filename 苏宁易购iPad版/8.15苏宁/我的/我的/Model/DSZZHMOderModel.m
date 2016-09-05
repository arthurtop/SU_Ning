//
//  DSZZHMOderModel.m
//  8.1苏宁ipad
//
//  Created by app01 on 15/8/5.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "NSString+MJ.h"
#import "DSZZHMOderModel.h"

@implementation DSZZHMOderModel


- (void)setTransaction_amount:(double)transaction_amount
{
    _transactionamount = transaction_amount;
    
    _listpricetext = [NSString stringWithDouble:_transactionamount fractionCount:2];
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_updatetime forKey:@"update_time"];
    [aCoder encodeObject:_orderid forKey:@"orderid"];
    [aCoder encodeObject:_listpricetext forKey:@"list_price_text"];
    [aCoder encodeObject:_imageUrl forKey:@"imageUrl"];
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.updatetime = [aDecoder decodeObjectForKey:@"update_time"];
        self.orderid = [aDecoder decodeObjectForKey:@"orderid"];
        self.listpricetext = [aDecoder decodeObjectForKey:@"list_price_text"];
        self.imageUrl = [aDecoder decodeObjectForKey:@"imageUrl"];
    }
    return self;
}

@end
