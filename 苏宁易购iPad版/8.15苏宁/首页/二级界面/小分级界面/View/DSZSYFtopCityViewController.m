//
//  DSZSYFtopCityViewController.m
//  8.2二级界面
//
//  Created by lovena on 15/8/2.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZSYFtopCityViewController.h"
#import"DSZSYFCity.h"
#import "DSZSYFCitySection.h"
#import "MJExtension.h"
#import "NSObject+Value.h"
@interface DSZSYFtopCityViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,retain)NSMutableArray *allCitys;//所有的城市组
@end

@implementation DSZSYFtopCityViewController

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
    _tableView.showsVerticalScrollIndicator=NO;
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_tableView];
}

#pragma mark 加载城市数据
-(NSMutableArray *)cityArray
{
    if (_cityArray==nil) {
        NSArray *azArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"SYFCities.plist" ofType:nil]];
        NSMutableArray *array2=[NSMutableArray array];
        for (NSDictionary *azDict in azArray) {
                    // 创建城市组
        DSZSYFCitySection *section = [[DSZSYFCitySection alloc] init];
        [section setKeyValues:azDict];
        [array2 addObject:section];
    }
        _cityArray=array2;
  }
    return _cityArray;
}

#pragma mark---表的代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.cityArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    DSZSYFCitySection *s=_cityArray[section];
    return s.cities.count;
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
    DSZSYFCitySection *s=_cityArray[indexPath.section];
    DSZSYFCity *city=s.cities[indexPath.row];
    cell.textLabel.text=city.name;
    return cell;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    DSZSYFCitySection *s=_cityArray[section];
    return s.name;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //把表选中的值穿过去
    DSZSYFCitySection *s=self.cityArray[indexPath.section];
    DSZSYFCity *city=s.cities[indexPath.row];
    NSString *name=city.name;
    if ([self.delegate respondsToSelector:@selector(didselectedCell:)]) {
        [self.delegate didselectedCell:name];
    }
    
//    NSDictionary *dic=@{@"name":name};
//    //通知
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"cityBtn" object:nil userInfo:dic];
    
}
@end
