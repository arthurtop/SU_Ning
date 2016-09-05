//
//  XQModel.m
//  8.2二级界面
//
//  Created by app33 on 15/8/2.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "XQModel.h"
#import "NSObject+Value.h"
@implementation XQModel
- (void)setRestrictions:(RestrictionModel *)restrictions
{
    if ([restrictions isKindOfClass:[NSDictionary class]]) {
        _restrictions = [[RestrictionModel alloc] init];
        [_restrictions setValues:(NSDictionary *)restrictions];
    } else {
        _restrictions = restrictions;
    }
}
@end
