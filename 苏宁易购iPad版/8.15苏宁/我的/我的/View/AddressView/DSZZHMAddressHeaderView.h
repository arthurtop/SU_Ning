//
//  DSZZHMAddressHeaderView.h
//  8.1苏宁ipad
//
//  Created by app01 on 15/8/4.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import <UIKit/UIKit.h>

//新增地址协议
@protocol DSZZHMAddNewAddressDelegate <NSObject>

-(void)addClick;

@end

@interface DSZZHMAddressHeaderView : UIView

@property(weak,nonatomic)id<DSZZHMAddNewAddressDelegate>delegate;

//新增地址
- (IBAction)addNewAddress:(UIButton *)sender;

@end
