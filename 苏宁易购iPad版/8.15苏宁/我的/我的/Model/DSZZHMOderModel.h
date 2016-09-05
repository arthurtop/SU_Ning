//
//  DSZZHMOderModel.h
//  8.1苏宁ipad
//
//  Created by app01 on 15/8/5.
//  Copyright (c) 2015年 lovena. All rights reserved.
//



//订单model
#import <Foundation/Foundation.h>

@interface DSZZHMOderModel : NSObject<NSCoding>

//订单状态更新时间
@property(copy,nonatomic)NSString *updatetime;
//商户ID
@property(assign,nonatomic)int businessid;
//订单号
@property(copy,nonatomic)NSString *orderid;

//消费金额
@property(assign,nonatomic)double transactionamount;
@property (nonatomic, copy) NSString *listpricetext; // 价格


//订单状态
@property(assign,nonatomic)int transactionstatus;

//图片
@property(nonatomic,copy)NSString *imageUrl;
@end
