//
//  goodsDetailShowView.h
//  8.2二级界面
//
//  Created by app33 on 15/8/3.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XQModel.h"
@interface goodsDetailShowView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *bigImage;//图片

@property (weak, nonatomic) IBOutlet UILabel *title;//标题

@property (weak, nonatomic) IBOutlet UIButton *anyTimeBack;//随时退款

@property (weak, nonatomic) IBOutlet UIButton *expireBack;//过期退款

@property (weak, nonatomic) IBOutlet UIButton *time;//剩余时间

@property (weak, nonatomic) IBOutlet UIButton *purchaseCount;//购买人数

@property (weak, nonatomic) IBOutlet UILabel *goodsDetail;//团购详情

@property (weak, nonatomic) IBOutlet UILabel *buyKnow;//购买须知

@property (weak, nonatomic) IBOutlet UIView *goodsDetailView;//团购详情视图

@property (weak, nonatomic) IBOutlet UIView *buyKnowView;//购买须知视图

@property (weak, nonatomic) IBOutlet UIView *headView;//头部视图

@property(nonatomic,strong)XQModel *model;

+(id)createGoodsDetailView;
@end
