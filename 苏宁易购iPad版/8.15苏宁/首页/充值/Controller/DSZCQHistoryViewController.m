//
//  DSZCQHistoryViewController.m
//  8.1苏宁ipad
//
//  Created by app20 on 15/8/5.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZCQHistoryViewController.h"
#import "DSZCQHistoryTableViewCell.h"
#import "DSZSYFtopView.h"
#import "Common.h"
#import "DSZSYFtopejNavView.h"
#import "DSZFYJSaoMiaoViewController.h"
#import "DSZSYFSSViewController.h"
#import "DSZZHMMineViewController.h"
@interface DSZCQHistoryViewController ()<UITableViewDataSource,UITableViewDelegate,DSZSYFtopejNavViewDelegate>

@property(nonatomic,weak) UILabel *mianTitle;
@property(nonatomic,strong) NSMutableArray *cellphoneRechargeHistory;

@end

@implementation DSZCQHistoryViewController

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
//    
//    [topView.homeBtn addTarget:self action:@selector(home) forControlEvents:UIControlEventTouchUpInside];
//    
//    // 向导航栏添加返回按钮
//    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    backBtn.frame = CGRectMake(15, 12, 12, 20);
//    [backBtn setBackgroundImage:[UIImage imageNamed:@"nav_back_normal.png"] forState:UIControlStateNormal];
//    [topView addSubview:backBtn];
    
   // [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    DSZSYFtopejNavView *nav=[DSZSYFtopejNavView createNavView];
    nav.frame=CGRectMake(0, 20, self.view.width, 44);
    [nav setbtnTitle];
    nav.delegate=self;
    [self.view addSubview:nav];
    
    __weak DSZCQHistoryViewController *main=self;
    
    nav.myblock=^{
        
        DSZFYJSaoMiaoViewController *saomiao=[[DSZFYJSaoMiaoViewController alloc]init];
        saomiao.modalPresentationStyle=UIModalPresentationFormSheet;
        [main  presentViewController:saomiao animated:YES completion:nil];
    };
    
    
    // 添加导航栏与主视图分割线
    UIView *topLine = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, 1)];
    topLine.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:topLine];
    
    // 添加标题
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 64 + 25, self.view.width, 38)];
    _mianTitle = title;
    title.text = @"手机充值历史";
    title.textColor = [UIColor blackColor];
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont systemFontOfSize:25];
    [self.view addSubview:title];
    
    // 添加分割线
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(212, 130, 600, 3)];
    lineView.backgroundColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1];
    [self.view addSubview:lineView];
    
    // 添加表格
    UITableView *hiestoryTableView = [[UITableView alloc]initWithFrame:CGRectMake(210, 135, 600, 580) style:UITableViewStylePlain];
    hiestoryTableView.dataSource = self;
    hiestoryTableView.delegate = self;
    hiestoryTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:hiestoryTableView];
    
    _cellphoneRechargeHistory = [NSMutableArray array];
    
    NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"cellphoneRechargeHistory.data"];
    
    _cellphoneRechargeHistory = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
}


#pragma mark----导航栏代理
-(void)returnDelegate
{
    //[self.navigationController popToRootViewControllerAnimated:YES];
    [self.navigationController popViewControllerAnimated:YES];
    
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



#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    return _cellphoneRechargeHistory.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"CellphoneCell";
    
    DSZCQHistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        
        cell = [DSZCQHistoryTableViewCell createDSZCQHistoryTableViewCell];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.cellphoneRechageHistory = _cellphoneRechargeHistory[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}

-(void)home
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)back
{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    if (self.view.window == nil)
    {
        self.view = nil;
    }
}

@end
