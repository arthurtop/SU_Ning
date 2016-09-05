//
//  DACBuyNowView.h
//  8.2二级界面
//
//  Created by app33 on 15/8/5.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XQModel.h"
#import "DACAddressModel.h"
@protocol DACBuyNowViewDelegate <NSObject>
-(void)pushAddressList;
@end
@interface DACBuyNowView : UIView

@property (weak, nonatomic) IBOutlet UILabel *name;//收货人姓名

@property (weak, nonatomic) IBOutlet UILabel *phone;//收货人电话

@property (weak, nonatomic) IBOutlet UILabel *address;//收货人地址

@property (weak, nonatomic) IBOutlet UIImageView *picture;//图片

@property (weak, nonatomic) IBOutlet UILabel *buyCount;//购买数量

@property (weak, nonatomic) IBOutlet UILabel *price;//价钱

@property (weak, nonatomic) IBOutlet UILabel *totalPrice;//总价钱

@property (weak, nonatomic) IBOutlet UILabel *BigTotalPrice;//最后价钱

@property (weak, nonatomic) IBOutlet UIButton *submitView;//提交订单按钮

@property (weak, nonatomic) IBOutlet UILabel *Goodsname;//名称

- (IBAction)changeAddressClick;//改变地址

- (IBAction)submitClick;//提交订单

@property(nonatomic,strong)XQModel *model;

@property(nonatomic,strong)NSArray *array;

@property(nonatomic,strong)NSMutableArray *muarray;
+(id)createBuyNowView;

@property(nonatomic,weak)id<DACBuyNowViewDelegate>delegate;
@end
