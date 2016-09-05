//
//  addNewAddressCell2.h
//  8.2二级界面
//
//  Created by app33 on 15/8/5.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DACLocationModel.h"
@interface addNewAddressCell2 : UITableViewCell<UIPickerViewDataSource,UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@property (weak, nonatomic) IBOutlet UIPickerView *pickView;

@property(nonatomic,assign)BOOL isClicked;

@property(nonatomic,strong)NSArray *provinces;
@property(nonatomic,strong)NSArray *cities;
@property(nonatomic,strong)NSArray *areas;

@property(nonatomic,strong)DACLocationModel *locate;//模型

@property(nonatomic,copy)NSString *str;

+(id)createNewAddressCell2;
@end
