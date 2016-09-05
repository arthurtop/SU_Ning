//
//  DSZZHMMyOrderViewController.m
//  8.1苏宁ipad
//
//  Created by app01 on 15/8/4.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZZHMMyOrderViewController.h"
#import "DSZZHMOrderCell.h"
#import "DSZZHMNoHistoryView.h"
#import "Common.h"
#import "TGCover.h"
#import "DACBuyNowView.h"
#import "DSZZHMOderModel.h"

#define kFilePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"login.data"]
#define FilePath3 [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]stringByAppendingPathComponent:@"oder.data"]


@interface DSZZHMMyOrderViewController ()


{
    TGCover *cover;;
    DACBuyNowView *buyView;
}


@property(strong,nonatomic)DSZZHMNoHistoryView *nohistory;
@property(copy,nonatomic)NSString *tel;

@property(copy,nonatomic)DSZZHMOderModel *delModle;
@end

@implementation DSZZHMMyOrderViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notice:) name:@"loginsuccessed" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(exit) name:@"exit" object:nil];
    
    //NSLog(@"%@",FilePath3);
    _tel = [NSKeyedUnarchiver unarchiveObjectWithFile:kFilePath];
    if (_tel != nil) {
        _orderArray = [NSMutableArray array];
        _orderArray = [NSKeyedUnarchiver unarchiveObjectWithFile:FilePath3];
    }

    
    
}



-(void)exit{
    _orderArray = nil;
    [self.tableView reloadData];
}

//保留通知传递的参数
-(void)notice:(NSNotification *)notification{
    
    
    if (!_orderArray) {
        _orderArray = [NSMutableArray array];
        _orderArray = [NSKeyedUnarchiver unarchiveObjectWithFile:FilePath3];
    }
    [self.tableView reloadData];
}



#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (_orderArray.count == 0) {
        if (_nohistory == nil) {
            
            _nohistory = [[DSZZHMNoHistoryView alloc]init];
            _nohistory.center = CGPointMake(self.tableView.center.x, self.tableView.center.y-100);
            _nohistory.size = CGSizeMake(300, 300);
            __block DSZZHMMyOrderViewController *vc = self;
            _nohistory.goBlock = ^{
                [vc.navigationController popToRootViewControllerAnimated:YES];
            };
            [self.tableView insertSubview:_nohistory atIndex:0];
        }else{
            _nohistory.hidden = NO;
        }
        
        
    }else{
        _nohistory.hidden = YES;
    }

    
    return _orderArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static  NSString *ID = @"order";
    DSZZHMOrderCell *cell  = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[DSZZHMOrderCell alloc]init];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = _orderArray[indexPath.row];
    
    UILongPressGestureRecognizer *press = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(pressAction:)];
    [cell addGestureRecognizer:press];
    
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    

    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 197;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 20;
}



- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //editingStyle = UITableViewCellEditingStyleDelete;
    
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"是否确定删除" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
    
    
    
}


#pragma mark - alertView data source

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        
        DSZZHMOderModel *model = _delModle;
        for (DSZZHMOderModel *m in _orderArray) {
            if ([m.orderid isEqualToString:model.orderid]) {
                [_orderArray removeObject:m];
                //[NSKeyedArchiver archiveRootObject:_orderArray toFile:FilePath3];
                break;
            }
        }
        
    }
    [self.tableView reloadData];
    [self.tableView setEditing:NO animated:YES];
}



//长安动作
-(void)pressAction:(UILongPressGestureRecognizer *)press{
    
    [self.tableView setEditing:YES animated:YES];
    
    DSZZHMOrderCell *cell = (DSZZHMOrderCell *)press.view;
    _delModle = cell.model;

}


-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


@end
