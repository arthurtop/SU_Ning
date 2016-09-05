//
//  DSZFYJTotalModel.m
//  8.1苏宁ipad
//
//  Created by app05 on 15/8/2.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZFYJTotalModel.h"
#import "NSObject+Value.h"
#import "DSZFYJBusiness.h"
@implementation DSZFYJTotalModel

- (void)setBusinesses:(NSArray *)businesses
{
    NSDictionary *obj = [businesses lastObject];
    if ([obj isKindOfClass:[NSDictionary class]]) {
        
        NSMutableArray *temp = [NSMutableArray array];
        for (NSDictionary *dict in businesses) {
            DSZFYJBusiness *b = [[DSZFYJBusiness alloc] init];
            [b setValues:dict];
            [temp addObject:b];
        }
        
        _businesses = temp;
        
    } else {
        _businesses = businesses;
    }
}


@end
