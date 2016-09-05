//
//  DSZZHMCollectionViewController.m
//  8.1苏宁ipad
//
//  Created by app01 on 15/8/4.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZZHMCollectionViewController.h"
#import "DSZZHMNoHistoryView.h"
#import "Common.h"
#import "DSZZHMCollectionCell.h"
#import "DACFavoriteModel.h"
#import "DSZDACXQController.h"

#define kFilePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"login.data"]
#define FilePath2 [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]stringByAppendingPathComponent:@"favorite.data"]


@interface DSZZHMCollectionViewController ()<delFavoriteDelegate>

@property(strong,nonatomic)DSZZHMNoHistoryView *nohistory;

@property(copy,nonatomic)NSString *tel;


@end



@implementation DSZZHMCollectionViewController

static NSString * const reuseCellID = @"collectionCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumInteritemSpacing = 10;
    layout.minimumLineSpacing = 10;
    layout.itemSize = CGSizeMake(240, 302);
    layout.sectionInset = UIEdgeInsetsMake(50, 40, 20, 40);
    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, 874, 720) collectionViewLayout:layout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.showsVerticalScrollIndicator=NO;
    collectionView.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1];
    [self.view addSubview:collectionView];
    _collectionView = collectionView;

    
    [self.collectionView registerNib:[UINib nibWithNibName:@"DSZZHMCollectionCell" bundle:nil] forCellWithReuseIdentifier:reuseCellID];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notice:) name:@"loginsuccessed" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(exit) name:@"exit" object:nil];
    
    _tel = [NSKeyedUnarchiver unarchiveObjectWithFile:kFilePath];
    if (_tel != nil) {
        
        _collectionArray = [NSMutableArray array];
        _collectionArray = [NSKeyedUnarchiver unarchiveObjectWithFile:FilePath2];
    }

    
    
}



-(void)exit{
    _collectionArray = nil;
    [self.collectionView reloadData];
}

//保留通知传递的参数
-(void)notice:(NSNotification *)notification{
    
    
    if (!_collectionArray) {
        _collectionArray = [NSMutableArray array];
        _collectionArray = [NSKeyedUnarchiver unarchiveObjectWithFile:FilePath2];
    }
    [self.collectionView reloadData];
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    if (_collectionArray.count == 0) {
        if (_nohistory == nil) {
            
            _nohistory = [[DSZZHMNoHistoryView alloc]init];
            _nohistory.center = CGPointMake(self.collectionView.center.x, self.collectionView.center.y-200);
            _nohistory.size = CGSizeMake(300, 300);
            __block DSZZHMCollectionViewController *vc = self;
            _nohistory.goBlock = ^{
                [vc.navigationController popToRootViewControllerAnimated:YES];
            };
            [self.collectionView addSubview:_nohistory];
        }else{
            _nohistory.hidden = NO;
        }
        
        
    }else{
        _nohistory.hidden = YES;
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 874, 40)];
        view.backgroundColor = [UIColor clearColor];
        UILabel *label = [[UILabel alloc]init];
        label.frame = CGRectMake(10, 8, 200, 25);
        label.text = @"我的收藏";
        label.font = [UIFont systemFontOfSize:15];
        [view addSubview:label];
        [self.collectionView addSubview:view];
        //NSLog(@"%@",collectionView.subviews);
    }

    return _collectionArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    DSZZHMCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseCellID forIndexPath:indexPath];
    //cell.backgroundColor = [UIColor redColor];
    cell.model = _collectionArray[indexPath.item];
    cell.delegate = self;

    
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
 
    DACFavoriteModel *model = _collectionArray[indexPath.item];
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"DSZDACXQController" bundle:nil];
    DSZDACXQController *con = [story instantiateViewControllerWithIdentifier:@"XQ"];
    con.dealid = model.deal_id;
    [self.navigationController pushViewController:con animated:YES];
    
}


-(void)deleteCollect:(DACFavoriteModel *)model{
    //NSLog(@"%@",model);
    for (DACFavoriteModel *m in _collectionArray) {
        if ([m.title isEqualToString:model.title]) {
            [_collectionArray removeObject:m];
            [NSKeyedArchiver archiveRootObject:_collectionArray toFile:FilePath2];
            break;
        }
    }
    
    [self.collectionView reloadData];
}


-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}



@end
