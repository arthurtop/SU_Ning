//
//  addNewAddressView.m
//  8.2二级界面
//
//  Created by app33 on 15/8/5.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "addNewAddressView.h"
#import "addNewAddressCell1.h"
#import "addNewAddressCell2.h"
#import "addNewAddressCell3.h"
#import "UIViewExt.h"
#import "MBProgressHUD+MJ.h"
#import "MBProgressHUD.h"
#import "DACAddressModel.h"
#import "DACAddressLIstView.h"
#define FilePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]stringByAppendingPathComponent:@"address.data"]
@implementation addNewAddressView

+(id)createAddNewAddressView
{
    return [[[NSBundle mainBundle]loadNibNamed:@"addNewAddressView" owner:nil options:nil]lastObject];
}

-(void)awakeFromNib
{
    self.tableView.dataSource =self;
    self.tableView.delegate = self;
    self.isclick = NO;
    _total = [NSMutableArray array];
    //增加回滚区域
    self.tableView.separatorInset = UIEdgeInsetsMake(-40, 0, 0, 0);
    self.tableView.contentOffset = CGPointMake(0, -40);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count ;
    if (section==0) {
        count = 4;
    }
    else
    {
        count = 1;
    }
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     static NSString *name = @"cell";
    UITableViewCell *cell1;
    if (indexPath.section==0&&indexPath.row==0) {
        addNewAddressCell1 *cell = [addNewAddressCell1 createNewAddressCell1];
        cell.name.text = @"收货人";
        cell.textFiled.placeholder = @"请输入收货人姓名";
        cell1 = cell;
    }
    if (indexPath.section==0&&indexPath.row==1) {
        addNewAddressCell1 *cell = [addNewAddressCell1 createNewAddressCell1];
        cell.name.text = @"手机号码";
        cell.textFiled.placeholder = @"请输入手机号码";
        cell.textFiled.keyboardType = UIKeyboardTypeNumberPad;
        cell1 = cell;
    }
    if (indexPath.section==0&&indexPath.row==2) {
        addNewAddressCell2 *cell = [addNewAddressCell2 createNewAddressCell2];
        
        if (_isclick) {
            cell.height = 200;
            cell.pickView.hidden = NO;
        }
        else
        {
            cell.height = 48;
             cell.pickView.hidden = YES;
        }
        NSUserDefaults *defaluts = [NSUserDefaults standardUserDefaults];
        NSString *str4=[defaluts objectForKey:@"str"];
        cell.addressLabel.text = str4;
        cell1 = cell;
    }
    if (indexPath.section==0&&indexPath.row==3) {
        addNewAddressCell1 *cell = [addNewAddressCell1 createNewAddressCell1];
        cell.name.text = @"详细地址";
        cell.textFiled.placeholder = @"请输入详细地址";
        cell1 = cell;
    }
    if (indexPath.section==1&&indexPath.row==0) {
        addNewAddressCell3 *cell = [addNewAddressCell3 createNewAddressCell3];
        cell1 =cell;
    }
    cell1.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0.0;
    if (indexPath.section==0&&indexPath.row==0) {
        height = 48;
    }
    if (indexPath.section==0&&indexPath.row==1) {
        height = 48;
    }
    if (indexPath.section==0&&indexPath.row==2) {
        if (_isclick) {
            height = 200;
        }
        else
        {
            height = 48;
        }
    }
    if (indexPath.section==0&&indexPath.row==3) {
        height = 48;
    }
    if (indexPath.section==1&&indexPath.row==0) {
        height = 48;
    }
    return height;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0&&indexPath.row==0) {
        //addNewAddressCell1 *cell  = (addNewAddressCell1*)[tableView cellForRowAtIndexPath:indexPath];
    }
    if (indexPath.section==0&&indexPath.row==2) {
        if (_isclick==NO) {
            _isclick = YES;
           //addNewAddressCell2 *cell  = (addNewAddressCell2*)[tableView cellForRowAtIndexPath:indexPath];
           
        }
        else
        {
          _isclick = NO;
        }
        //[self.tableView reloadData];
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationNone];

          }
   
}


- (IBAction)returnClick {
    [self removeFromSuperview];
}

- (IBAction)finishDoneClick {
    //先归档，再出去
     addNewAddressCell1 *cell1  = (addNewAddressCell1*)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    addNewAddressCell1 *cell2  = (addNewAddressCell1*)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    addNewAddressCell2 *cell3  = (addNewAddressCell2*)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
     addNewAddressCell1 *cell4  = (addNewAddressCell1*)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    addNewAddressCell3 *cell5 = (addNewAddressCell3*)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    DACAddressModel *model = [[DACAddressModel alloc]init];
    model.name = cell1.textFiled.text;
    model.phone = cell2.textFiled.text;
    NSString *str = cell3.addressLabel.text;
    NSString *str2 = cell4.textFiled.text;
    model.address = [NSString stringWithFormat:@"%@ %@",str,str2];
    model.flag = YES;
    model.isDefault = cell5.buttonView.isOn;
    //读档
    _total = [NSKeyedUnarchiver unarchiveObjectWithFile:FilePath];
    if (_total == NULL) {
        _total = [NSMutableArray array];
    }
    else
    {
    //更改数组里默认被选中的，让最新的被选中
     for (int i = 0; i < _total.count; i++) {
         DACAddressModel *dmodel = _total[i];
         dmodel.flag = NO;
         if (dmodel.isDefault) {
             if (model.isDefault) {
                 dmodel.isDefault = NO;
             }
         }
     }
    }
    [_total insertObject:model atIndex:0];
    [NSKeyedArchiver archiveRootObject:_total toFile:FilePath];
    DACAddressLIstView *list = [[DACAddressLIstView alloc]init];
    [list.addressTableView  reloadData];
    [self removeFromSuperview];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    CGFloat heigh;
    if (section==0) {
        heigh = 0.000001;
    }
    else
    {
        heigh = 20;
    }
    return heigh;
}
@end
