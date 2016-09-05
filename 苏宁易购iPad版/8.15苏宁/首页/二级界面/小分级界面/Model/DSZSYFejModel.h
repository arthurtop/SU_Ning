//
//  DSZSYFejModel.h
//  8.2二级界面
//
//  Created by lovena on 15/8/2.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface DSZSYFejModel : NSObject
@property(nonatomic,copy)NSString *deal_id;//商品id
@property(nonatomic,copy)NSString *title;//名字
@property(nonatomic,copy)NSString *desc;//描述
@property(nonatomic,assign)double list_price;//以前价格
@property(nonatomic,assign)double current_price;//现在价格
@property(nonatomic,copy)NSString *purchase_count;//团购人数
@property(nonatomic,copy)NSString *purchase_deadline;//截至日期
@property(nonatomic,copy)NSString *publish_date;//开始日期
@property(nonatomic,copy)NSString *image_url;//图片
@end
