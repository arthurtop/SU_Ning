
//
//  DSZSYFFJView.m
//  8.1苏宁ipad
//
//  Created by lovena on 15/8/1.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZSYFFJView.h"
#import "DSZSYFirstModel.h"
#import "DSZSYMyCell.h"
@interface DSZSYFFJView ()
@property(nonatomic,retain)NSArray *titArray;//数组
@property(nonatomic,assign)CGFloat height;//单元格高度
@end
@implementation DSZSYFFJView

-(void)layoutSubviews
{
    self.tableView=[[UITableView alloc]initWithFrame:self.bounds];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self addSubview:self.tableView];
    
}
-(NSArray *)titArray
{
    if (_titArray==nil) {
        NSString *path=[[NSBundle mainBundle]pathForResource:@"Categories.plist" ofType:nil];
        NSArray *array=[NSArray arrayWithContentsOfFile:path];
        NSMutableArray *array2=[NSMutableArray array];
        for (NSDictionary *dic in array) {
            DSZSYFirstModel *f=[[DSZSYFirstModel alloc]initWithDic:dic];
            [array2 addObject:f];
        }
        _titArray=array2;
    }
    return _titArray;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.titArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID=@"cell";
    DSZSYMyCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell=[DSZSYMyCell createCell];
    }
    

        DSZSYFirstModel *f=self.titArray[indexPath.section];
        cell.firmodel=f;
    cell.backgroundColor=[UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    _height=cell.cellHeight;
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    DSZSYFirstModel *f=self.titArray[section];
    //创建view
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0,500, 40)];
    view.backgroundColor=[UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];

    //创建按钮
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:f.name forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    btn.titleLabel.font=[UIFont systemFontOfSize:15];
    CGSize sizebtn=[f.name boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    CGFloat btnw=sizebtn.width+20;
    CGFloat btnh=sizebtn.height+10;
    btn.frame=CGRectMake(20, 5, btnw, btnh);
    [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    
    //创建顶部分割线
    UIView *topView=[[UIView alloc]initWithFrame:CGRectMake(10, 0, 500, 1)];
    topView.backgroundColor=[UIColor lightGrayColor];
    topView.alpha=0.3;
    [view addSubview:topView];
    return view;

}
//段高
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _height;
}

// 点击按钮事件
-(void)clickBtn:(UIButton *)btn
{
    
    NSString *str=[btn titleForState:UIControlStateNormal];
    //NSLog(@"%@",str);
    if ([self.delegate respondsToSelector:@selector(sectionDidselectedNsttring:)]) {
        [self.delegate sectionDidselectedNsttring:str];
    }
}
@end
