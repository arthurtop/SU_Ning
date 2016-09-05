//
//  DACSubmitView.m
//  8.2二级界面
//
//  Created by mini on 15/8/6.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DACSubmitView.h"
#import "DSZCQRechargeViewController.h"
#import"DSZCQPayTypeView.h"
#import "DSZCQPayViewController.h"
@implementation DACSubmitView

+(id)createSubmitView
{
    return [[[NSBundle mainBundle]loadNibNamed:@"DACSubmitView" owner:nil options:nil]lastObject];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if (indexPath.row==0) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
        cell.textLabel.text = @"银联在线支付";
        cell.detailTextLabel.text = @"支付人数多,如无法支付,请优先选择易付宝支付";
    }
    else
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
        cell.textLabel.text = @"易付宝支付";
        cell.detailTextLabel.text = @"支持银行卡快捷,易付宝余额等多种支付方式";
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (IBAction)returnClick {
//    [self removeFromSuperview];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"友情提示" message:@"您的订单已提交成功，如果暂不支付，可在等待支付订单中找到并支付" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        [self removeFromSuperview];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UINavigationController *nav=(UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    DSZCQPayViewController *vc=[[DSZCQPayViewController alloc]init];
    [nav pushViewController:vc animated:YES];
}
@end
