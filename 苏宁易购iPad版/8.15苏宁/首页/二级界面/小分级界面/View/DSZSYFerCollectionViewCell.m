//
//  CollectionViewCell.m
//  7.30详情界面
//
//  Created by lovena on 15/7/30.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZSYFerCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "NSString+MJ.h"
@implementation DSZSYFerCollectionViewCell

-(void)setModel:(DSZSYFejModel *)model
{
    _model=model;
    //图片
    [self.icon setImageWithURL:[NSURL URLWithString:model.image_url]];
    [self.icon setImageWithURL:[NSURL URLWithString:model.image_url] placeholderImage:[UIImage imageNamed:@"SYF加载中"]];
    
    //现在价钱
    //现在价钱
    NSString *str =[NSString stringWithDouble:model.current_price fractionCount:2];
    self.newsPrice.text=[NSString stringWithFormat:@"¥%@",str];
    //人气
    self.percount.text=[NSString stringWithFormat:@"人气:%@",model.purchase_count];
    self.titleLabel.text=model.desc;
}

@end
