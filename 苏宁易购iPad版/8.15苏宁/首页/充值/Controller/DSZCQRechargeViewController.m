//
//  DSZCQRechargeViewController.m
//  8.1苏宁ipad
//
//  Created by app20 on 15/8/4.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZCQRechargeViewController.h"
#import "DSZCQHistoryViewController.h"
#import "DSZHelpViewController.h"
#import "DSZCQPayViewController.h"
#import "DSZCQCellphoneRechargeView.h"
#import "DSZCQLifeFeesView.h"
#import "DSZCQFeesView.h"
#import "DSZCQOptionalView.h"
#import "DSZCQPayTypeView.h"
#import "DSZSYFtopView.h"
#import "DSZSYFtopejNavView.h"
#import "DSZCQCellphoneRechageModel.h"
#import "MBProgressHUD.h"
#import "DSZZHMMineViewController.h"
#import "DSZSYFSSViewController.h"
#import "Common.h"
#import "DSZFYJSaoMiaoViewController.h"
@interface DSZCQRechargeViewController ()<DSZCQPayTypeViewDelegate,DSZCQLifeFeesTypeViewDelegate,DSZSYFtopejNavViewDelegate>

@property(nonatomic,weak) UIView *menuSelectedView;
@property(nonatomic,weak) UIButton *lastBtn;
@property(nonatomic,weak) UIButton *helpBtn;
@property(nonatomic,weak) UIButton *historyBtn;
@property(nonatomic,assign) NSInteger index;
@property(nonatomic,weak) UIScrollView *mainView;
@property(nonatomic,weak) DSZCQCellphoneRechargeView *cellphoneRechargeView;
@property(nonatomic,assign) BOOL flag;

@end

@implementation DSZCQRechargeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 自定义导航栏
//    DSZSYFtopView *topView = [DSZSYFtopView createTopView];
//    topView.frame = CGRectMake(0, 20, self.view.width, 44);
//    topView.leftTextField.left = 45;
//    topView.myBtn.right = self.view.width - 30;
//    topView.buysBtn.right = self.view.width - 90;
//    topView.homeBtn.hidden = NO;
//    topView.homeBtn.right = self.view.width - 150;
//    [self.view addSubview:topView];
    DSZSYFtopejNavView *nav=[DSZSYFtopejNavView createNavView];
    nav.frame=CGRectMake(0, 20, self.view.width, 44);
    [nav setbtnTitle];
    nav.delegate=self;
    [self.view addSubview:nav];
    __weak DSZCQRechargeViewController *main=self;
    nav.myblock=^{
        
        DSZFYJSaoMiaoViewController *saomiao=[[DSZFYJSaoMiaoViewController alloc]init];
        saomiao.modalPresentationStyle=UIModalPresentationFormSheet;
        [main  presentViewController:saomiao animated:YES completion:nil];
    };

//    
//    [topView.homeBtn addTarget:self action:@selector(home) forControlEvents:UIControlEventTouchUpInside];
    
    // 向导航栏添加返回按钮
//    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    backBtn.frame = CGRectMake(15, 12, 12, 20);
//    [backBtn setBackgroundImage:[UIImage imageNamed:@"nav_back_normal.png"] forState:UIControlStateNormal];
//    [topView addSubview:backBtn];
    
//    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];

    // 添加导航栏与主视图分割线
    UIView *topLine = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, 1)];
    topLine.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:topLine];
    
    // 添加充值历史按钮
    UIButton *historyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    historyBtn.frame = CGRectMake(self.view.width - 200, 100, 90, 30);
    _historyBtn = historyBtn;
    historyBtn.font = [UIFont systemFontOfSize:16];
    [historyBtn setTitle:@"充值历史" forState:UIControlStateNormal];
    [historyBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [historyBtn setBackgroundImage:[UIImage imageNamed:@"button_white_normal.png"] forState:UIControlStateNormal];
    [self.view addSubview:historyBtn];
    
    [historyBtn addTarget:self action:@selector(clickHistoryBtn) forControlEvents:UIControlEventTouchUpInside];
    
    // 添加帮助按钮
    UIButton *helpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    helpBtn.frame = CGRectMake(self.view.width - 80, 100, 30, 30);
    _helpBtn = helpBtn;
    [helpBtn setBackgroundImage:[UIImage imageNamed:@"help_btn.png"] forState:UIControlStateNormal];
    [self.view addSubview:helpBtn];
    
    [helpBtn addTarget:self action:@selector(clickHelpBtn) forControlEvents:UIControlEventTouchUpInside];
    
    // 添加主视图
    UIScrollView *mainView = [[UIScrollView alloc] initWithFrame:CGRectMake(300, 65, 500, self.view.height - 64)];
    _mainView = mainView;
    [self.view addSubview:mainView];
    
    // 监测缴费协议是否点击
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clickProtocolBtn) name:@"protocol" object:nil];
    
    // 加载主菜单
    [self loadMenuBtns];
}


