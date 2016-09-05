//
//  DSZZHMCenterViewController.m
//  8.1苏宁ipad
//
//  Created by app01 on 15/8/2.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZZHMHistoryHeader.h"
#import "DSZZHMCenterViewController.h"
#import "DSZZHMCenterHead.h"
#import "DSZZHMUnLoginHeader.h"
#import "Common.h"
#import "UIImage+Fit.h"
#import "DSZZHMNoHistoryView.h"
#import "TGCover.h"
#import "DSZZHMLoginView.h"
#import "DSZSYFejModel.h"
#import "DSZSYFerCollectionViewCell.h"

#import "DSZDACXQController.h"




#define kFilePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"login.data"]
#define kLiulanHistoryPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"liulanHistory.data"]



@interface DSZZHMCenterViewController ()<CenterDeleteHistory>

@property(strong,nonatomic)DSZZHMNoHistoryView *nohistory;
@property(copy,nonatomic)NSString *tel;

@end

@implementation DSZZHMCenterViewController

static NSString * const reuseCellID = @"cell";
static NSString * const reuseHeaderID= @"centerHeader";
static NSString * const reuseNnLoginHeaderID= @"unLoginHeader";



- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumInteritemSpacing = 10;
    layout.minimumLineSpacing = 10;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.itemSize = CGSizeMake(240, 302);
    layout.sectionInset = UIEdgeInsetsMake(50, 40, 20, 40);
    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, 874, 700) collectionViewLayout:layout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.showsVerticalScrollIndicator=NO;
//    collectionView.scrollEnabled = YES;
//    collectionView.contentSize = CGSizeMake(874, 2000);
//    collectionView.clipsToBounds = NO;
//    self.collectionView.alwaysBounceVertical = YES;
    collectionView.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1];
    [self.view addSubview:collectionView];
    _collectionView = collectionView;
    
//    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:_collectionView.frame];
//    [scrollView addSubview:_collectionView];
//    scrollView.scrollEnabled = YES;
//    scrollView.contentSize = CGSizeMake(800, 1024);
//    [self.view addSubview:scrollView];
//    
//    NSLog(@"%@",self.view.subviews);
//    NSLog(@"%@",scrollView.subviews);
//    
    
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"DSZSYFerCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseCellID];
    [self.collectionView registerNib:[UINib nibWithNibName:@"DSZZHMCenterHead" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseHeaderID];
    [self.collectionView registerNib:[UINib nibWithNibName:@"DSZZHMUnLoginHeader" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseNnLoginHeaderID];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(forgetPasswd) name:@"forgetPasswd" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notice:) name:@"loginsuccessed" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(exit) name:@"exit" object:nil];
    
   
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _tel = [NSKeyedUnarchiver unarchiveObjectWithFile:kFilePath];
    if (_tel != nil) {
        _historyArray = [NSMutableArray array];
        _historyArray = [NSKeyedUnarchiver unarchiveObjectWithFile:kLiulanHistoryPath];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (_historyArray.count == 0) {
        if (_nohistory == nil) {
            
            _nohistory = [[DSZZHMNoHistoryView alloc]init];
            _nohistory.frame = CGRectMake(280, 200, 300, 300);
    
            __block DSZZHMCenterViewController *vc = self;
            _nohistory.goBlock = ^{
                [vc.navigationController popToRootViewControllerAnimated:YES];
            };
            [_collectionView addSubview:_nohistory];
        }else{
            _nohistory.hidden = NO;
        }
        
        
    }else{
        _nohistory.hidden = YES;
        
        DSZZHMHistoryHeader *headerView = [[DSZZHMHistoryHeader alloc]init];
        headerView.frame = CGRectMake(0, 150, 874, 40);
        headerView.delegate = self;
        [self.collectionView addSubview:headerView];
    }
    
    return _historyArray.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    DSZSYFerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseCellID forIndexPath:indexPath];
    //cell.backgroundColor = [UIColor redColor];
    cell.model = _historyArray[indexPath.row];
    return cell;
}



-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    DSZSYFejModel *model = _historyArray[indexPath.item];
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"DSZDACXQController" bundle:nil];
    DSZDACXQController *con = [story instantiateViewControllerWithIdentifier:@"XQ"];
    con.dealid = model.deal_id;
    [self.navigationController pushViewController:con animated:YES];
    
}



