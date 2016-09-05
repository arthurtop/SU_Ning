//
//  DSZZHMYigouquanViewController.h
//  8.1苏宁ipad
//
//  Created by app01 on 15/8/4.
//  Copyright (c) 2015年 lovena. All rights reserved.
//


//易购券
#import <UIKit/UIKit.h>


@interface DSZZHMYigouquanViewController : UIViewController

//选择指示图
@property (weak, nonatomic) IBOutlet UIImageView *selectBg;
@property (weak, nonatomic) IBOutlet UIImageView *selectBg1;
@property (weak, nonatomic) IBOutlet UIImageView *selectBg2;

@property (weak, nonatomic) UIButton *selectBtn;
//默认选中的按钮
@property (weak, nonatomic) IBOutlet UIButton *btn;
//信息Label
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;

@property (weak, nonatomic) IBOutlet UIImageView *lion;

- (IBAction)btnAction:(UIButton *)sender;



@end
