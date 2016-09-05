//
//  MyCell.h
//  7.30界面
//
//  Created by lovena on 15/7/31.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSZSYFirstModel.h"
@class DSZSYMyCell;
@protocol DSZSYMyCellDelegate <NSObject>

-(void)didselectedBtnCell:(NSString *)str;

@end
@interface DSZSYMyCell : UITableViewCell
@property(nonatomic,retain)DSZSYFirstModel *firmodel;
@property(nonatomic,assign)CGFloat cellHeight;
@property(nonatomic,weak)id<DSZSYMyCellDelegate>delegate;
+(id)createCell;
@end
