//
//  DSZSYFtopView.h
//  8.1苏宁ipad
//
//  Created by lovena on 15/8/1.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSZZYGBtn.h"
@class DSZSYFtopView;
@protocol DSZSYFtopViewDelegate <NSObject>

-(void)didclickTopBtn:(UIButton *)btn;//代理
-(void)linkToClickSaoBtn;//扫描代理
//-(void)hiddenBuyNumBtn;
@end
@interface DSZSYFtopView : UIView
@property (weak, nonatomic) IBOutlet UIButton *buyNumBtn;//购物车件数
@property (weak, nonatomic) IBOutlet UITextField *leftTextField;//输入
@property (weak, nonatomic) IBOutlet UIButton *homeBtn;//主页按钮
@property (weak, nonatomic) IBOutlet UIButton *buysBtn;//购物车
@property (weak, nonatomic) IBOutlet UIButton *myBtn;//我的按钮
- (IBAction)clickSearch;
@property(nonatomic,retain)DSZZYGBtn *zygBtn;
@property(copy,nonatomic)NSString *tel;
- (IBAction)clickBtn:(UIButton *)sender;
- (IBAction)buyAction:(UIButton *)sender;
-(void)hiddenBuyNumBtn:(NSInteger)number;
@property(nonatomic,weak)id<DSZSYFtopViewDelegate>delegate;
+(id)createTopView;


@property(nonatomic,copy)void(^myBlock)();
@end
