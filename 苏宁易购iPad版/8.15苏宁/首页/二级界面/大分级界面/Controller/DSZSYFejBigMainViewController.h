//
//  ViewController.h
//  8.2二级界面
//
//  Created by lovena on 15/8/2.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSZZYGBaseViewController.h"
@interface DSZSYFejBigMainViewController : DSZZYGBaseViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property(nonatomic,retain)NSMutableArray *EJarray;
@property(nonatomic,strong)UICollectionView *collectionView;

@end

