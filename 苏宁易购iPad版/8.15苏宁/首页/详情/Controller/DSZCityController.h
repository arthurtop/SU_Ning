//
//  DSZCityController.h
//  8.2二级界面
//
//  Created by app33 on 15/8/4.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DACLocationModel.h"
@interface DSZCityController : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource>

@property(nonatomic,strong)NSArray *provinces;
@property(nonatomic,strong)NSArray *cities;
@property(nonatomic,strong)NSArray *areas;

@property(nonatomic,strong)DACLocationModel *locate;//模型

@property(nonatomic,strong)UIPickerView *pickerView;//拾取器

@property(nonatomic,copy)void(^add)(NSString *provinces,NSString*cities,NSString*areas);
@end
