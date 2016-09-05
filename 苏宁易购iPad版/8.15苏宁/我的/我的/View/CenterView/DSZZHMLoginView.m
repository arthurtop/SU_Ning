//
//  DSZZHMLoginView.m
//  8.1苏宁ipad
//
//  Created by app01 on 15/8/3.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZZHMLoginView.h"
#import "Common.h"
#import <MessageUI/MessageUI.h>
#import "FMDB.h"

#define kLoginHistoryPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"loginHistory.data"]


@interface DSZZHMLoginView ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>

//验证码
@property(copy,nonatomic)NSMutableString *indentufierCode;

//数据库对象
@property (nonatomic, strong) FMDatabase *db;
@property (nonatomic, strong) FMDatabaseQueue *queue;


//注册的手机号和密码
@property(copy,nonatomic)NSString *tel;
@property(copy,nonatomic)NSString *pwd;
//登录的手机号和密码
@property(copy,nonatomic)NSString *login_tel;
@property(copy,nonatomic)NSString *login_pwd;


@end

@implementation DSZZHMLoginView

-(void)awakeFromNib{
    
    
    _selectBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _selectBtn.layer.borderWidth = 1;
    _selectBtn.layer.cornerRadius = 2;
    _selectBtn.layer.masksToBounds = YES;
    
    _zhuce.hidden = YES;
    
    
    //关闭按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.tag = 20;
    btn.frame = CGRectMake(self.right-8, self.top-7, 16, 16);
    [btn setBackgroundImage:[UIImage imageNamed:@"close.png"] forState:UIControlStateNormal];
    //[btn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    
    //隐藏或显示密码显示历史纪录
    UIButton *historyBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    historyBtn.frame=CGRectMake(0, 0, 40, 12);
    historyBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 12, 0, 11);
    [historyBtn setImage:[UIImage imageNamed:@"cellDown.png"] forState:UIControlStateNormal];
    [historyBtn addTarget:self action:@selector(isAppeneranceHistory:) forControlEvents:UIControlEventTouchUpInside];
    _login_enterTel.rightView=historyBtn;
    _login_enterTel.rightViewMode=UITextFieldViewModeAlways;
    _loginHistoryBtn = historyBtn;

    
    //隐藏或显示密码
    UIButton *pwdBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    pwdBtn.frame=CGRectMake(0, 0, 40, 12);
    pwdBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 12, 0, 11);
    [pwdBtn setImage:[UIImage imageNamed:@"login_password_icon.png"] forState:UIControlStateNormal];
    [pwdBtn addTarget:self action:@selector(isAppenerancePwd:) forControlEvents:UIControlEventTouchUpInside];
    _login_enterPwd.rightView=pwdBtn;
    _login_enterPwd.rightViewMode=UITextFieldViewModeAlways;
    
    
    // 0.获得沙盒中的数据库文件名
    NSString *filename = [NSString stringWithFormat:@"%@/Documents/resgist.sqlite",NSHomeDirectory()];
    //NSLog(@"%@",filename);
    // 1.创建数据库队列
    self.queue = [FMDatabaseQueue databaseQueueWithPath:filename];
    
    // 2.创表 队列queue对象会自动创建数据库FMDatabase实例 该数据库实例是加过锁的实例 具有线程安全性
    [self.queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"create table if not exists resgist ( tel text primary key , pwd text );"];
        
//        if (result) {
//            NSLog(@"创表成功");
//        } else {
//            NSLog(@"创表失败");
//        }
    }];

    
}

-(instancetype)init{
    return [[NSBundle mainBundle]loadNibNamed:@"DSZZHMLoginView" owner:self options:nil][0];
}



-(void)setFrame:(CGRect)frame{
    frame.size.width = 350;
    frame.size.height = 250;
    [super setFrame:frame];
}



