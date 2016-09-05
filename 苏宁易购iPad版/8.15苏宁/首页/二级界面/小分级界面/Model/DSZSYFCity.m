//
//  DSZSYFCity.m
//  8.2二级界面
//
//  Created by lovena on 15/8/2.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZSYFCity.h"
#import "MJExtension.h"
#import "DSZSYFDistrict.h"
@implementation DSZSYFCity
-(void)setDistricts:(NSArray *)districts
{
    NSMutableArray *array=[NSMutableArray array];
    for (NSDictionary *dic in districts) {
        DSZSYFDistrict *dis=[[DSZSYFDistrict alloc]init];
        [dis setKeyValues:dic];
        [array addObject:dis];
    }
    _districts=array;
}
@end
