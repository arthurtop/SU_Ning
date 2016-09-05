//
//  DSZZHMOrderCell.h
//  8.1苏宁ipad
//
//  Created by app01 on 15/8/5.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DSZZHMOderModel;
@interface DSZZHMOrderCell : UITableViewCell

//订单图片
@property (weak, nonatomic) IBOutlet UIImageView *image;

//订单编号
@property (weak, nonatomic) IBOutlet UILabel *oderID;

//订单时间
@property (weak, nonatomic) IBOutlet UILabel *time;

//订单金额
@property (weak, nonatomic) IBOutlet UILabel *price;

//订单状态
@property (weak, nonatomic) IBOutlet UILabel *states;

//订单所属店铺
@property (weak, nonatomic) IBOutlet UILabel *store;



@property (strong, nonatomic) DSZZHMOderModel *model;


//支付
- (IBAction)payForAction:(UIButton *)sender;





@end
