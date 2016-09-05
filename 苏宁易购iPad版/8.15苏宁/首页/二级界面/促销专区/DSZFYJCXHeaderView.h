//
//  DSZFYJCXHeaderView.h
//  8.1苏宁ipad
//
//  Created by app05 on 15/8/4.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FYJCXHeaderDelegate <NSObject>

-(void)clickFYJCXHeaderBtnWiteSender:(UIButton *)sender;

@end

@interface DSZFYJCXHeaderView : UICollectionReusableView


@property(nonatomic,weak)id<FYJCXHeaderDelegate>delegate;

+(id)FYJCXHeaderView;

- (IBAction)fyjheaderBtn:(id)sender;

@end
