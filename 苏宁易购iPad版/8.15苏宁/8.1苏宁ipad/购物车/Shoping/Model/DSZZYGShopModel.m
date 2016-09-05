//
//  DSZZYGShopModel.m
//  8.1苏宁ipad
//
//  Created by app15 on 15/8/2.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZZYGShopModel.h"
#import "DSZZYGThingsModel.h"
#import "MJExtension.h"
@implementation DSZZYGShopModel
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:_shopname forKey:@"shopname"];
    [aCoder encodeObject:_things forKey:@"things"];
}
-(id)initWithCoder:(NSCoder *)aDecoder{
    self=[super init];
    if (self) {
        _shopname=[aDecoder decodeObjectForKey:@"shopname"];
        _things=[aDecoder decodeObjectForKey:@"things"];
    }
    return  self;
}
@end
