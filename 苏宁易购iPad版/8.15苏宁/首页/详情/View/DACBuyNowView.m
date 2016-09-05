//
//  DACBuyNowView.m
//  8.2二级界面
//
//  Created by app33 on 15/8/5.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DACBuyNowView.h"
#import "UIImageView+WebCache.h"
#import "DACAddressLIstView.h"
#import "DACSubmitView.h"
#import "DSZZHMOderModel.h"
#define FilePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]stringByAppendingPathComponent:@"address.data"]
#define FilePath3 [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]stringByAppendingPathComponent:@"oder.data"]
@implementation DACBuyNowView

+(id)createBuyNowView
{
    return [[[NSBundle mainBundle]loadNibNamed:@"DACBuyNowView" owner:nil options:nil]lastObject];
}

-(void)awakeFromNib
{
    self.submitView.layer.cornerRadius = 8;
    self.submitView.layer.masksToBounds = YES;
}

-(void)layoutSubviews
{
    //读档
    _array = [NSKeyedUnarchiver unarchiveObjectWithFile:FilePath];
    if (_array==NULL) {
        //什么也不做
    }
    else
    {
        //遍历数组，取出最新地址，给收货地址赋值
        for (int i = 0; i<_array.count; i++) {
            DACAddressModel *model = _array[i];
            if (model.isDefault) {
                self.name.text = model.name;
                self.phone.text = model.phone;
                self.address.text = model.address;
            }
            else
            {
             if (model.flag) {
                self.name.text = model.name;
                self.phone.text = model.phone;
                self.address.text = model.address;
             }
            }
        }
    }
}
-(void)setModel:(XQModel *)model
{
    _model = model;
    [self.picture setImageWithURL:[NSURL URLWithString:_model.image_url] placeholderImage:[UIImage imageNamed:@"加载中"]];
    self.Goodsname.text = _model.title;
    self.buyCount.text = @"*1";
    double dou = _model.current_price;
    NSString *str = [NSString stringWithFormat:@"%.2f",dou];
    self.price.text = [NSString stringWithFormat:@"¥%@",str];
    self.totalPrice.text = [NSString stringWithFormat:@"¥%@",str];
    self.BigTotalPrice.text = [NSString stringWithFormat:@"¥%@",str];
}
- (IBAction)changeAddressClick {
//    if ([self.delegate respondsToSelector:@selector(pushAddressList)]) {
//        [self.delegate pushAddressList];
//    }
    DACAddressLIstView *listView = [DACAddressLIstView createAddressListView];
    listView.frame = self.bounds;
    [self addSubview:listView];
}

- (IBAction)submitClick {
    
    //读档
    _muarray = [NSKeyedUnarchiver unarchiveObjectWithFile:FilePath3];
    //创建要归档的模型
    DSZZHMOderModel *odermodel = [[DSZZHMOderModel alloc]init];
    //日期
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    [format setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [NSDate date];
    NSString *time = [format stringFromDate:date];
    odermodel.updatetime = time;
    odermodel.orderid = self.model.deal_id;
    double dou =self.model.current_price;
    NSString *str = [NSString stringWithFormat:@"%.2f",dou];
    odermodel.listpricetext = str;
    odermodel.imageUrl = self.model.image_url;
//    NSLog(@"%@",odermodel.updatetime);
//    NSLog(@"%@",odermodel.orderid);
//    NSLog(@"%@",odermodel.listpricetext);
//    NSLog(@"%@",odermodel.imageUrl);
    if (_muarray==NULL) {
        _muarray = [NSMutableArray array];
    }
//    NSLog(@"%d",_muarray.count);
    //添加新数据
    [_muarray insertObject:odermodel atIndex:0];
    //归档
    [NSKeyedArchiver archiveRootObject:_muarray toFile:FilePath3];

    //进入支付页面
    DACSubmitView *submit = [DACSubmitView createSubmitView];
    submit.price.text = self.price.text;
    submit.frame = self.bounds;
    [self addSubview:submit];
    }
@end
