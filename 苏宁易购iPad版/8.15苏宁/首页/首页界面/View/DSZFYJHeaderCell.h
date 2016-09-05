//
//  DSZFYJHeaderCell.h
//  8.1苏宁ipad
//
//  Created by app05 on 15/8/3.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FYJCollectionCellDelegate <NSObject>

-(void)tapCollectionCellWith:(NSInteger )tag;

@end
@interface DSZFYJHeaderCell : UICollectionViewCell

@property(nonatomic,copy)NSString *img;

@property(nonatomic,assign)NSInteger index;

@property(nonatomic,weak)id<FYJCollectionCellDelegate>delegate;

@end
