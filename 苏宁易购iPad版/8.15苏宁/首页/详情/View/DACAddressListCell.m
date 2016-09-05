//
//  DACAddressListCell.m
//  8.2二级界面
//
//  Created by app33 on 15/8/5.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DACAddressListCell.h"

@implementation DACAddressListCell

+(id)createListCellView:(UITableView*)tableView
{
    static NSString *name = @"cell";
    DACAddressListCell *cell = [tableView dequeueReusableCellWithIdentifier:name];
    if (cell==nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"DACAddressListCell" owner:nil options:nil]lastObject];
    }
    return cell;
}

-(void)setModel:(DACAddressModel *)model
{
    _model = model;
    self.name.text = _model.name;
    self.phone.text = _model.phone;
    self.address.text = _model.address;
    if (_model.flag) {
        self.selectButton.selected = YES;
    }
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
