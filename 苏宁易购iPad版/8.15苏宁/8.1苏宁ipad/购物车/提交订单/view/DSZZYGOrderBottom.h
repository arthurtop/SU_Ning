//
//  DSZZYGOrderBottom.h
//  8.1苏宁ipad
//
//  Created by app15 on 15/8/3.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DSZZYGOrderBottom;
@protocol DSZZYGOrderBottomDelegate <NSObject>

-(void)poshsuccess;

@end
@interface DSZZYGOrderBottom : UIView
@property (weak, nonatomic) IBOutlet UILabel *AddPrice;
@property (weak, nonatomic) IBOutlet UILabel *youhuiLabel;
@property (weak, nonatomic) IBOutlet UILabel *yunfeiLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceAll;
@property (weak, nonatomic) IBOutlet UIButton *upOrder;

@property(weak,nonatomic)id<DSZZYGOrderBottomDelegate>delegate;
- (IBAction)upActionOrder:(UIButton *)sender;

+(instancetype)loadnib;
@end
