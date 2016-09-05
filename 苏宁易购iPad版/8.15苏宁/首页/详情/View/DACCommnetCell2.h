//
//  DACCommnetCell2.h
//  8.2二级界面
//
//  Created by app33 on 15/8/4.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DACCommentModel.h"
@interface DACCommnetCell2 : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nickname;//用户名

@property (weak, nonatomic) IBOutlet UILabel *name;//店名

@property (weak, nonatomic) IBOutlet UILabel *time;//时间

@property (weak, nonatomic) IBOutlet UILabel *content;//评论

@property (weak, nonatomic) IBOutlet UIView *yellowView;//黄色视图

@property(nonatomic,strong)DACCommentModel *model;

+(id)createCell2;


@end
