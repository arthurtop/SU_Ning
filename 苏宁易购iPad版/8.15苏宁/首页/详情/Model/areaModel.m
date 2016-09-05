//
//  areaModel.m
//  8.2二级界面
//
//  Created by app33 on 15/8/4.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "areaModel.h"

@implementation areaModel
-(instancetype)initWithDic:(NSDictionary*)dic
{
    self = [super init];
    if (self) {
        self.city = dic[@"city"];
        self.areas = dic[@"areas"];
    }
    return self;
}
@end
