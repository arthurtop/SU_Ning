//
//  DSZSYFtopView.m
//  8.1苏宁ipad
//
//  Created by lovena on 15/8/1.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZSYFtopView.h"
#import "DSZZYGBtn.h"
#import "DSZZYGshopDatabase.h"
#define kFilePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"login.data"]
@implementation DSZSYFtopView
+(id)createTopView
{
    return [[[NSBundle mainBundle]loadNibNamed:@"DSZSYFtopView" owner:nil options:nil] lastObject];
}
-(void)awakeFromNib
{
    

    //主页  购物车按钮隐藏
    _homeBtn.hidden=YES;
    
    //输入框的设置
    UIButton *leftBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame=CGRectMake(0, 10, 20, 20);
    [leftBtn setImage:[UIImage imageNamed:@"kHomeSearch_icon"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(searBtn) forControlEvents:UIControlEventTouchUpInside];
    _leftTextField.leftView=leftBtn;
    
    UIButton *rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame=CGRectMake(0, 0, 60, 30);
    [rightBtn setImage:[UIImage imageNamed:@"home_title_barcode"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(saomiaoBtn) forControlEvents:UIControlEventTouchUpInside];
    _leftTextField.rightView=rightBtn;
    _leftTextField.rightViewMode=UITextFieldViewModeAlways;
    _leftTextField.leftViewMode=UITextFieldViewModeAlways;
    
    _tel = [NSKeyedUnarchiver unarchiveObjectWithFile:kFilePath];
        //徽章
        _zygBtn=[[DSZZYGBtn alloc]initWithFrame:CGRectMake(780, 0, 0, 0)];
        [self addSubview:_zygBtn];
//    [self hiddenBtn];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(hiddenBuyNumBtn:) name:@"numberBuy" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(hiddenBuyNumBtn:) name:@"buynumber2" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(hiddenBuyNumBtn:) name:@"exitend" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(hiddenBuyNumBtn:) name:@"loginsuccess1" object:nil];
    
    //接收通知改变购物车徽章数
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(hiddenBuyNumBtn:) name:@"loginsuccess2" object:nil];
   
    
    // [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeIndex) userInfo:nil repeats:YES];
}

//-(void)hiddenBtn{
//    if (_tel) {
//        _zygBtn.hidden=YES;
//    }else{
//        _zygBtn.hidden=NO;
//    }
//    
//}

//int i=10;
//-(void)changeIndex
//{
//    [_zygBtn buyNumber:i];
//   
//    i--;
//}

-(void)hiddenBuyNumBtn:(NSInteger)number{
    DSZZYGshopDatabase  *shopbase=[[DSZZYGshopDatabase alloc]init];
    [shopbase createDatabase];
    [shopbase createTable];
    NSArray *dataarray=  [shopbase query];
    int countBuy=dataarray.count;
    if (_tel) {
        if (number==0) {
             _zygBtn.hidden=YES;
        }else{
        _zygBtn.hidden=NO;
            [_zygBtn buyNumber:countBuy];
        }
    }else{
        _zygBtn.hidden=YES;
    }
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

//搜索按钮
-(void)searBtn
{
    
}
//扫描
-(void)saomiaoBtn
{
    if ([self.delegate respondsToSelector:@selector(linkToClickSaoBtn)]) {
        [self.delegate linkToClickSaoBtn];
    }
}
- (IBAction)clickBtn:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(didclickTopBtn:)]) {
        [self.delegate didclickTopBtn:sender];
        //101  102   103  tag值
    }
}

- (IBAction)buyAction:(UIButton *)sender {
//    [self.delegate hiddenBuyNumBtn];
}
//搜索
- (IBAction)clickSearch {
    self.myBlock();
}
@end

