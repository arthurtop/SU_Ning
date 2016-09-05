//
//  DSZZHMCollectionCell.m
//  8.1苏宁ipad
//
//  Created by app01 on 15/8/6.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZZHMCollectionCell.h"
#import "DACFavoriteModel.h"
#import "UIImageView+WebCache.h"
#import "NSString+MJ.h"



@implementation DSZZHMCollectionCell

-(void)layoutSubviews{
    [super layoutSubviews];
    
    [_image setImageWithURL:[NSURL URLWithString:_model.imageUrl]];
    
    _title.text = _model.title;
    
}

- (IBAction)delBtn:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(deleteCollect:)]) {
        [self.delegate deleteCollect:_model];
    }
}
@end
