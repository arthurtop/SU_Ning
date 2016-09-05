//
//  DSZSYFtopejNavView.h
//  8.1苏宁ipad
//
//  Created by lovena on 15/8/3.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DSZSYFtopejNavView,DSZZYGBtn;
@protocol DSZSYFtopejNavViewDelegate <NSObject>

-(void)returnDelegate;//返回上一页代理
-(void)returnMainDelegate;//返回主页
-(void)searchBtnDelegate;
-(void)gotoGW;//购物
-(void)myYG;//我的易购
@end
@interface DSZSYFtopejNavView : UIView
- (IBAction)returnBtn;
@property (weak, nonatomic) IBOutlet UITextField *textfield;
@property (weak, nonatomic) IBOutlet UILabel *titLabel;
@property(nonatomic,retain)DSZZYGBtn *zygBtn;
@property(nonatomic,copy)NSString *catclass;


@property(nonatomic,weak)id<DSZSYFtopejNavViewDelegate>delegate;


@property(nonatomic,copy)void(^myblock)();
- (IBAction)returnHome;//返回主也
- (IBAction)gotoGWC:(UIButton *)sender;//购物车
- (IBAction)gotoWD:(UIButton *)sender;//我的
- (IBAction)gotoSearch;//去搜索
-(void)setbtnTitle;
+(id)createNavView;
@end
