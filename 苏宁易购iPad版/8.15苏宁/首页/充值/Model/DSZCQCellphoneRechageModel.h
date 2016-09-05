//
//  DSZCQCellphoneRechageModel.h
//  8.1苏宁ipad
//
//  Created by app20 on 15/8/6.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DSZCQCellphoneRechageModel : NSObject<NSCoding>

@property(nonatomic,copy) NSString *IDNumber;
@property(nonatomic,copy) NSString *cellphoneNumber;
@property(nonatomic,copy) NSString *shouldPrice;
@property(nonatomic,copy) NSString *truePrice;
@property(nonatomic,copy) NSString *time;
@property(nonatomic,copy) NSString *state;

@end
