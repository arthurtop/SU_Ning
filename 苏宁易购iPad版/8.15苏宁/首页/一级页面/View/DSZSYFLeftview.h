//
//  DSZSYFLeftview.h
//  8.1苏宁ipad
//
//  Created by lovena on 15/8/1.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DSZSYFLeftview;
@protocol DSZSYFLeftviewDelegate <NSObject>

-(void)didselectedCell;

@end
@interface DSZSYFLeftview : UIView<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,weak)IBOutlet UITableView *tableView;
@property(nonatomic,retain)NSArray *titleArray;//选项标题
@property(nonatomic,weak)id<DSZSYFLeftviewDelegate>delegate;
@property(nonatomic,assign)NSInteger cellIndex;//上次选中某个单元格

@property(nonatomic,weak)UITableViewCell *cell;//纪录被选中的单元格
-(void)didntSelected;//取消单元格的选中

@end
