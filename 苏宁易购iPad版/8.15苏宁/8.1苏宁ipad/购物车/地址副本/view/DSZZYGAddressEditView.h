//
//  DSZZYGAddressEditView.h
//  8.1苏宁ipad
//
//  Created by app15 on 15/8/4.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import <UIKit/UIKit.h>
#define PROVINCE_COMPONENT  0
#define CITY_COMPONENT      1
#define DISTRICT_COMPONENT  2
@class DSZZYGAddressEditView;
@protocol DSZZYGAddressEditViewDelegate <NSObject>

-(void)hiddlePick;

@end
@interface DSZZYGAddressEditView : UIView
@property (weak, nonatomic) IBOutlet UIButton *pickbtn;

@property (weak, nonatomic) IBOutlet UIView *pickLabelView;//大view
@property (weak, nonatomic) IBOutlet UIView *switchView;//开关所在view
@property (weak, nonatomic) IBOutlet UIPickerView *pickview;//pickview


@property (weak, nonatomic) IBOutlet UILabel *picktext;//地区
@property (weak, nonatomic) IBOutlet UITextField *nameLabel;//名字
@property (weak, nonatomic) IBOutlet UITextField *phoneLabel;//电话
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UITextField *detailaddressLabel;//详情
@property (weak, nonatomic) IBOutlet UISwitch *selectSwitch;//开关


- (IBAction)btnAction:(UIButton *)sender;
@property(weak,nonatomic)id<DSZZYGAddressEditViewDelegate>delegate;
@property (nonatomic, strong) NSArray *foods;
+(instancetype)loadnib;
@end
