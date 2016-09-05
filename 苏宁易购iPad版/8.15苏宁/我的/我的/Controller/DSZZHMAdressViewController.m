//
//  DSZZHMAdressViewController.m
//  8.1苏宁ipad
//
//  Created by app01 on 15/8/4.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZZHMAdressViewController.h"
#import "DSZZHMAddressHeaderView.h"
#import "DSZZHMEditAddressController.h"
#import "DSZZHMAddressCell.h"
#import "DSZZHMAddressModel.h"
#import "Common.h"
#import "FMDB.h"

#define kFilePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"login.data"]


//再造编辑地址控制器时保留的返回，完成按钮并添加事件 保存地址新增地址是通过调用编辑地址控制器里的finish方法完成

@interface DSZZHMAdressViewController ()<DSZZHMAddNewAddressDelegate>

{
    //点击添加地址时保留addressVC便于保存和修改数据
    DSZZHMEditAddressController *addressVC;
    
}

@property(strong,nonatomic)UIView *noAddressView;

//保存要删除的model便于在数据库中删除
@property(retain,nonatomic)DSZZHMAddressModel *delModel;

//添加错误信息  通知传过来的
@property(copy,nonatomic)NSString *Info;

//返回按钮
@property(weak,nonatomic)UIButton *returnBtn;
//完成编辑
@property(weak,nonatomic)UIButton *finishEditBtn;
//设置默认地址开关
@property(weak,nonatomic)UISwitch *defaultAddressSwitch;



//数据库对象
@property (nonatomic, strong) FMDatabase *db;
@property (nonatomic, strong) FMDatabaseQueue *queue;


@property(copy,nonatomic)NSString *tel;



@end

@implementation DSZZHMAdressViewController



//-(void)viewWillLayoutSubviews
//{
//    _addressArray = [NSMutableArray array];
//    _addressArray = [self addressArray];
//    
//    
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //不显示分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.scrollEnabled = YES;
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(errorInfo:) name:@"addError" object:nil];
    
    
    NSString *filename = [NSString stringWithFormat:@"%@/Documents/resgist.sqlite",NSHomeDirectory()];
    //NSLog(@"%@",filename);
    // 1.创建数据库队列
    self.queue = [FMDatabaseQueue databaseQueueWithPath:filename];


    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notice:) name:@"loginsuccessed" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(exit) name:@"exit" object:nil];
    
    _tel = [NSKeyedUnarchiver unarchiveObjectWithFile:kFilePath];
    if (_tel != nil) {
        _addressArray = [NSMutableArray array];
        _addressArray = [self addressArray];
    }
    
    
}


//保留通知传递的参数
-(void)notice:(NSNotification *)notification{
    
    _addressArray = [NSMutableArray array];
    _addressArray = [self addressArray];
    [self.tableView reloadData];

}

-(void)exit{
    _addressArray = nil;
    [self.tableView reloadData];
}


-(NSArray *)addressArray{
    
    [self.queue inDatabase:^(FMDatabase *db) {
        // 1.查询数据
        FMResultSet *rs = [db executeQuery:@"select * from  adress"];

        while (rs.next) {
            
            DSZZHMAddressModel *model = [[DSZZHMAddressModel alloc]init];
            model.name = [rs stringForColumn:@"name"];
            model.tel = [rs stringForColumn:@"tel"];
            model.address = [rs stringForColumn:@"address"];
            model.detailAddress = [rs stringForColumn:@"detailAddress"];
            model.defaultAddress = [rs stringForColumn:@"defaultAddress"];
            
            [_addressArray insertObject:model atIndex:0];
        }
        [rs close];
    }];

    return _addressArray;
}



