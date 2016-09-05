//
//  FirstModel.m
//  7.30界面
//
//  Created by lovena on 15/7/30.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZSYFirstModel.h"

@implementation DSZSYFirstModel
-(id)initWithDic:(NSDictionary *)dic
{
    self=[super init];
    if (self) {
        self.icon=dic[@"icon"];
        self.name=dic[@"name"];
        self.subcategories=dic[@"subcategories"];
    }
    return self;
}
@end
