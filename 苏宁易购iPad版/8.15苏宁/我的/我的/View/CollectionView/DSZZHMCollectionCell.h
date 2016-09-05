//
//  DSZZHMCollectionCell.h
//  8.1苏宁ipad
//
//  Created by app01 on 15/8/6.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DACFavoriteModel;


@protocol delFavoriteDelegate <NSObject>

-(void)deleteCollect:(DACFavoriteModel *)model;

@end



@interface DSZZHMCollectionCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *image;

@property (weak, nonatomic) IBOutlet UILabel *title;

@property(retain,nonatomic)DACFavoriteModel *model;
@property(weak,nonatomic)id <delFavoriteDelegate> delegate;

- (IBAction)delBtn:(UIButton *)sender;



@end
