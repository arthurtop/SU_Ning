//
//  DSZDataTool.m
//  8.1苏宁ipad
//
//  Created by app05 on 15/8/2.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZFYJDataTool.h"

@implementation DSZFYJDataTool

singleton_implementation(DSZFYJDataTool)

-(id)init
{
    if (self=[super init]) {
        
    }
    return self;
}

-(void)setCity:(NSString *)city
{
    _city=city;
    //NSLog(@"---%@",_city);
}
-(void)setDeal_id:(NSString *)deal_id
{
    _deal_id=deal_id;
}
-(void)setPlaceName:(NSString *)placeName
{
    _placeName=placeName;
}

@end
