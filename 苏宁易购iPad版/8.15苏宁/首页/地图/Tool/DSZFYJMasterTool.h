//
//  DSZFYJMasterTool.h
//  8.1苏宁ipad
//
//  Created by app05 on 15/8/2.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
#import <MapKit/MapKit.h>

@class DSZFYJTotalModel;

// deals里面装的都是模型数据
typedef void (^DealsSuccessBlock)(NSArray *deals, int totalCount);

typedef void (^DealsErrorBlock)(NSError *error);

// deals里面装的都是模型数据
typedef void (^DealSuccessBlock)(DSZFYJTotalModel *deal);

typedef void (^DealErrorBlock)(NSError *error);

@interface DSZFYJMasterTool : NSObject

singleton_interface(DSZFYJMasterTool)


#pragma mark 获得指定的团购数据
- (void)dealWithID:(NSString *)ID success:(DealSuccessBlock)success error:(DealErrorBlock)error;

#pragma mark 获得周边的团购信息
- (void)dealsWithPos:(CLLocationCoordinate2D)pos success:(DealsSuccessBlock)success error:(DealsErrorBlock)error;

@end
