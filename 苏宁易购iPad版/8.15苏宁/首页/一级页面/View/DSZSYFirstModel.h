//
//  FirstModel.h
//  7.30界面
//
//  Created by lovena on 15/7/30.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DSZSYFirstModel : NSObject
@property(nonatomic,copy)NSString *name;
@property(nonatomic,retain)NSArray *subcategories;
@property(nonatomic,copy)NSString *icon;
-(id)initWithDic:(NSDictionary *)dic;
@end
