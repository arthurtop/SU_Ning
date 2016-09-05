//
//  DSZSYFtopSortViewController.h
//  8.2二级界面
//
//  Created by lovena on 15/8/2.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DSZSYFtopSortViewController;
@protocol DSZSYFtopSortViewControllerDelegate <NSObject>

-(void)didselectedSort:(NSString *)name row:(NSInteger)index;

@end
@interface DSZSYFtopSortViewController : UIViewController
@property(nonatomic,strong)UITableView *tableView;//表
@property(nonatomic,retain)NSArray *sortArray;//数组
@property(nonatomic,weak)id<DSZSYFtopSortViewControllerDelegate>delegate;
@end
