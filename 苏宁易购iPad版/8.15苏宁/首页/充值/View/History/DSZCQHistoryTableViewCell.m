//
//  DSZCQHistoryTableViewCell.m
//  8.1苏宁ipad
//
//  Created by app20 on 15/8/5.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZCQHistoryTableViewCell.h"

@implementation DSZCQHistoryTableViewCell

+ (instancetype)createDSZCQHistoryTableViewCell
{
    return [[[NSBundle mainBundle] loadNibNamed:@"DSZCQHistoryTableViewCell" owner:nil options:nil] lastObject];
}

- (void)setCellphoneRechageHistory:(DSZCQCellphoneRechageModel *)cellphoneRechageHistory
{
    _cellphoneRechageHistory = cellphoneRechageHistory;
    
    _IdNumber.text = cellphoneRechageHistory.IDNumber;

    _cellphoneNumber.text = cellphoneRechageHistory.cellphoneNumber;
    _time.text = cellphoneRechageHistory.time;
    _shouldPrice.text = cellphoneRechageHistory.shouldPrice;
    _truePrice.text = cellphoneRechageHistory.truePrice;
    _state.text = cellphoneRechageHistory.state;
    
}

//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}

@end
