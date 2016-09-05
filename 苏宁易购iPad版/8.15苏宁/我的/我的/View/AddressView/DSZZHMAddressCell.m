//
//  DSZZHMAddressCell.m
//  8.1苏宁ipad
//
//  Created by app01 on 15/8/4.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZZHMAddressCell.h"
#import "DSZZHMAddressModel.h"
#import "DSZZHMAddressModel.h"
#import "RTLabel.h"



@implementation DSZZHMAddressCell


-(instancetype)init{
    
    return [[NSBundle mainBundle]loadNibNamed:@"DSZZHMAddressCell" owner:self options:nil][0];
}

-(void)awakeFromNib{
     _editBtn.hidden = NO;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    

    _name.text = _model.name;
    _tel.text = _model.tel;

    if ([_model.defaultAddress isEqualToString:@"1"]) {
        _label.text = [NSString stringWithFormat:@"<font color=red>[默认地址]</font>%@ %@",_model.address,_model.detailAddress];
    }else{
        _label.text = [NSString stringWithFormat:@"%@ %@",_model.address,_model.detailAddress];
    }
}

@end
