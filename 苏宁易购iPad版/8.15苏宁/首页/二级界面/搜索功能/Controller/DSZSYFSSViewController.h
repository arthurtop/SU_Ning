//
//  DSZSYFSSViewController.h
//  8.1苏宁ipad
//
//  Created by lovena on 15/8/3.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSZZYGBaseViewController.h"
@class DSZZYGBtn;
@interface DSZSYFSSViewController : DSZZYGBaseViewController<UISearchBarDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *btnRS;//热搜按钮
- (IBAction)reBtn;//刷新

- (IBAction)returnMain;//返回
- (IBAction)clickTitBtn:(UIButton *)sender;//点击热搜
- (IBAction)gotoMy;//我的
- (IBAction)gotoGWC;//购物车
- (IBAction)returnHome;//返回首页
- (IBAction)deleBtn;//删除记录按钮
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;//九宫格视图
@property(nonatomic,retain)NSMutableArray *titArray;//记录数组
@property (weak, nonatomic) IBOutlet UIView *topView;//顶部view
@property (weak, nonatomic) IBOutlet UISearchBar *search;//搜索
@property(nonatomic,retain)DSZZYGBtn *zygBtn;
@property(nonatomic,retain)NSMutableArray *rsArray;
@end
