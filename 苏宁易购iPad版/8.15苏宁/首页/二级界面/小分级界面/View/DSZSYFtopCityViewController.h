//
//  DSZSYFtopCityViewController.h
//  8.2二级界面
//
//  Created by lovena on 15/8/2.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DSZSYFtopCityViewController;
@protocol DSZSYFtopCityViewControllerDelegate <NSObject>

-(void)didselectedCell:(NSString *)name;

@end
@interface DSZSYFtopCityViewController : UIViewController
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,retain)NSMutableArray *cityArray;
@property(nonatomic,weak)id<DSZSYFtopCityViewControllerDelegate>delegate;
@end
