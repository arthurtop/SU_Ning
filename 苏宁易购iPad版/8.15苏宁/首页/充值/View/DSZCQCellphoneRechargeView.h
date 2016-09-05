//
//  DSZCQCellphoneRechargeView.h
//  8.1苏宁ipad
//
//  Created by app20 on 15/8/4.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DSZCQCellphoneRechargeView : UIView <UITextFieldDelegate>

@property (assign, nonatomic) CGFloat truePrice;
@property (assign, nonatomic) CGFloat shouldPrice;

// 手机号码输入框
@property (weak, nonatomic) IBOutlet UITextField *numberTextField;
@property (copy, nonatomic) NSMutableString *numberTextFieldText;

// 归属地
@property (weak, nonatomic) IBOutlet UILabel *affiliation;
@property (weak, nonatomic) IBOutlet UILabel *price;

- (IBAction)priceBtns:(UIButton *)sender;

@property (weak, nonatomic) UIButton *lastBtn;

+ (instancetype)createDSZCQCellphoneRechargeView;

@end
