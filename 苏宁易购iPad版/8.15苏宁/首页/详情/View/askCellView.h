//
//  askCellView.h
//  8.2二级界面
//
//  Created by app33 on 15/8/4.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "askModel.h"
@interface askCellView : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *userName;//用户名

@property (weak, nonatomic) IBOutlet UILabel *time;//时间

@property (weak, nonatomic) IBOutlet UILabel *userQuestion;//用户问题

@property (weak, nonatomic) IBOutlet UILabel *answer;//答案

@property (weak, nonatomic) IBOutlet UIButton *goodButton;//满意按钮

@property (weak, nonatomic) IBOutlet UIButton *notGoodButton;//不满意按钮

@property (weak, nonatomic) IBOutlet UILabel *goodLabel;//满意标签

@property (weak, nonatomic) IBOutlet UILabel *notGoodLabel;//不满意标签

- (IBAction)goodClick;//满意点击

- (IBAction)notGoodClick;//不满意点击

+(id)createAskCell;

@property(nonatomic,strong)askModel *model;

@end
