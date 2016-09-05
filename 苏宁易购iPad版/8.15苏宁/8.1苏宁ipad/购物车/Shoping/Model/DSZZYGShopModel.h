//
//  DSZZYGShopModel.h
//  8.1苏宁ipad
//
//  Created by app15 on 15/8/2.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DSZZYGThingsModel;
@interface DSZZYGShopModel : NSObject <NSCoding>
@property(nonatomic,copy)NSString *shopname;
@property(nonatomic,retain)NSArray *things;

@end
