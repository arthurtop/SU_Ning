//
//  DSZFYJMapSubViewController.h
//  8.1苏宁ipad
//
//  Created by app05 on 15/8/6.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DSZFYJDealPosAnnotation,DSZFYJTotalModel,DSZFYJBusiness;

@protocol FYJMapSubDelegate <NSObject>

-(void)clickFYJMapSubBtnWithSender:(UIButton *)sender;

@end
@interface DSZFYJMapSubViewController : UIViewController

@property(nonatomic,assign) BOOL isEnd;

@property(nonatomic,weak)id<FYJMapSubDelegate>delegate;

@property(nonatomic,strong)DSZFYJDealPosAnnotation *anno;

@property(nonatomic,strong)DSZFYJTotalModel *dealModel;

@property(nonatomic,retain)NSArray *business;

@property(nonatomic,retain)DSZFYJBusiness *bus;

@end
