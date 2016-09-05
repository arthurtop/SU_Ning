//
//  DSZZYGShopBottom.h
//  8.1苏宁ipad
//
//  Created by app15 on 15/8/2.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DSZZYGShopBottom;
@protocol  DSZZYGShopBottomDelegate<NSObject>
-(void)addshopname;//选择所有
-(void)delshopname;//取消所有
-(void)pushOrder;//push订单页面

@end

@interface DSZZYGShopBottom : UIView
@property (weak, nonatomic) IBOutlet UILabel *selectNum;//件
@property (weak, nonatomic) IBOutlet UIButton *BottomselectBtn;//全选
@property (weak, nonatomic) IBOutlet UILabel *privilege;//优惠
@property (weak, nonatomic) IBOutlet UILabel *price;//价格


@property (weak, nonatomic) IBOutlet UIButton *Paybtn;

- (IBAction)actionBtn:(UIButton *)sender;//结算事件
- (IBAction)selectbtn:(UIButton *)sender;//全选事件

//代理
@property(weak ,nonatomic)id <DSZZYGShopBottomDelegate> delegate;

+(instancetype)loadNib;
@end