#pragma mark----导航栏代理
-(void)returnDelegate
{
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}
-(void)returnMainDelegate
{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}
-(void)searchBtnDelegate
{
    
    UIStoryboard *story=[UIStoryboard storyboardWithName:@"DSZSYFSSViewController" bundle:nil];
    DSZSYFSSViewController *vc=[story instantiateViewControllerWithIdentifier:@"sousuo"];
    [self.navigationController pushViewController:vc animated:NO];
}
//购物
-(void)gotoGW
{
    [self showShopCart];
    
}
//我的易购
-(void)myYG
{
    DSZZHMMineViewController *mineVC = [[DSZZHMMineViewController alloc]init];
    [self.navigationController pushViewController:mineVC animated:YES];
    
    
}

// 加载主菜单
-(void)loadMenuBtns
{
    CGFloat widgetY = 64;
    NSArray *images = @[@"Mobile_Pay.png",@"Life_Pay.png",@"fixed_state.png"];
    NSArray *title = @[@"手机充值",@"生活缴费",@"固话宽带"];
    for (int i = 0; i < 3; i++) {
        
        // 添加按钮视图
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, widgetY + 12, 25, 25)];
        imageView.image = [UIImage imageNamed:images[i]];
        [self.view addSubview:imageView];
        
        // 添加按钮
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, widgetY, 180, 50);
        btn.tag = i + 101;
        btn.font = [UIFont systemFontOfSize:15];
        [btn setTitle:title[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.view addSubview:btn];
        
        if (i == 0) {
            
            _lastBtn = btn;
            _index = btn.tag;
        }
        
        [btn addTarget:self action:@selector(clickMenuBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        // 添加按钮间分割线
        UIView *Hline = [[UIView alloc] initWithFrame:CGRectMake(0, widgetY + btn.height - 1, btn.width, 1)];
        Hline.backgroundColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1];
        [self.view addSubview:Hline];
        
        widgetY += btn.height;
    }
    
    // 添加选中视图
    UIView *selectedView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, 4, 50)];
    selectedView.backgroundColor = [UIColor orangeColor];
    _menuSelectedView = selectedView;
    [self.view addSubview:selectedView];
    
    // 添加竖直分割线
    UIView *VLine = [[UIView alloc] initWithFrame:CGRectMake(180, 64, 1, self.view.height - 64)];
    VLine.backgroundColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1];
    [self.view addSubview:VLine];
    
    [self loadCellphoneRechargeView];
    
}

// 加载手机充值视图
- (void)loadCellphoneRechargeView
{
    
    _mainView.contentSize = CGSizeMake(0, 0);
    
    // 手机充值视图
    DSZCQCellphoneRechargeView *rechargeView = [DSZCQCellphoneRechargeView createDSZCQCellphoneRechargeView];
    rechargeView.frame = CGRectMake(0, 0, 500, 380);
    _cellphoneRechargeView = rechargeView;
    [self.mainView addSubview:rechargeView];
    
    // 支付方式视图
    DSZCQPayTypeView *payTypeView = [DSZCQPayTypeView createDSZCQPayTypeView];
    payTypeView.frame = CGRectMake(0, rechargeView.height, 500, 145);
    payTypeView.delegate = self;
    [self.mainView addSubview:payTypeView];
}

