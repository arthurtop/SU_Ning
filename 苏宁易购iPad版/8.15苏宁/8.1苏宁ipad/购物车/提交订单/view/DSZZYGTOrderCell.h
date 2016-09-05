//
//  DSZZYGTOrderCell.h
//  8.1苏宁ipad
//
//  Created by app15 on 15/8/5.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DSZZYGTOrderCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *orderimage;
@property (weak, nonatomic) IBOutlet UILabel *ordertitle;
@property (weak, nonatomic) IBOutlet UIButton *ordernum;
@property (weak, nonatomic) IBOutlet UILabel *orderprice;

//cell设置
-(void)setcell:(NSDictionary*)dic;

@end
