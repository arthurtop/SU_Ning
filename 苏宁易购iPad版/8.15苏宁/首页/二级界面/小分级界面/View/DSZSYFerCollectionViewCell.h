//
//  CollectionViewCell.h
//  7.30详情界面
//
//  Created by lovena on 15/7/30.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSZSYFejModel.h"
@interface DSZSYFerCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *icon;//图片
@property (weak, nonatomic) IBOutlet UILabel *newsPrice;//现价
@property(nonatomic,retain)DSZSYFejModel *model;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;//简介
@property (weak, nonatomic) IBOutlet UILabel *percount;

@end
