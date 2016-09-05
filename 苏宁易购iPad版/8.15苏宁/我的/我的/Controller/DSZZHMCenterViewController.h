//
//  DSZZHMCenterViewController.h
//  8.1苏宁ipad
//
//  Created by app01 on 15/8/2.
//  Copyright (c) 2015年 lovena. All rights reserved.
//


//个人中心

#import <UIKit/UIKit.h>
#import "DSZZHMLoginView.h"


@class TGCover,DSZZHMCenterHead;
@interface DSZZHMCenterViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,ForgetPasswdDelegate>

//九宫格视图
@property(weak,nonatomic)UICollectionView *collectionView;
//九宫格头视图
@property(weak,nonatomic)DSZZHMCenterHead *centerHeaderView;
//遮罩
@property(weak,nonatomic)TGCover *cover;
//登陆视图
@property(weak,nonatomic)DSZZHMLoginView *loginView;


//历史记录数组
@property(retain,nonatomic)NSArray *historyArray;

@end
