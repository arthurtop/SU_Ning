//
//  addNewAddressCell1.m
//  8.2二级界面
//
//  Created by app33 on 15/8/5.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "addNewAddressCell1.h"
#import "MBProgressHUD+MJ.h"
@implementation addNewAddressCell1

+(id)createNewAddressCell1
{
    return [[[NSBundle mainBundle]loadNibNamed:@"addNewAddressCell1" owner:nil options:nil]lastObject];
}
- (void)awakeFromNib {
    self.textFiled.delegate = self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([textField.text isEqualToString:@""]) {
        [MBProgressHUD showError:@"输入不能为空"];
        [MBProgressHUD hideHUD];
    }
    return YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