// 加载生活缴费视图
- (void)loadLifeFeesView
{
    _mainView.contentSize = CGSizeMake(0, 900);
    
    // 加载费用种类视图
    DSZCQLifeFeesView *FeesTypeView = [DSZCQLifeFeesView createDSZCQLifeFeesView];
    FeesTypeView.frame = CGRectMake(0, 0, 500, 210);
    FeesTypeView.delegate = self;
    [self.mainView addSubview:FeesTypeView];
    
    // 添加缴费信息视图
    DSZCQFeesView *feesInfo = [DSZCQFeesView createDSZCQFeesView];
    feesInfo.frame = CGRectMake(0, FeesTypeView.height, 500, 240);
    [self.mainView addSubview:feesInfo];
    
    // 添加选择项
    DSZCQOptionalView *option = [DSZCQOptionalView createDSZCQOptionalView];
    option.frame = CGRectMake(0, FeesTypeView.height, 500, 100);
    [self.mainView addSubview:option];
    
    // 支付方式视图
    DSZCQPayTypeView *payTypeView = [DSZCQPayTypeView createDSZCQPayTypeView];
    payTypeView.frame = CGRectMake(0, FeesTypeView.height + option.height, 500, 145);
    payTypeView.delegate = self;
    [self.mainView addSubview:payTypeView];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText=@"加载中...";
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [hud hide:YES];
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        
        option.frame = CGRectMake(0, FeesTypeView.height + feesInfo.height - 60 + 1, 500, 100);
        payTypeView.frame = CGRectMake(0, FeesTypeView.height + option.height + feesInfo.height - 60 + 1, 500, 145);
        
        [UIView commitAnimations];
    });

    
    
}

// 加载电话宽带缴费视图
- (void)loadTeleponeBroadbandFessView
{
    
    _mainView.contentSize = CGSizeMake(0, 900);
    
    // 加载费用种类视图
    DSZCQLifeFeesView *FeesTypeView = [DSZCQLifeFeesView createDSZCQLifeFeesView];
    FeesTypeView.frame = CGRectMake(0, 0, 500, 210);
    [self.mainView addSubview:FeesTypeView];
    
    // 添加缴费信息视图
    DSZCQFeesView *feesInfo = [DSZCQFeesView createDSZCQFeesView];
    feesInfo.frame = CGRectMake(0, FeesTypeView.height, 500, 240);
    [self.mainView addSubview:feesInfo];
    
    // 添加选择项
    DSZCQOptionalView *option = [DSZCQOptionalView createDSZCQOptionalView];
    option.frame = CGRectMake(0, FeesTypeView.height, 500, 100);
    [self.mainView addSubview:option];
    
    // 支付方式视图
    DSZCQPayTypeView *payTypeView = [DSZCQPayTypeView createDSZCQPayTypeView];
    payTypeView.frame = CGRectMake(0, FeesTypeView.height + option.height, 500, 145);
    payTypeView.delegate = self;
    [self.mainView addSubview:payTypeView];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText=@"加载中...";
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [hud hide:YES];
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        
        option.frame = CGRectMake(0, FeesTypeView.height + feesInfo.height  + 1, 500, 100);
        payTypeView.frame = CGRectMake(0, FeesTypeView.height + option.height + feesInfo.height  + 1, 500, 145);
        
        [UIView commitAnimations];
    });

}

-(void)home
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)back
{
    
    [self.navigationController popViewControllerAnimated:YES];
}

// 点击菜单按钮
- (void)clickMenuBtn:(UIButton *)btn
{
    
    if (_lastBtn != btn) {
        
        [_mainView removeFromSuperview];
        
        // 添加主视图
        UIScrollView *mainView = [[UIScrollView alloc] initWithFrame:CGRectMake(300, 65, 500, self.view.height - 64)];
        mainView.showsVerticalScrollIndicator = NO;
        _mainView = mainView;
        [self.view addSubview:mainView];
        
        int widget = 64;
        _menuSelectedView.top = widget + 50 * (btn.tag - 101);
        
        _lastBtn = btn;
        
        if (btn.tag == 101) {
            
            _index = btn.tag;
            _helpBtn.hidden = NO;
            [_historyBtn setTitle:@"充值历史" forState:UIControlStateNormal];
            [self loadCellphoneRechargeView];
            
        }else if (btn.tag == 102){
        
            _index = btn.tag;
            _helpBtn.hidden = NO;
            [_historyBtn setTitle:@"缴费历史" forState:UIControlStateNormal];
            [self loadLifeFeesView];
            
        }else{
        
            _index = btn.tag;
            _helpBtn.hidden = YES;
            [_historyBtn setTitle:@"缴费历史" forState:UIControlStateNormal];
            [self loadTeleponeBroadbandFessView];
            
        }
    }
}

