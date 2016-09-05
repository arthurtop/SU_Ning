//
//  DSZSYFCitySection.m
//  8.2二级界面
//
//  Created by lovena on 15/8/2.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZSYFCitySection.h"
#import "DSZSYFCity.h"
#import "MJExtension.h"
@implementation DSZSYFCitySection
-(void)setCities:(NSArray *)cities
{
    id obj=[cities lastObject];
    if (![obj isKindOfClass:[NSDictionary class]]) {
        _cities=cities;
        return;
    }
    NSMutableArray *array=[NSMutableArray array];
    for (NSDictionary *dic in cities) {
        DSZSYFCity *city=[[DSZSYFCity alloc]init];
        [city setKeyValues:dic];
        [array addObject:city];
    }
    _cities=array;
}
@end
