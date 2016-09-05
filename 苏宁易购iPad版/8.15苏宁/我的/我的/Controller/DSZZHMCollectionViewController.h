//
//  DSZZHMCollectionViewController.h
//  8.1苏宁ipad
//
//  Created by app01 on 15/8/4.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

//收藏
#import <UIKit/UIKit.h>


@interface DSZZHMCollectionViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate>


@property(retain,nonatomic)NSMutableArray *collectionArray;


//九宫格视图
@property(weak,nonatomic)UICollectionView *collectionView;

@end
