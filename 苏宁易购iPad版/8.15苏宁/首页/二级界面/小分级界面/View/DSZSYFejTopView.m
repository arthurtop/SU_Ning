//
//  DSZSYFejTopView.m
//  8.2二级界面
//
//  Created by lovena on 15/8/2.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZSYFejTopView.h"
#import "DSZSYFtopCityViewController.h"
#import "DSZSYFtopSortViewController.h"
#import "DSZFYJDataTool.h"
#import "DSZZYGBtn.h"
#import "DSZZYGshopDatabase.h"
@interface DSZSYFejTopView()<UIPopoverControllerDelegate,DSZSYFtopCityViewControllerDelegate>
@property(nonatomic,strong)UIPopoverController *popover;
@property(nonatomic,strong)UIButton *selectedBtn;//前一个选中的按钮
@end
@implementation DSZSYFejTopView
+(id)createTop
{
    
    return [[[NSBundle mainBundle]loadNibNamed:@"DSZSYFejTopView" owner:nil options:nil] lastObject];
}

-(void)awakeFromNib
{
   NSString *str=[NSString stringWithFormat:@"%@",[DSZFYJDataTool sharedDSZFYJDataTool].city];
        
    [_citysBtn setTitle:str forState:UIControlStateNormal];

    
    
    
    //徽章
    _zygBtn=[[DSZZYGBtn alloc]initWithFrame:CGRectMake(930, -45, 0, 0)];
    [self addSubview:_zygBtn];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeCity:) name:@"givecitys" object:nil];

}

-(void)changeCity:(NSNotification *)user
{
    NSDictionary *dic=user.userInfo;
    [_citysBtn setTitle:dic[@"city"] forState:UIControlStateNormal];
}
-(void)setbtnTitle{
    DSZZYGshopDatabase  *shopbase=[[DSZZYGshopDatabase alloc]init];
    [shopbase createDatabase];
    [shopbase createTable];
    NSArray *dataarray=  [shopbase query];
    [_zygBtn buyNumber:dataarray.count];
}

#pragma mark 显示popover
- (void)showPopover1
{
    [_popover presentPopoverFromRect:self.citysBtn.bounds inView:self.citysBtn permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

//- (void)showPopover2
//{
//    [_popover presentPopoverFromRect:self.sortBtn.bounds inView:self.sortBtn permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
//}

//城市按钮
- (IBAction)clickCityBtn {
  
    DSZSYFtopCityViewController *city=[[DSZSYFtopCityViewController alloc]init];
    city.delegate=self;
    _popover = [[UIPopoverController alloc] initWithContentViewController:city];
    _popover.popoverContentSize = CGSizeMake(120, 620);
    _popover.delegate = self;
    [self showPopover1];
    

}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

////排序按钮
//- (IBAction)clickSortBtn {
//    DSZSYFtopSortViewController *sort=[[DSZSYFtopSortViewController alloc]init];
//    _popover = [[UIPopoverController alloc] initWithContentViewController:sort];
//    sort.delegate=self;
//    _popover.popoverContentSize = CGSizeMake(120, 350);
//    _popover.delegate = self;
//    [self showPopover2];
//
//}
//需要的商品排行
- (IBAction)clickWant:(UIButton *)sender {
    
    _priceBtn.selected=NO;
    
    if (_selectedBtn!=sender) {
        _selectedBtn.selected=NO;
        sender.selected=YES;
        _selectedBtn=sender;
    }
    //通知
    NSDictionary *dic=@{@"sortsIndex":@(sender.tag)};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"sortsIndex" object:nil userInfo:dic];
}
//价格
bool flag=YES;
- (IBAction)clickPrice:(UIButton *)sender {
    if (flag==NO) {
        sender.selected=NO;
        //图片改变
        [sender setImage:[UIImage imageNamed:@"price_asc_arrow.png"] forState:UIControlStateSelected];
        sender.tag=2;
              flag=YES;
    }

    if (sender.selected) {
        //图片改变
        [sender setImage:[UIImage imageNamed:@"price_des_arrow.png"] forState:UIControlStateSelected];
        sender.tag=3;

       flag=NO;
    }
    else
    {
        sender.selected=YES;
    }
    
    //通知
    NSDictionary *dic=@{@"sortsIndex":@(sender.tag)};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"sortsIndex" object:nil userInfo:dic];
}


#pragma mark----代理
-(void)didselectedCell:(NSString *)name
{
    [self.citysBtn setTitle:name forState:UIControlStateNormal];
    //通知
    NSDictionary *dic=@{@"name":name};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"btnname" object:nil userInfo:dic];
}
//-(void)didselectedSort:(NSString *)name row:(NSInteger)index
//{
//    [self.sortBtn setTitle:name forState:UIControlStateNormal];
//    //通知
//    NSDictionary *dic=@{@"sortsIndex":@(index)};
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"sortsIndex" object:nil userInfo:dic];
//}
@end
