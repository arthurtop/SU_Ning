//
//  TGBusiness.h
//  团购
//
//  Created by app43 on 15/7/31.
//  Copyright (c) 2015年 app43. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface DSZFYJBusiness : NSObject

@property (nonatomic, copy) NSString * city;
@property (nonatomic, copy) NSString * h5_url;
@property (nonatomic, assign) int ID;
@property (nonatomic, assign) double latitude;
@property (nonatomic, assign) double longitude;
@property (nonatomic, copy) NSString *name;

@end
