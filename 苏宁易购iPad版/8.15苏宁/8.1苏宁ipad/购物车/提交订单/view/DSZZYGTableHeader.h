//
//  DSZZYGTableHeader.h
//  8.1苏宁ipad
//
//  Created by app15 on 15/8/3.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DSZZYGTableHeader;
@protocol DSZZYGTableHeaderDelegate <NSObject>
-(void)pushAddress;
-(void)pushQuan;
-(void)HeaderHeight:(CGFloat)height;
@end
@interface DSZZYGTableHeader : UIView
@property (weak, nonatomic) IBOutlet UIView *fapiaoView;//发票view
@property (weak, nonatomic) IBOutlet UIButton *addquanBtn;//添加易购券
@property (weak, nonatomic) IBOutlet UIView *paystyleView;//支付方式view(隐藏)
@property (weak, nonatomic) IBOutlet UIView *payView;//支付方式
@property (weak, nonatomic) IBOutlet UILabel *addQuanLabel;//添加易购券label
@property (weak, nonatomic) IBOutlet UITextField *headerfiled;

//添加地址
@property (weak, nonatomic) IBOutlet UIButton *imageAddress;
@property (weak, nonatomic) IBOutlet UILabel *addressAddLabel;


//添加默认地址
@property (weak, nonatomic) IBOutlet UIView *addressView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIButton *changeBtn;
@property (weak, nonatomic) IBOutlet UILabel *lablethingAddress;



- (IBAction)changeAddress:(UIButton *)sender;
- (IBAction)addAddress:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *payStyleBtn;
- (IBAction)payStyle:(UIButton *)sender;
- (IBAction)addQuan:(UIButton *)sender;
- (IBAction)addTable:(UIButton *)sender;



- (IBAction)payNow:(id)sender;

@property(weak,nonatomic)id <DSZZYGTableHeaderDelegate> delegate;
+(instancetype)loadnib;
-(BOOL) setaddress:(NSDictionary*)dic;
@end
