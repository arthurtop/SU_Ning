//
//  DSZZHMOrderCell.m
//  8.1苏宁ipad
//
//  Created by app01 on 15/8/5.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZZHMOrderCell.h"
#import "Common.h"
#import "DSZZHMOderModel.h"

@implementation DSZZHMOrderCell


-(instancetype)init{
    return [[NSBundle  mainBundle]loadNibNamed:@"DSZZHMOrderCell" owner:self options:nil][0];
}



- (IBAction)payForAction:(UIButton *)sender {
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    [_image setImageWithURL: [NSURL URLWithString:_model.imageUrl]];
    _time.text = [NSString stringWithFormat:@"下单时间：%@",_model.updatetime];
    _oderID.text = [NSString stringWithFormat:@"订单编号：%@",_model.orderid];
    _price.text = _model.listpricetext;
    
}

@end
