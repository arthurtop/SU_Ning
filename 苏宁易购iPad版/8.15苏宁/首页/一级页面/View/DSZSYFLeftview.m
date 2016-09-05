//
//  DSZSYFLeftview.m
//  8.1苏宁ipad
//
//  Created by lovena on 15/8/1.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZSYFLeftview.h"
#import "DSZSYFLeftCell.h"
@implementation DSZSYFLeftview

-(void)awakeFromNib
{
    //数组内容
    _titleArray=@[@"热门推荐",@"服装鞋帽",@"手机数码",@"家用电器",@"电脑办公",@"生活电器",@"厨卫电器",@"母婴玩具",@"美妆洗护",@"食品生鲜",@"酒水饮料",@"居家生活",@"运动户外",@"家居建材",@"内衣配饰",@"汽车用品",@"皮具箱包",@"精品钟表",@"黄金饰品",@"图书音像"];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.showsVerticalScrollIndicator=NO;
    _tableView.backgroundColor=[UIColor clearColor];
    _cellIndex=MAXFLOAT;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _titleArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID=@"cell";
    DSZSYFLeftCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell=[DSZSYFLeftCell createCell];
    }
    cell.titLabel.text=self.titleArray[indexPath.row];
    cell.tag=indexPath.row;
    //选中时的背景图片
    cell.selectedBackgroundView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tabselectedbtn"]];
    //选中后的字体颜色
    cell.titLabel.highlightedTextColor = [UIColor darkGrayColor];

    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}
//选中
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        if ([self.delegate respondsToSelector:@selector(didselectedCell)]) {
            [self.delegate didselectedCell];
        _cellIndex=indexPath.row;
        _cell=(UITableViewCell *)[tableView viewWithTag:_cellIndex];
    }
}

-(void)didntSelected{
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}

@end
