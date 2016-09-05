//
//  addNewAddressCell1.h
//  8.2二级界面
//
//  Created by app33 on 15/8/5.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface addNewAddressCell1 : UITableViewCell<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *name;//姓名

@property (weak, nonatomic) IBOutlet UITextField *textFiled;

+(id)createNewAddressCell1;
@end