-(NSMutableArray *)loginHistoryArray{
    
    _loginHistoryArray = [NSKeyedUnarchiver unarchiveObjectWithFile:kLoginHistoryPath];
    return _loginHistoryArray;
}

//显示登录历史纪录
-(void)isAppeneranceHistory:(UIButton *)btn{
    
    if (btn.tag == 0) {
        [_loginHistoryBtn setImage:[UIImage imageNamed:@"cellUp.png"] forState:UIControlStateNormal];
        btn.tag = 1;
        
        if (_loginHistoryTableView == nil) {
            UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(_login_enterTel.left, _login_enterTel.bottom, _login_enterTel.width, 50) style:UITableViewStylePlain];
            tableView.delegate = self;
            tableView.dataSource = self;
            tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            [self addSubview:tableView];
            _loginHistoryTableView = tableView;
        }
        _loginHistoryTableView.hidden = NO;
        [_loginHistoryTableView reloadData];
        
    }else{
        [_loginHistoryBtn setImage:[UIImage imageNamed:@"cellDown.png"] forState:UIControlStateNormal];
        btn.tag = 0;
        _loginHistoryTableView.hidden = YES;
    }
    
}


//是否显示密码
-(void)isAppenerancePwd:(UIButton *)btn{
    if (btn.tag == 0) {
        _login_enterPwd.secureTextEntry = NO;
        btn.tag = 1;
    }else{
        _login_enterPwd.secureTextEntry = YES;
        btn.tag = 0;
    }
}



//同意协议
- (IBAction)agreeSelect:(UIButton *)sender {
    if (sender.tag == 1) {
        [_selectBtn setBackgroundImage:nil forState:UIControlStateNormal];
        sender.tag = 0;
    }else{
        [_selectBtn setBackgroundImage:[UIImage imageNamed:@"address_selected_icon.png"] forState:UIControlStateNormal];
        sender.tag = 1;
    }
}

//获得验证码
- (IBAction)indentitierCode:(UIButton *)sender {
    
    NSString *source = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ123456789";
    _indentufierCode = [NSMutableString string];
    
    for(NSInteger i=0; i<4; i++) {
        
        int len = (int)source.length;
        int index = arc4random_uniform(len-1);
        NSRange range = NSMakeRange(index, 1);
        
        NSString *passwordChar = [source substringWithRange:range];
        
        [_indentufierCode appendString:passwordChar];
    }
    
    _enterIndentifier.text = _indentufierCode;
    
//    MFMessageComposeViewController *vc = [[MFMessageComposeViewController alloc]init];
//    vc.body = _indentufierCode;
//    vc.recipients = @[];
    
}


//点击登录或注册按钮
- (IBAction)loginORegist:(UIButton *)sender {
    
    [self turnOver:sender];
    if (sender.tag == 10) {
        _zhuce.hidden = NO;
    }else {
        _zhuce.hidden = YES;
    }
}

//翻转
-(void)turnOver:(UIButton *)btn{
    
    CATransition *anim = [CATransition animation];
    anim.type = @"oglFlip";
    if (btn.tag ==10 ) {
        anim.subtype = kCATransitionFromRight;
        _login_enterPwd.text = nil;
        _login_enterTel.text = nil;
        _loginBtn.selected = NO;
        _login_enterPwd.secureTextEntry = YES;
        [_loginHistoryBtn setImage:[UIImage imageNamed:@"cellDown.png"] forState:UIControlStateNormal];
    }else{
        anim.subtype = kCATransitionFromLeft;
        _enterPwd.text = nil;
        _login_enterTel.text = _enterTel.text;
        _enterTel.text = nil;
        _enterIndentifier.text = nil;
        _registeBtn.selected = NO;
        
    }
    [self.layer addAnimation:anim forKey:nil];
   
    
}



