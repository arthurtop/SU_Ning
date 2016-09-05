//
//  DSZSYFtopSortViewController.m
//  8.2二级界面
//
//  Created by lovena on 15/8/2.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZSYFtopSortViewController.h"
#import "MJExtension.h"
#import "NSObject+Value.h"
@interface DSZSYFtopSortViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation DSZSYFtopSortViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTableView];
}
#pragma mark 添加tableView
- (void)addTableView
{
    _tableView = [[UITableView alloc] init];
    _tableView.frame = CGRectMake(0,0, self.view.frame.size.width,self.view.frame.size.height);
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_tableView];
}
#pragma mark---加载数据
-(NSArray *)sortArray
{
    if (_sortArray==nil) {
        NSString *path=[[NSBundle mainBundle]pathForResource:@"SYFOrders.plist" ofType:nil];
        _sortArray=[NSArray arrayWithContentsOfFile:path];
        
    }
    return _sortArray;
}

#pragma mark---表的代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.sortArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    //选中效果
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.textLabel.text=self.sortArray[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *name=self.sortArray[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(didselectedSort:row:)]) {
        [self.delegate didselectedSort:name row:indexPath.row+1];
    }
}

@end
