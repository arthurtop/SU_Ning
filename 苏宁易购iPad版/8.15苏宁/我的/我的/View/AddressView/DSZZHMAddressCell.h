//
//  DSZZHMAddressCell.h
//  8.1苏宁ipad
//
//  Created by app01 on 15/8/4.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTLabel.h"

@class DSZZHMAddressModel;
@interface DSZZHMAddressCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UILabel *tel;


@property (weak, nonatomic) IBOutlet RTLabel *label;


@property (weak, nonatomic) IBOutlet UIImageView *editBtn;


@property(retain,nonatomic)DSZZHMAddressModel *model;

@end
