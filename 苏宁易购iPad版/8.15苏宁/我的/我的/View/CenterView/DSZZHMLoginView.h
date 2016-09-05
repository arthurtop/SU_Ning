//
//  DSZZHMLoginView.h
//  8.1苏宁ipad
//
//  Created by app01 on 15/8/3.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ForgetPasswdDelegate <NSObject>

-(void)forgetPasswd;


@end

@interface DSZZHMLoginView : UIView<UITextFieldDelegate>

//显示登录电话号历史纪录
@property (weak, nonatomic) UITableView *loginHistoryTableView;
//显示登录电话号历史纪录
@property (weak, nonatomic) UIButton *loginHistoryBtn;
//登录时输入电话号
@property (weak, nonatomic) IBOutlet UITextField *login_enterTel;
//登录时输入密码
@property (weak, nonatomic) IBOutlet UITextField *login_enterPwd;
//登录按钮
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

//登录历史纪录按钮
@property (retain, nonatomic) NSMutableArray *loginHistoryArray;

@property(weak,nonatomic)id<ForgetPasswdDelegate>delegate;

//注册视图
@property (weak, nonatomic) IBOutlet UIView *zhuce;
//输入手机号
@property (weak, nonatomic) IBOutlet UITextField *enterTel;
//输入密码
@property (weak, nonatomic) IBOutlet UITextField *enterPwd;
//输入验证码
@property (weak, nonatomic) IBOutlet UITextField *enterIndentifier;
//选择按钮
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;
//注册按钮
@property (weak, nonatomic) IBOutlet UIButton *registeBtn;



//同意协议
- (IBAction)agreeSelect:(UIButton *)sender;

//获得验证码
- (IBAction)indentitierCode:(UIButton *)sender;

//注册或登录 根据tag判断显示哪个视图
- (IBAction)loginORegist:(UIButton *)sender;

//注册
- (IBAction)registAction:(UIButton *)sender;
//登录
- (IBAction)loginAction:(UIButton *)sender;
//忘记密码
- (IBAction)forgetPwd:(UIButton *)sender;



@end
