//
//  areaModel.h
//  8.2二级界面
//
//  Created by app33 on 15/8/4.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface areaModel : NSObject
@property(nonatomic,copy)NSString *city;
@property(nonatomic,strong)NSArray *areas;

-(instancetype)initWithDic:(NSDictionary*)dic;
@end
