//
//  DSZCQTopBtnsView.h
//  8.1苏宁ipad
//
//  Created by app20 on 15/8/2.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DSZCQTopBtnsViewBtnClick <NSObject>

- (void)clickTopBtnWithIndex:(NSInteger)index;

@end

@interface DSZCQTopBtnsView : UIView

+(instancetype)createDSZCQTopBtnsView;

@property (weak, nonatomic) id <DSZCQTopBtnsViewBtnClick> delegate;

@property (weak, nonatomic) IBOutlet UIView *BGView;
@property (weak, nonatomic) IBOutlet UIButton *firstBtn;

- (IBAction)buttons:(UIButton *)sender;

@end
