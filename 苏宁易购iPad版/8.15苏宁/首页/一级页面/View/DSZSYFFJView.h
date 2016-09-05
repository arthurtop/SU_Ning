//
//  DSZSYFFJView.h
//  8.1苏宁ipad
//
//  Created by lovena on 15/8/1.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DSZSYFFJView;
@protocol DSZSYFFJViewDelegate <NSObject>

-(void)sectionDidselectedNsttring:(NSString *)str;

@end
@interface DSZSYFFJView : UIView<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,weak)id<DSZSYFFJViewDelegate>delegate;
@end
