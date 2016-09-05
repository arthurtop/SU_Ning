//
//  DSZZHMNavBar.m
//  8.1苏宁ipad
//
//  Created by app01 on 15/8/2.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZZHMNavBar.h"
#import "DSZZYGshopDatabase.h"

#define kFilePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"login.data"]
@implementation DSZZHMNavBar


-(void)awakeFromNib{
    
    _myLogo.selected = YES;
    
    //搜索框添加图标
    UIButton *leftBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame=CGRectMake(0, 10, 20, 20);
    [leftBtn setImage:[UIImage imageNamed:@"kHomeSearch_icon"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(searchBtn) forControlEvents:UIControlEventTouchUpInside];
    _searchTextView.leftView=leftBtn;//输入框的设置
    _searchTextView.leftViewMode=UITextFieldViewModeAlways;
    
    UIButton *rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame=CGRectMake(0, 0, 60, 30);
    [rightBtn setImage:[UIImage imageNamed:@"home_title_barcode"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(saomiaoBtn) forControlEvents:UIControlEventTouchUpInside];
    _searchTextView.rightView=rightBtn;
    _searchTextView.rightViewMode=UITextFieldViewModeAlways;
    
    //徽章
    _zygBtn=[[DSZZYGBtn alloc]initWithFrame:CGRectMake(930, 0, 0, 0)];
    [self addSubview:_zygBtn];

    _tel = [NSKeyedUnarchiver unarchiveObjectWithFile:kFilePath];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(hiddenBuyNumBtn:) name:@"numberBuy" object:nil];
}


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

-(void)setbtnTitle{
    DSZZYGshopDatabase  *shopbase=[[DSZZYGshopDatabase alloc]init];
    [shopbase createDatabase];
    [shopbase createTable];
    NSArray *dataarray=  [shopbase query];
    [_zygBtn buyNumber:dataarray.count];
}
//搜索
- (IBAction)clickSearch {
    self.myBlock();
}




+(instancetype)createNavBar{
    return [[NSBundle mainBundle]loadNibNamed:@"DSZZHMNavBar" owner:self options:nil][0];
}


//搜索
-(void)searchBtn{
    
}
//搜索
-(void)saomiaoBtn{
    
}


//点击按   根据tag值判断点击的那个按钮

- (IBAction)clickBtnAction:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(didclickNavBtn:)]) {
        [self.delegate didclickNavBtn:sender];
        
    }
}


-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
