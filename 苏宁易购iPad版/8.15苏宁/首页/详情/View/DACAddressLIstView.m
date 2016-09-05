//
//  DACAddressLIstView.m
//  8.2二级界面
//
//  Created by app33 on 15/8/5.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DACAddressLIstView.h"
#import "addNewAddressView.h"
#import "DACAddressListCell.h"
#define FilePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]stringByAppendingPathComponent:@"address.data"]
@implementation DACAddressLIstView

+(id)createAddressListView
{
    return [[[NSBundle mainBundle]loadNibNamed:@"DACAddressLIstView" owner:nil options:nil]lastObject];
}


-(void)layoutSubviews
{
    self.addressTableView.delegate = self;
    self.addressTableView.dataSource = self;
    self.addressTableView.rowHeight = 98;
    [self.addressTableView reloadData];
}
-(NSArray *)total
{
    _total = [NSArray array];
    _total = [NSKeyedUnarchiver unarchiveObjectWithFile:FilePath];
    return _total;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.total.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DACAddressListCell *cell =[DACAddressListCell createListCellView:tableView];
    DACAddressModel *model = self.total[indexPath.row];
    [cell setModel:model];
    return cell;
}

- (IBAction)returnClick {
    [self removeFromSuperview];
}

- (IBAction)addAddressClick {
    addNewAddressView *view = [addNewAddressView createAddNewAddressView];
    view.frame =self.bounds;
    [self addSubview:view];
}

@end
