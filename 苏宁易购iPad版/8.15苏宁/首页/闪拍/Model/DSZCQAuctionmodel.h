//
//  DSZCQAuctionmodel.h
//  8.1苏宁ipad
//
//  Created by app20 on 15/8/3.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface DSZCQAuctionmodel : NSObject

@property(nonatomic,copy) NSString *image_url;
@property(nonatomic,copy) NSString *title;
@property(nonatomic,assign) double list_price;
@property(nonatomic,assign) double current_price;
@property(nonatomic,copy) NSString *purchase_deadline;

@end
