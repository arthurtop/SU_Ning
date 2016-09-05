//
//  DSZFYJTotalModel.h
//  8.1苏宁ipad
//
//  Created by app05 on 15/8/2.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DSZFYJTotalModel : NSObject

@property(nonatomic,copy)NSString *image_url;//小尺寸图片
@property(nonatomic,copy)NSString *deal_id;//团购单ID
@property(nonatomic,copy)NSString *title;//团购标题
@property(nonatomic,copy)NSString *desc;

@property(nonatomic,assign)float current_price;
@property(nonatomic,retain)NSArray *businesses;

@end
