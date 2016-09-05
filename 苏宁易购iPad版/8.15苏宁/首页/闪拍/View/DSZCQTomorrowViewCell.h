//
//  DSZCQTomorrowViewCell.h
//  8.1苏宁ipad
//
//  Created by app20 on 15/8/3.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DSZCQTomorrowViewCell : UIView

// 拍卖品视图
@property (weak, nonatomic) IBOutlet UIImageView *image;

// 拍卖品名字
@property (weak, nonatomic) IBOutlet UILabel *nameLable;

// 参考价格横线
@property (weak, nonatomic) IBOutlet UIView *priceLine;

// 参考价
@property (weak, nonatomic) IBOutlet UILabel *consultPrice;

// 缴纳保证金
- (IBAction)payDeposit;

@property(nonatomic,copy) NSString *image_url;
@property(nonatomic,copy) NSString *title;
@property(nonatomic,assign) CGFloat list_price;

+ (instancetype)createDSZCQTomorrowViewCell;

@end
