//
//  DSZCQHistoryViewCell.h
//  8.1苏宁ipad
//
//  Created by app20 on 15/8/3.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DSZCQHistoryViewCell : UIView

+ (instancetype)createDSZCQHistoryViewCell;

@property(nonatomic,copy) NSString *image_url;
@property(nonatomic,copy) NSString *title;
@property(nonatomic,assign) float list_price;
@property(nonatomic,assign) float current_price;

// 拍卖品视图
@property (weak, nonatomic) IBOutlet UIImageView *image;

// 拍卖品名字
@property (weak, nonatomic) IBOutlet UILabel *nameLable;

// 参考价
@property (weak, nonatomic) IBOutlet UILabel *consultPrice;

// 参考价格横线
@property (weak, nonatomic) IBOutlet UIView *priceLine;

// 当前价
@property (weak, nonatomic) IBOutlet UILabel *currentPrice;

@end
