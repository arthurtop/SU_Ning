//
//  addNewAddressCell3.h
//  8.2二级界面
//
//  Created by app33 on 15/8/5.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface addNewAddressCell3 : UITableViewCell

@property (weak, nonatomic) IBOutlet UISwitch *buttonView;

- (IBAction)ButtonClick;

+(id)createNewAddressCell3;
@end
