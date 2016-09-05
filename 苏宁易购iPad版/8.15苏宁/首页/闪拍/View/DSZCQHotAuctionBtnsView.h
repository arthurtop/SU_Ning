//
//  DSZCQHotAuctionBtnsView.h
//  8.1苏宁ipad
//
//  Created by app20 on 15/8/2.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DSZCQHotAuctionBtnsView <NSObject>

- (void)clickHotAuctionBtnWithIndex:(NSInteger)index;

@end

@interface DSZCQHotAuctionBtnsView : UIView

@property(nonatomic,weak) UIButton *lastBtn;

@property (weak, nonatomic) id <DSZCQHotAuctionBtnsView> delegate;

@property (weak, nonatomic) IBOutlet UIButton *firstBtn;

- (IBAction)buttons:(UIButton *)sender;

+ (instancetype)createDSZCQHotAuctionBtnsView;

@end
