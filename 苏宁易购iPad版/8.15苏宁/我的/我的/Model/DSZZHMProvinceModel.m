//
//  DSZZHMProvinceModel.m
//  8.1苏宁ipad
//
//  Created by app01 on 15/8/5.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZZHMProvinceModel.h"
#import "DSZZHMCityModel.h"


@implementation DSZZHMProvinceModel

-(void)setCitys:(NSArray *)citys{
    
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dic in citys) {
        DSZZHMCityModel *model = [[DSZZHMCityModel alloc]init];
        [model  setValuesForKeysWithDictionary:dic];
        [array addObject:model];
    }
    
    _citys = array;
}

@end
