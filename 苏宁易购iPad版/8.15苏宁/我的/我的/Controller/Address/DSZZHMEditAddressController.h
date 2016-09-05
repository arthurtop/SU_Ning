//
//  DSZZHMEditAddressController.h
//  8.1苏宁ipad
//
//  Created by app01 on 15/8/4.
//  Copyright (c) 2015年 lovena. All rights reserved.
//


//新增地址
#import <UIKit/UIKit.h>



@interface DSZZHMEditAddressController : UITableViewController<UIPickerViewDataSource,UIPickerViewDelegate>



//收货人姓名
@property (weak, nonatomic) IBOutlet UITextField *name;
//收货人电话
@property (weak, nonatomic) IBOutlet UITextField *tel;


//地址单元格
@property (weak, nonatomic) IBOutlet UITableViewCell *AddressCell;
//地址 省市区
@property (weak, nonatomic) IBOutlet UILabel *province;
@property (weak, nonatomic) IBOutlet UILabel *city;
@property (weak, nonatomic) IBOutlet UILabel *district;
//箭头按钮
@property (weak, nonatomic) IBOutlet UIButton *arrowBtn;



//详细地址单元格
@property (weak, nonatomic) IBOutlet UITableViewCell *detail;
//收货人详细地址
@property (weak, nonatomic) IBOutlet UITextField *detailAddress;

//返回按钮
@property (weak, nonatomic) IBOutlet UIButton *returnAddressBtn;
//完成按钮
@property (weak, nonatomic) IBOutlet UIButton *finishEditBtn;


//默认地址按钮
@property (weak, nonatomic) IBOutlet UISwitch *defaultAddressBtn;
//默认地址单元格
@property (weak, nonatomic) IBOutlet UITableViewCell *defaultCell;
//默认地址单元格的线
@property (weak, nonatomic) IBOutlet UIImageView *detaultCellLine;



//改变地址
@property (weak, nonatomic) IBOutlet UITableViewCell *changeAddress;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

//判断是否显示改变地址的pickView
@property (assign,nonatomic)BOOL flag;


//地址信息数组
@property (retain, nonatomic) NSArray *infoArray;

//添加完成
-(void)finish;

//点击改变地址
- (IBAction)tap:(UITapGestureRecognizer *)sender;


@end
