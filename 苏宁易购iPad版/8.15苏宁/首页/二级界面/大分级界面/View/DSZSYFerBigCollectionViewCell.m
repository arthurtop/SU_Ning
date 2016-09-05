//
//  CollectionViewCell.m
//  7.30详情界面
//
//  Created by lovena on 15/7/30.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZSYFerBigCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "NSString+MJ.h"
@implementation DSZSYFerBigCollectionViewCell

-(void)setModel:(DSZSYFejModel *)model
{
    _model=model;
    //图片
    [self.icon setImageWithURL:[NSURL URLWithString:model.image_url] placeholderImage:[UIImage imageNamed:@"SYF加载中"]];
    
    //名字
    self.name.text=model.title;
    //现在价钱
    NSString *str =[NSString stringWithDouble:model.current_price fractionCount:2];
    self.newsPrice.text=[NSString stringWithFormat:@"¥%@",str];
//    //以前价格
    self.oldPrice.text=[NSString stringWithDouble:model.list_price fractionCount:2];
    //人数
    self.percount.text=[NSString stringWithFormat:@"人气:%@",model.purchase_count];
    self.titleLabel.text=model.desc;
}

@end
