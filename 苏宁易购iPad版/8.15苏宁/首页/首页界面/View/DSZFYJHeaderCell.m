//
//  DSZFYJHeaderCell.m
//  8.1苏宁ipad
//
//  Created by app05 on 15/8/3.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZFYJHeaderCell.h"

@interface DSZFYJHeaderCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headerImg;

@end
@implementation DSZFYJHeaderCell

- (void)awakeFromNib {
    
}
-(void)setImg:(NSString *)img
{
    _img=img;
    
    self.headerImg.image=[UIImage imageNamed:img];
    
    self.headerImg.userInteractionEnabled=YES;
    self.userInteractionEnabled=YES;
}
-(void)setIndex:(NSInteger)index
{
    _index=index;
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click:)];
    
    self.tag=index;
    
    [self addGestureRecognizer:tap];
    
    
}
-(void)click:(UITapGestureRecognizer *)tap
{
    if ([self.delegate respondsToSelector:@selector(tapCollectionCellWith:)]) {
        [self.delegate tapCollectionCellWith:self.tag];
    }
}
@end
