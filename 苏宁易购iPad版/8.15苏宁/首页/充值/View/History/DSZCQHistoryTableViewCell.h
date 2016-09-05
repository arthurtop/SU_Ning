//
//  DSZCQHistoryTableViewCell.h
//  8.1苏宁ipad
//
//  Created by app20 on 15/8/5.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSZCQCellphoneRechageModel.h"

@interface DSZCQHistoryTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *IdNumber;
@property (weak, nonatomic) IBOutlet UILabel *cellphoneNumber;
@property (weak, nonatomic) IBOutlet UILabel *time;

@property (weak, nonatomic) IBOutlet UILabel *shouldPrice;
@property (weak, nonatomic) IBOutlet UILabel *truePrice;
@property (weak, nonatomic) IBOutlet UILabel *state;

@property(nonatomic,strong) DSZCQCellphoneRechageModel *cellphoneRechageHistory;

+ (instancetype)createDSZCQHistoryTableViewCell;

@end