#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (_addressArray.count == 0) {
        if (_noAddressView == nil) {
            
            _noAddressView = [[UIView alloc]init];
            _noAddressView.frame = self.view.frame;
            
            UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"lionHead.png"]];
            image.center = CGPointMake(_noAddressView.center.x, _noAddressView.center.y - 100);
            image.size = CGSizeMake(100, 100);
            [_noAddressView insertSubview:image atIndex:0];
            
            UILabel *lable = [[UILabel alloc]init];
            lable.size = CGSizeMake(250, 30);
            lable.center = CGPointMake(_noAddressView.center.x, _noAddressView.center.y );
            lable.textAlignment = NSTextAlignmentCenter;
            lable.text = @"你还没有添加地址赶快行动起来";
            lable.font = [UIFont systemFontOfSize:14];
            [_noAddressView insertSubview:lable atIndex:0];
            
            [self.view insertSubview:_noAddressView atIndex:0];
            
            
        }else{
            _noAddressView.hidden = NO;
        }
        
        
    }else{
        _noAddressView.hidden = YES;
    }

    return _addressArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"cell";
    
    DSZZHMAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[DSZZHMAddressCell alloc]init];
    }
    cell.model = _addressArray[indexPath.row];
    
    UILongPressGestureRecognizer *press = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(pressAction:)];
    [cell addGestureRecognizer:press];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DSZZHMAddressModel *model = _addressArray[indexPath.row];
    addressVC.name.text = model.name;
    addressVC.tel.text = model.tel;
    NSArray *text  = [model.address componentsSeparatedByString:@" "];
    addressVC.province.text = text[0];
    addressVC.city.text = text[1];
    addressVC.district.text = text[2];
    addressVC.detailAddress.text = model.detailAddress;
    if ([model.defaultAddress isEqualToString:@"1"]) {
        addressVC.defaultAddressBtn.on = YES;
    }else{
        addressVC.defaultAddressBtn.on = NO;
    }
    [self.view addSubview:addressVC.view];
    
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //editingStyle = UITableViewCellEditingStyleDelete;
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"是否确定删除" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];

}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    DSZZHMAddressHeaderView *header = [[DSZZHMAddressHeaderView alloc]init];
    header.delegate = self;
    return header;
}

#pragma mark - alertView data source

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [self deleteCell];
    }
    [self.tableView reloadData];
    [self.tableView setEditing:NO animated:YES];
}


#pragma mark - DSZZHMAddNewAddressDelegate data source

-(void)addClick{
    
    DSZZHMEditAddressController *vc = [[DSZZHMEditAddressController alloc]init];
    vc.view.frame = self.view.frame;
    vc.view.tag = 100;
    
    //返回按钮
    UIButton *btn = (UIButton *)vc.returnAddressBtn;
    [btn addTarget:self action:@selector(returnAddressVC) forControlEvents:UIControlEventTouchUpInside];
    _returnBtn = btn;
    
    //完成编辑
    UIButton *btn1 = (UIButton *)vc.finishEditBtn;
    [btn1 addTarget:self action:@selector(finishEdit) forControlEvents:UIControlEventTouchUpInside];
    _finishEditBtn = btn1;
    
    //设置默认地址开关
    UISwitch *s = (UISwitch *)vc.defaultAddressBtn;
    [s addTarget:self action:nil forControlEvents:UIControlEventValueChanged];
    _defaultAddressSwitch = s;
    
    [self.view addSubview:vc.view];
    self.tableView.scrollEnabled = NO;
    addressVC = vc;
    
}


-(void)finishEdit{
    
    //调用DSZZHMEditAddressController中的方法finish
    [addressVC finish];
    
    if (_Info!= nil) {
        _Info = nil;
        return;
    }
    
    [self returnAddressVC];
}


//返回地址管理
-(void)returnAddressVC{
    
    UIView *view = [self.view viewWithTag:100];
    
    view.transform = CGAffineTransformMakeTranslation(view.frame.size.width, 0);
    view.alpha = 0;
    
    [UIView animateWithDuration:0.5 animations:^{
        
        view.transform = CGAffineTransformIdentity;
        view.alpha = 1;
        
    }completion:^(BOOL finished) {
        // 恢复属性
        view.transform = CGAffineTransformIdentity;
        view.alpha  = 1;
        
    }];
    
    _addressArray = [NSMutableArray array];
    _addressArray = [self addressArray];
    
    //注意先刷表再移除否则会出现添加后第一次返回无法更新的bug
    self.tableView.scrollEnabled = YES;
    [self.tableView reloadData];

    [view removeFromSuperview];
    view = nil;
    
}

//

//保留通知传递的参数
-(void)errorInfo:(NSNotification *)notification{
    
    _Info = notification.object;
    
}
//删除单元格

-(void)deleteCell{
    
    NSString *tel = _delModel.tel;
    
    [self.queue inDatabase:^(FMDatabase *db) {
        
        [db executeUpdate:@"delete from adress where tel = ? ",tel];
        //NSLog(@"%@",tel);
    }];
    for (DSZZHMAddressModel *model in _addressArray) {
        if ([model.tel isEqualToString:tel]) {
            [_addressArray removeObject:model];
            break;
        }
    }
    
}

//长安动作
-(void)pressAction:(UILongPressGestureRecognizer *)press{
    
    [self.tableView setEditing:YES animated:YES];
    DSZZHMAddressCell *cell = (DSZZHMAddressCell *)press.view;
    _delModel = cell.model;
    cell.editBtn.hidden = YES;
    
    
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}



@end
