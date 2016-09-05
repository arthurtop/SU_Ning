//
//  DSZSYFejTopView.h
//  8.2二级界面
//
//  Created by lovena on 15/8/2.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DSZZYGBtn;
@interface DSZSYFejTopView : UIView
@property (weak, nonatomic) IBOutlet UIButton *citysBtn;
- (IBAction)clickCityBtn;
//@property (weak, nonatomic) IBOutlet UIButton *sortBtn;
@property (weak, nonatomic) IBOutlet UIButton *priceBtn;
@property(nonatomic,retain)DSZZYGBtn *zygBtn;
//- (IBAction)clickSortBtn;
- (IBAction)clickWant:(UIButton *)sender;
- (IBAction)clickPrice:(UIButton *)sender;
-(void)setbtnTitle;
+(id)createTop;
@end
