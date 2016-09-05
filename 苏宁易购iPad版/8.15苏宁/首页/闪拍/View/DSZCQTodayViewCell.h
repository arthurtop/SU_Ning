//
//  DSZCQLotViewCell.h
//  8.1苏宁ipad
//
//  Created by app20 on 15/8/2.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DSZCQTodayViewCell : UIView

// 拍卖状态图
@property (weak, nonatomic) IBOutlet UIImageView *auctionIcon;

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

// 出价人
@property (weak, nonatomic) IBOutlet UILabel *name;

// 加价幅度
@property (weak, nonatomic) IBOutlet UILabel *range;

// 保证金
@property (weak, nonatomic) IBOutlet UILabel *deposit;

// 计时
@property (weak, nonatomic) IBOutlet UILabel *hour;
@property (weak, nonatomic) IBOutlet UILabel *minutes;
@property (weak, nonatomic) IBOutlet UILabel *second;

// 出价
@property (weak, nonatomic) IBOutlet UILabel *raisePrice;

- (IBAction)subtract;
- (IBAction)plus;

// 缴纳保证金
- (IBAction)payDeposit;



@property(nonatomic,copy) NSString *image_url;
@property(nonatomic,copy) NSString *title;
@property(nonatomic,assign) double list_price;
@property(nonatomic,assign) double current_price;
@property(nonatomic,copy) NSString *purchase_deadline;
@property(nonatomic,retain) NSTimer *timer;


+ (instancetype)createDSZCQLotViewCell;

@end