//注册
- (IBAction)registAction:(UIButton *)sender {
    
    [_enterTel resignFirstResponder];
    [_enterPwd resignFirstResponder];
    
    _tel = _enterTel.text;
    _pwd = _enterPwd.text;
    
    
    //判断信息是否完整
    if (_tel.length == 0 || _pwd.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入电话号码或密码" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        //[alert  setFrame:CGRectMake(100, 100, 100, 50)];
        [alert show];
        return;
    }

    //判断手机号是否合理
    NSString *string = [_tel substringToIndex:2];
    if (!([string isEqualToString:@"13"]||[string isEqualToString:@"15"]||[string isEqualToString:@"18"]||[string isEqualToString:@"14"])) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"不要闹，你的手机号真长这样啊" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        return;
    }
    if (_enterTel.text.length != 11) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"你的手机号这么长真的好么" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        return;
    }
    //判断是否同意协议
    if (_selectBtn.tag == 0 ) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请同意协议" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        //alert.transform =CGAffineTransformMakeTranslation( 0, 0);
        [alert show];
        return;
    }
    
    [self.queue inDatabase:^(FMDatabase *db) {
        
      BOOL rt = [db executeUpdate:@"insert into resgist (tel, pwd) values (?, ?);", _tel, _pwd];

        if (rt) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"注册成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alert show];
        }else {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"该手机号已注册" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alert show];
        }
    }];
    
    
}


//登录
- (IBAction)loginAction:(UIButton *)sender {
    
    _login_pwd = _login_enterPwd.text;
    _login_tel = _login_enterTel.text;
    
    
    [self.queue inDatabase:^(FMDatabase *db) {
        // 1.查询数据
        //FMResultSet *rs = [FMResultSet new];
        FMResultSet *rs = [db executeQuery:@"select * from resgist "];
        
        BOOL reslut = false;
        while (rs.next) {
            
            NSString *logintel = [rs stringForColumn:@"tel"];
            NSString *loginpwd = [rs stringForColumn:@"pwd"];
            if ([logintel isEqualToString:_login_tel] && [loginpwd isEqualToString:_login_pwd]) {
                //NSLog(@"登录成功");
                
                //纪录登录历史
                if (_loginHistoryArray == nil) {
                    _loginHistoryArray = [NSMutableArray array];
                    [_loginHistoryArray insertObject:logintel atIndex:0];
                }
                for (NSString *string in _loginHistoryArray) {
                    
                    if ([string isEqualToString:logintel]) {
                        break;
                    }
                    [_loginHistoryArray insertObject:logintel atIndex:0];
                }
                [NSKeyedArchiver archiveRootObject:_loginHistoryArray toFile:kLoginHistoryPath];
                
                [[NSNotificationCenter defaultCenter]postNotificationName:@"loginsuccessed" object:logintel];
                
                reslut = true;
                break ;
            }
            

        }
        if(!reslut) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"用户名或密码错误" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alert show];
        }
        [rs close];
        
    }];

    
}

//忘记密码
- (IBAction)forgetPwd:(UIButton *)sender {
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"forgetPasswd" object:nil];
//    if ([self.delegate respondsToSelector:@selector(forgetPasswd)]) {
//        [self.delegate forgetPasswd];
//    }
    
}

#pragma mark alterView代理方法
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self loginORegist:nil];
}



#pragma mark textFiled代理方法

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField == _login_enterTel || textField == _login_enterPwd) {
         _loginBtn.selected = YES;
    }
    if (textField == _enterTel) {
        _registeBtn.selected = YES;
        
    }
   
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    _tel = _enterTel.text;
    _pwd = _enterPwd.text;
    
    [textField resignFirstResponder];
    
    return YES;
}


#pragma mark tableview代理方法

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.loginHistoryArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = _loginHistoryArray[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"add_address_separator_line.png"]];
    image.frame = CGRectMake(0, 18, tableView.width, 1);
    [cell.contentView addSubview:image];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *str = _loginHistoryArray[indexPath.row];
    _login_enterTel.text = str;
    tableView.hidden = YES;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 20;
    
}

@end
