//
//  addNewAddressCell3.m
//  8.2二级界面
//
//  Created by app33 on 15/8/5.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "addNewAddressCell3.h"

@implementation addNewAddressCell3

+(id)createNewAddressCell3
{
    return [[[NSBundle mainBundle]loadNibNamed:@"addNewAddressCell3" owner:nil options:nil]lastObject];
}
- (void)awakeFromNib {
    self.buttonView.on = NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)ButtonClick {
    if (_buttonView.isOn == YES) {
        [_buttonView setOn:NO animated:YES];
    }
   else {
        [_buttonView setOn:YES animated:YES];
    }
   // BOOL on = _buttonView.isOn;
//    [[NSUserDefaults standardUserDefaults]setBool:on forKey:@"IsOnOrOff"];
}
@end