// 点击充值历史按钮
- (void)clickHistoryBtn
{
    DSZCQHistoryViewController *historyVC = [[DSZCQHistoryViewController alloc] init];
    historyVC.index = _index;
    [self.navigationController pushViewController:historyVC animated:YES];
}

// 点击帮助按钮
- (void)clickHelpBtn
{
    DSZHelpViewController *helpVC = [[DSZHelpViewController alloc] init];
    helpVC.index = _index;
    [self.navigationController pushViewController:helpVC animated:YES];
    
}

// 点击缴费协议按钮
- (void)clickProtocolBtn
{
    DSZHelpViewController *helpVC = [[DSZHelpViewController alloc] init];
    helpVC.index = 103;
    [self.navigationController pushViewController:helpVC animated:YES];
}

// 点击支付按钮
- (void)clickBankBtn
{
    
    if (_index == 101) {
        
        if (_cellphoneRechargeView.numberTextField.text.length == 11 && ![_cellphoneRechargeView.price.text  isEqual: @"0.00"]) {
            
            NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"cellphoneRechargeHistory.data"];
            
            NSMutableArray *cellphoneRechargeHistoryAry = [NSMutableArray array];
            
            if ([NSKeyedUnarchiver unarchiveObjectWithFile:filePath]) {
                
                cellphoneRechargeHistoryAry = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
            }
            
            DSZCQCellphoneRechageModel *cellphoneRechageModel = [[DSZCQCellphoneRechageModel alloc] init];
            
            cellphoneRechageModel.IDNumber = [NSString stringWithFormat:@"%03lu",(unsigned long)cellphoneRechargeHistoryAry.count];
            
            cellphoneRechageModel.cellphoneNumber = [NSString stringWithString:_cellphoneRechargeView.numberTextField.text];
            cellphoneRechageModel.shouldPrice = [NSString stringWithFormat:@"%0.2f元",_cellphoneRechargeView.shouldPrice];
            cellphoneRechageModel.truePrice = [NSString stringWithFormat:@"%0.2f元",_cellphoneRechargeView.truePrice];
            
            NSDate *now = [NSDate date];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
            NSString *time = [formatter stringFromDate:now];
            
            cellphoneRechageModel.time = [NSString stringWithString:time];
            cellphoneRechageModel.state = @"未付款";
            
            [cellphoneRechargeHistoryAry insertObject:cellphoneRechageModel atIndex:0];
            
            [NSKeyedArchiver archiveRootObject:cellphoneRechargeHistoryAry toFile:filePath];
            
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeIndeterminate;
            hud.labelText=@"加载中...";
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [hud hide:YES];
                
                DSZCQPayViewController *payVC = [[DSZCQPayViewController alloc] init];
                NSString *price = [NSString stringWithFormat:@"%0.2f元",_cellphoneRechargeView.truePrice];
                payVC.price = price;
                [self.navigationController pushViewController:payVC animated:NO];
                
            });
        }else if (_cellphoneRechargeView.numberTextField.text.length == 11 &&[_cellphoneRechargeView.price.text  isEqual: @"0.00"]){
            
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelText=@"请选择要充值的金额";
            
            [hud hide:YES afterDelay:3];
            
            
        }else if (_cellphoneRechargeView.numberTextField.text.length < 11){
            
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelText=@"请输入正确手机号";
            
            [hud hide:YES afterDelay:3];
        }
    }else if(_index == 102){
        
        
    
    }
}

- (void)clickLifeFeesTypeBtn:(NSInteger)index
{

}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"protocol" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    if (self.view.window == nil)
    {
        self.view = nil;
    }
}

@end
