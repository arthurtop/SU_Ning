//
//  DSZFYJHeaderCollectionView.m
//  8.1苏宁ipad
//
//  Created by app05 on 15/8/3.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZFYJHeaderCollectionView.h"
#import "DSZFYJHeaderCell.h"

@interface DSZFYJHeaderCollectionView ()<UICollectionViewDataSource, UICollectionViewDelegate,FYJCollectionCellDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIView *orangeView;
@property(nonatomic,retain)NSArray *imgArray;

@property (nonatomic, strong) NSTimer *timer;
@end
@implementation DSZFYJHeaderCollectionView

+(id)headerCollection
{
    return [[NSBundle mainBundle] loadNibNamed:@"DSZFYJHeaderCollectionView" owner:nil options:nil][0];
}
-(void)awakeFromNib
{
    self.imgArray=[NSArray array];
    
    self.collectionView.delegate=self;
    self.collectionView.dataSource=self;
    // 注册cell
    [self.collectionView registerNib:[UINib nibWithNibName:@"DSZFYJHeaderCell" bundle:nil] forCellWithReuseIdentifier:@"headerCell"];
    
    [self addTimer];
    
    NSMutableArray *muArr=[NSMutableArray array];
    for (int i=0; i<8; i++) {
        
        NSString *str=[NSString stringWithFormat:@"fyjheader%d.jpg",i+1];
        [muArr addObject:str];
        
        
    }
    self.imgArray=muArr;
    
}
#pragma mark--NSTIMER
- (void)addTimer
{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.timer = timer;
}
#pragma MARK--移除定时器
- (void)removeTimer
{
    // 停止定时器
    [self.timer invalidate];
    self.timer = nil;
}

- (NSIndexPath *)resetIndexPath
{
    // 当前正在展示的位置
    NSIndexPath *currentIndexPath = [[self.collectionView indexPathsForVisibleItems] lastObject];
    // 马上显示回最中间那组的数据
    // NSIndexPath *currentIndexPathReset = [NSIndexPath indexPathForItem:currentIndexPath.item inSection:HMMaxSections/2];
    NSIndexPath *currentIndexPathReset = [NSIndexPath indexPathForItem:currentIndexPath.item inSection:0];
    [self.collectionView scrollToItemAtIndexPath:currentIndexPathReset atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    return currentIndexPathReset;
}

/**
 *  下一页
 */
- (void)nextPage
{
    // 1.马上显示回最中间那组的数据
    NSIndexPath *currentIndexPathReset = [self resetIndexPath];
    
    // 2.计算出下一个需要展示的位置
    NSInteger nextItem = currentIndexPathReset.item + 1;
    NSInteger nextSection = currentIndexPathReset.section;
    if (nextItem == self.imgArray.count) {
        nextItem = 0;
        nextSection++;
    }
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:nextItem inSection:nextSection];
    
    // 3.通过动画滚动到下一个位置
    [self.collectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}


#pragma mark  - UICollectionViewDelegate
/**
 *  当用户即将开始拖拽的时候就调用
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self removeTimer];
}

/**
 *  当用户停止拖拽的时候就调用
 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    //[self resetIndexPath];
    [self addTimer];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int page = (int)(scrollView.contentOffset.x / scrollView.bounds.size.width + 0.5) % self.imgArray.count;
    self.orangeView.frame=CGRectMake(343+page*25, 304, 18, 6);
}



#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 8;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DSZFYJHeaderCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"headerCell" forIndexPath:indexPath];
    
    cell.delegate=self;
    
    cell.tag=indexPath.row;
    
    cell.index=indexPath.row;
    
    cell.img=self.imgArray[indexPath.row];
    
    return cell;
}
-(void)tapCollectionCellWith:(NSInteger)tag
{
    if ([self.delegate respondsToSelector:@selector(clickCollectionViewWithTag:)]) {
        [self.delegate clickCollectionViewWithTag:tag];
    }
    
}



@end
