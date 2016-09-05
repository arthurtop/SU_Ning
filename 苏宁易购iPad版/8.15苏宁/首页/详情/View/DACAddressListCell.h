//
//  DACAddressListCell.h
//  8.2二级界面
//
//  Created by app33 on 15/8/5.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DACAddressModel.h"
@interface DACAddressListCell : UITableViewCell

+(id)createListCellView:(UITableView*)tableView;

@property(nonatomic,strong)DACAddressModel *model;

@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UILabel *phone;

@property (weak, nonatomic) IBOutlet UILabel *address;

@property (weak, nonatomic) IBOutlet UIButton *selectButton;
@end
