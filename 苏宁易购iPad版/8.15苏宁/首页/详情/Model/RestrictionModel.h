//
//  RestrictionModel.h
//  8.2二级界面
//
//  Created by app33 on 15/8/3.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RestrictionModel : NSObject
@property (nonatomic, assign) BOOL is_reservation_required; // 是否需要预约，0：不是，1：是
@property (nonatomic, assign) BOOL is_refundable; // 是否支持随时退款，0：不是，1：是
@property (nonatomic, copy) NSString * special_tips; // （购买须知）附加信息(一般为团购信息的特别提示)
@end