//自定义段头
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake(self.view.bounds.size.width, 150);
    
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if (_tel ==nil) {
        DSZZHMUnLoginHeader *centerHeaderView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseNnLoginHeaderID forIndexPath:indexPath];
        
        __block UIViewController *vc = self;
        __block UICollectionView *view = _collectionView;
        
        centerHeaderView.loginBlock = ^{
            
            //遮罩
            TGCover *cover = [TGCover coverWithTarget:vc action:@selector(hide:)];
            cover.frame = CGRectMake(0, 0, view.bounds.size.width, view.bounds.size.height);
            [view addSubview:cover];
            _cover = cover;
            
            //登陆或注册
            DSZZHMLoginView *login = [[DSZZHMLoginView alloc]init];
            login.frame = CGRectMake(260, 200,0, 0);
            [view addSubview:login];
            _loginView = login;
            
            CAKeyframeAnimation *scale = [CAKeyframeAnimation animation];
            scale.keyPath = @"transform.scale";
            scale.values = @[@(0.0),@(1.0)];
            scale.duration = 0.6;
            scale.removedOnCompletion = NO;
            scale.fillMode = kCAFillModeForwards;
            [_loginView.layer addAnimation:scale forKey:nil];

            
        };
        _loginView.delegate = self;
        _centerHeaderView = (DSZZHMCenterHead *)centerHeaderView;

    }else{
        DSZZHMCenterHead *centerHeaderView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseHeaderID forIndexPath:indexPath];
        centerHeaderView.tel = _tel;
        _centerHeaderView = centerHeaderView;
    }
    
    return _centerHeaderView;
}


//删除历史纪录的代理方法
-(void)deleteHistoryAction{
    _historyArray = nil;
    [self.collectionView reloadData];
    [NSKeyedArchiver archiveRootObject:_historyArray toFile:kLiulanHistoryPath];
}



//保留通知传递的参数
-(void)notice:(NSNotification *)notification{
    
    _tel = notification.object;
    
    [NSKeyedArchiver archiveRootObject:_tel toFile:kFilePath];
   
    [self hide:nil];
    
    if (!_historyArray) {
        _historyArray = [NSMutableArray array];
        _historyArray = [NSKeyedUnarchiver unarchiveObjectWithFile:kLiulanHistoryPath];
    }
    [self.collectionView reloadData];
}

//隐藏登录界面
-(void)hide:(UITapGestureRecognizer *)tap  {
    

    CABasicAnimation *scale = [CABasicAnimation animation];
    scale.keyPath = @"transform.scale";
    scale.toValue = @(0.0);
    
    CABasicAnimation *move = [CABasicAnimation animation];
    move.keyPath = @"transform.translation";
    move.toValue = [NSValue valueWithCGPoint:CGPointMake(200,-100)];
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[scale,move];
    group.duration = 1.0;
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    [_loginView.layer addAnimation:group forKey:nil];
    
    _loginView = nil;
    
    [self performSelector:@selector(hideCover) withObject:nil afterDelay:1.0];
    
}
//隐藏遮罩
-(void)hideCover{
    [_cover removeFromSuperview];
    _cover = nil;
 
    [self.collectionView reloadData];
}

//退出登录
-(void)exit{
    if (_tel != nil) {
        _tel = nil;
        
        [NSKeyedArchiver archiveRootObject:_tel toFile:kFilePath];
        
    }
    _historyArray = nil;
    [self.collectionView reloadData];
    
    //通知主页退出让他改变购物车徽章数
    [[NSNotificationCenter defaultCenter]postNotificationName:@"exitend" object:nil];
    
    
    
    
   
   
}
#pragma mark UIAlertView代理方法
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        _historyArray = nil;
        [self.collectionView reloadData];
    }
    
}

#pragma mark 忘记密码代理方法
-(void)forgetPasswd{
    
    UIViewController *vc = [[UIViewController alloc]init];
    vc.view.backgroundColor = [UIColor whiteColor];
    UIWebView *web = [[UIWebView alloc]init];
    NSString *string = @"https://aq.suning.com/asc/forgetpsw.do";
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [web loadRequest:request];
    [vc.view addSubview:web];
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
