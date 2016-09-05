//
//  DSZSYFtopejNavView.m
//  8.1苏宁ipad
//
//  Created by lovena on 15/8/3.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZSYFtopejNavView.h"
#import "DSZZYGBtn.h"
#import "DSZZYGshopDatabase.h"
@implementation DSZSYFtopejNavView

+(id)createNavView
{
    return [[[NSBundle mainBundle]loadNibNamed:@"DSZSYFtopejNavView" owner:nil options:nil] lastObject];
}
-(void)awakeFromNib
{
    
    //输入框的设置
    UIButton *leftBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame=CGRectMake(0, 10, 20, 20);
    [leftBtn setImage:[UIImage imageNamed:@"kHomeSearch_icon"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(searBtn) forControlEvents:UIControlEventTouchUpInside];
    _textfield.leftView=leftBtn;
    
    UIButton *rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame=CGRectMake(0, 0, 60, 30);
    [rightBtn setImage:[UIImage imageNamed:@"home_title_barcode"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(saomiaoBtn) forControlEvents:UIControlEventTouchUpInside];
    _textfield.rightView=rightBtn;
    _textfield.rightViewMode=UITextFieldViewModeAlways;
    _textfield.leftViewMode=UITextFieldViewModeAlways;
    
    //徽章
    _zygBtn=[[DSZZYGBtn alloc]initWithFrame:CGRectMake(930, 0, 0, 0)];
    [self addSubview:_zygBtn];
//    _titLabel.text=self.catclass;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeRefresh:) name:@"sousuotomian" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeRefresh:) name:@"sousuotomian2" object:nil];
}

-(void)setbtnTitle{
    DSZZYGshopDatabase  *shopbase=[[DSZZYGshopDatabase alloc]init];
    [shopbase createDatabase];
    [shopbase createTable];
    NSArray *dataarray=  [shopbase query];
    [_zygBtn buyNumber:dataarray.count];
}
//扫描
-(void)saomiaoBtn
{
    self.myblock();
}
//输入跳转
-(void)searBtn
{
    if ([self.delegate respondsToSelector:@selector(searchBtnDelegate)]) {
        [self.delegate searchBtnDelegate];
    }

}
//返回上一页
- (IBAction)returnBtn {
    if ([self.delegate respondsToSelector:@selector(returnDelegate)]) {
        [self.delegate returnDelegate];
    }
}
//返回主页
- (IBAction)returnHome {
    if ([self.delegate respondsToSelector:@selector(returnMainDelegate)]) {
        [self.delegate returnMainDelegate];
    }
}
/*-----------------待写-------------------------*/
//去购物车
- (IBAction)gotoGWC:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(gotoGW)]) {
        [self.delegate gotoGW];
    }
}
//去我的
- (IBAction)gotoWD:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(myYG)]) {
        [self.delegate myYG];
    }
}

//搜索
- (IBAction)gotoSearch {
    if ([self.delegate respondsToSelector:@selector(searchBtnDelegate)]) {
        [self.delegate searchBtnDelegate];
    }

}
//-(void)setCatclass:(NSString *)catclass
//{
//    _catclass=catclass;
//    
//}
-(void)changeRefresh:(NSNotification *)user
{
   // NSDictionary *dic=user.userInfo;
   // NSString *str=dic[@"catclass"];
    //NSLog(@"33333%@",str);
    
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
