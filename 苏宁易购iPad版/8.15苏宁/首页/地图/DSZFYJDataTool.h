//
//  DSZDataTool.h
//  8.1苏宁ipad
//
//  Created by app05 on 15/8/2.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
@interface DSZFYJDataTool : NSObject

singleton_interface(DSZFYJDataTool)

@property(nonatomic,copy)NSString *city;
@property(nonatomic,copy)NSString *deal_id;
@property(nonatomic,copy)NSString *placeName;


@end
