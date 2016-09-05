//
//  DSZDACXQController.m
//  8.1苏宁ipad
//
//  Created by app33 on 15/8/2.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZDACXQController.h"
#import "DPAPI.h"
#import "UIImageView+WebCache.h"
#import "NSObject+Value.h"
#import "NSString+MJ.h"
#import "NSDate+MJ.h"
#import "UIViewExt.h"
#import "goodsDetailShowView.h"
#import "MJExtension.h"
#import "DACCommentModel.h"
#import "DACCommnetCell1.h"
#import "DACCommnetCell2.h"
#import "askHeadView.h"
#import "askCellView.h"
#import "askModel.h"
#import "bigIimageController.h"
#import "TGCover.h"
#import "DSZCityController.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"
#import "DSZZYGshopDatabase.h"
#import "DSZZHMOderModel.h"
#import "DACFavoriteModel.h"
#import "DSZMainController.h"
#import "DSZZYGBtn.h"
#import "DSZSYFSSViewController.h"
#import "DSZZHMMineViewController.h"
#import "DSZZHMLoginView.h"
#import "UMSocial.h"
#import "DSZCQPayViewController.h"
#define kFilePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"login.data"]

#define FilePath2 [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]stringByAppendingPathComponent:@"favorite.data"]


@interface DSZDACXQController ()<DPRequestDelegate>
{
    UIPopoverController *pop;
    TGCover *cover;
    DACPrepareBuyView *prepareBuyView;
    DACBuyNowView *buyView;
    DSZCityController *city;
}
@property(copy,nonatomic)NSString *tel;
//遮罩
@property(weak,nonatomic)TGCover *cover1;
//登陆视图
@property(weak,nonatomic)DSZZHMLoginView *loginView;


@end

@implementation DSZDACXQController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _baseView.selected = YES;
    _selectButton = _baseView;
    [self addWebView];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];

    
    _tel = [NSKeyedUnarchiver unarchiveObjectWithFile:kFilePath];

    
    UIImageView *leftImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"kHomeSearch_icon"]];
    leftImage.frame = CGRectMake(10, 8, 20, 20);
    self.textField.leftView = leftImage;
    self.textField.leftViewMode = UITextFieldViewModeAlways;
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(86, 8, 35, 35)];
    [button setImage:[UIImage imageNamed:@"icon_saoma"] forState:UIControlStateNormal];
    self.textField.rightView = button;
    self.textField.rightViewMode = UITextFieldViewModeAlways;
    //请求数据
    [self loadWebData];
    //刷新计时时间
    _time = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(refreshTime) userInfo:nil repeats:YES];
    //让基本信息默认被选中
   
    _bottomScrollView.height = 704;
    _bigScrollerView.contentSize = CGSizeMake(1024, 1408);
    _bigScrollerView.pagingEnabled = YES;
    _bigScrollerView.delegate = self;
    _bigScrollerView.showsVerticalScrollIndicator= NO;
    _bigScrollerView.bounces = NO;
    _CommentTable.scrollEnabled = NO;
    
    //给上面的大的背景图添加手势识别器
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushBigImage)];
    [self.bigimage addGestureRecognizer:tap];
    //裁减按钮
    self.buyNowView.layer.cornerRadius = 8;
    self.buyNowView.layer.masksToBounds = YES;
    self.prepareBuyView.layer.cornerRadius = 8;
    self.prepareBuyView.layer.masksToBounds = YES;
    
    //徽章
    _zygBtn=[[DSZZYGBtn alloc]initWithFrame:CGRectMake(950, 25, 0, 0)];
    [self.view addSubview:_zygBtn];
    DSZZYGshopDatabase *dataBase = [[DSZZYGshopDatabase alloc]init];
    [dataBase createDatabase];
    [dataBase createTable];
    NSArray *array=[dataBase query];
    [self hiddenBuyNumBtn:array.count];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notice:) name:@"loginsuccessed" object:nil];
    
}

-(void)hiddenBuyNumBtn:(NSInteger)number{
    DSZZYGshopDatabase  *shopbase=[[DSZZYGshopDatabase alloc]init];
    [shopbase createDatabase];
    [shopbase createTable];
    NSArray *dataarray=  [shopbase query];
    int countBuy=dataarray.count;
    int num=1;
    if (num==1) {
        if (number==0) {
            _zygBtn.hidden=YES;
        }else{
            _zygBtn.hidden=NO;
            [_zygBtn buyNumber:countBuy];
        }
    }else{
        _zygBtn.hidden=YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark 大众点评请求数据
-(void)loadWebData
{
    // 1.封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObject:_dealid forKey:@"deal_id"];
    //    // 1.1.添加城市参数
    DPAPI *api = [[DPAPI alloc] init];
    [api requestWithURL:@"v1/deal/get_single_deal" params:params delegate:self];
    
}
- (void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result
{
    NSArray *array = result[@"deals"];
    for (NSDictionary *dic in array) {
        _xmodel = [[XQModel alloc]init];
        [_xmodel setValues:dic];
        //子父标题
        self.titleName.text = _xmodel.title;
        self.subTitle.text = _xmodel.desc;
        double d1 = _xmodel.current_price;
        double d2 = _xmodel.list_price;
        NSString *str1 = [NSString stringWithDouble:d1 fractionCount:2];
        NSString *str2 = [NSString stringWithDouble:d2 fractionCount:2];
        //原旧价格
        self.nowPrice.text = [NSString stringWithFormat:@"¥ %@",str1];
        self.oldPrice.text = [NSString stringWithFormat:@"¥ %@",str2];
        int count = _xmodel.purchase_count;
        self.buyCount.text = [NSString stringWithFormat:@"已购买：%d件",count];
        //比较时间
        NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
        fmt.dateFormat = @"yyyy-MM-dd"; // 2013-11-17
        // 2013-11-17
        NSDate *dealline = [fmt dateFromString:_xmodel.purchase_deadline];
        // 2013-11-18 00:00:00
        dealline = [dealline dateByAddingTimeInterval:24 * 3600];
        // 2013-11-17 10:50
        NSDate *now = [NSDate date];
        NSDateComponents *cmps = [now compare:dealline];
        self.day.text = [NSString stringWithFormat:@"%ld",(long)cmps.day];
        self.hour.text = [NSString stringWithFormat:@"%ld",(long)cmps.hour];
        self.second.text = [NSString stringWithFormat:@"%ld",(long)cmps.minute];
        self.inver.text = [NSString stringWithFormat:@"%ld",(long)cmps.second];
        
        //设置图片
        [self.bigimage setImageWithURL:[NSURL URLWithString:_xmodel.image_url]];
        [self.bigimage setImageWithURL:[NSURL URLWithString:_xmodel.image_url] placeholderImage:[UIImage imageNamed:@"加载中"]];
        //设置小的滑动视图
        _smallScrollView.pagingEnabled = NO;
        _smallScrollView.decelerationRate = 0.1;
        int x = 0 ;
        for (int i = 0; i < _xmodel.more_s_image_urls.count; i++) {
            //先添加外部背景视图
            _bgImage = [[UIImageView alloc]initWithFrame:CGRectMake(x, 0, 120, _smallScrollView.height)];
            _bgImage.image = [UIImage imageNamed:@"imageBgView"];
            _bgImage.userInteractionEnabled = YES;
            [self.smallScrollView addSubview:_bgImage];
            //给每个背景图添加点击事件，
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeBgView:)];
            [_bgImage addGestureRecognizer:tap];
            UIImageView *simage = [[UIImageView alloc]init];
            simage.frame = CGRectMake(5, 5, 110, _smallScrollView.height-10);
            [simage setImageWithURL:[NSURL URLWithString:_xmodel.more_s_image_urls[i]] placeholderImage:[UIImage imageNamed:@"加载中"]];
            [_bgImage addSubview:simage];
            x = x +130;
            if(i == 0)
            {
                _bgImage.image = [UIImage imageNamed:@"imgBG_act"];
                _selectImage = _bgImage;
            }
        }
        _smallScrollView.contentSize = CGSizeMake(x, _smallScrollView.height);
        _smallScrollView.showsHorizontalScrollIndicator = NO;
        _smallScrollView.delegate = self;
        //XQModel *mode = _xmodel;
    }
    //读档，判断商品是否被收藏过
    //读档
    _muarray = [NSKeyedUnarchiver unarchiveObjectWithFile:FilePath2];
    if (_muarray==NULL) {
        _muarray = [NSMutableArray array];
    }
    //判断当前商品有没有被收藏过
    for (DACFavoriteModel *fmodel in _muarray) {
        if ([fmodel.deal_id isEqualToString:_xmodel.deal_id]) {
            _favoriteButton.selected = YES;//已经被收藏过让按钮变为被选中
        }
    }

}

#pragma mark 更换滑动视图背景图和大图
-(void)changeBgView:(UITapGestureRecognizer*)tap
{
    //改变小的背景
     _selectImage.image = [UIImage imageNamed:@"imageBgView"];
    CGPoint point = [tap locationInView:_smallScrollView];
    for (UIImageView *subimage in _smallScrollView.subviews) {
        if (CGRectContainsPoint(subimage.frame, point) ) {
            subimage.image = [UIImage imageNamed:@"imgBG_act"];
            _selectImage = subimage;
        }
    }
    //算小图是第几个，改变大图
    int index = point.x / 120;
  //改变大的图(动画)
  [UIView animateWithDuration:0.5 animations:^{
      [_bigimage setImageWithURL:[NSURL URLWithString:_xmodel.more_image_urls[index]] placeholderImage:[UIImage imageNamed:@"加载中"]];
  }];
}

#pragma mark 滑动视图代理方法
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView==_smallScrollView) {
        //定义小图偏移量
        CGPoint point = _smallScrollView.contentOffset;
        int index = floor((point.x -60)/120 +1);
        _smallScrollView.contentOffset = CGPointMake(index*120, 0);
        //改变背景
        UIImageView *bimage = _smallScrollView.subviews[index];
        _selectImage.image = [UIImage imageNamed:@"imageBgView"];
        bimage.image = [UIImage imageNamed:@"imgBG_act"];
        _selectImage = bimage;
        //改变大图
        [UIView animateWithDuration:0.5 animations:^{
            NSString *str;
            if (_xmodel.more_image_urls[index]) {
                str=_xmodel.more_image_urls[index];
            }
            else{
                str=_xmodel.image_url;
            }
            [_bigimage setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"加载中"]];
        }];

    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    BOOL flag=YES;
   if (scrollView==_bigScrollerView && scrollView.contentOffset.y >100&&flag) {
        scrollView.contentOffset = CGPointMake(0, 520);
       flag=NO;
    }//下一页
    if (flag==NO&&_bigScrollerView.contentOffset.y>100 && _web.scrollView.contentOffset.y<0) {
        _bigScrollerView.contentOffset = CGPointMake(0, -64);
       // flag=YES;

    }//网页回到上一页
    if (scrollView==_bigScrollerView&&_bottomScrollView.contentOffset.y<0) {
        _bigScrollerView.contentOffset = CGPointMake(0, 0);
    }//商品参数回到上一页
    if (scrollView==_CommentTable&&_CommentTable.contentOffset.y<0) {
        _CommentTable.scrollEnabled = YES;
        _bigScrollerView.contentOffset = CGPointMake(0, 0);
    }//评价回到上一页
    if (scrollView==_askTable&&_askTable.contentOffset.y<0) {
        _askTable.scrollEnabled = YES;
        _bigScrollerView.contentOffset = CGPointMake(0, 0);
    }//咨询回到上一页
    
}

#pragma mark 刷新倒计时
-(void)refreshTime
{
    if (([self.day.text isEqualToString:@""]) && ([self.hour.text isEqualToString:@""])&&([self.second.text isEqualToString:@""]) && ([self.inver.text isEqualToString:@""])) {
        [_time invalidate];
        _time = nil;
    }
    else
    {
        //比较时间
        NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
        fmt.dateFormat = @"yyyy-MM-dd"; // 2013-11-17
        // 2013-11-17
        NSDate *dealline = [fmt dateFromString:_xmodel.purchase_deadline];
        // 2013-11-18 00:00:00
        dealline = [dealline dateByAddingTimeInterval:24 * 3600];
        // 2013-11-17 10:50
        NSDate *now = [NSDate date];
        NSDateComponents *cmps = [now compare:dealline];
        self.day.text = [NSString stringWithFormat:@"%ld",(long)cmps.day];
        self.hour.text = [NSString stringWithFormat:@"%ld",(long)cmps.hour];
        self.second.text = [NSString stringWithFormat:@"%ld",(long)cmps.minute];
        self.inver.text = [NSString stringWithFormat:@"%ld",(long)cmps.second];
    }
    
}
- (IBAction)returnClick {
    //[self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)homeClick {
//    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    DSZMainController *main = [story instantiateViewControllerWithIdentifier:@"main"];
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}
- (IBAction)goBuyClick {
    [self showShopCart];
    
}
- (IBAction)personClick {
    DSZZHMMineViewController *mineVC = [[DSZZHMMineViewController alloc]init];
    [self.navigationController pushViewController:mineVC animated:YES];

}
#pragma mark 添加地址
- (IBAction)addressClick {
//    //添加遮罩
//    cover = [TGCover coverWithTarget:self action:@selector(remove)];
//    cover.alpha = 0.25;
//    cover.frame = CGRectMake(0, 0, 1024, self.view.height);
//    [self.view addSubview:cover];
    //添加气泡
    city = [[DSZCityController alloc]init];
    pop = [[UIPopoverController alloc]initWithContentViewController:city];
    pop.popoverContentSize = CGSizeMake(360, 200);
    [pop presentPopoverFromRect:CGRectMake(-20,-170, 360, 200) inView:self.address permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    city.add = ^(NSString *provice,NSString*city,NSString*area){
        [self.address setTitle:[NSString stringWithFormat:@"%@ %@ %@",provice,city,area] forState:UIControlStateNormal];
    };
}
#pragma  mark 移除遮罩
-(void)remove
{
    [pop dismissPopoverAnimated:YES];
}
-(void)remove2
{
    [prepareBuyView removeFromSuperview];
  [cover removeFromSuperview];
}
-(void)remove3
{
    [buyView removeFromSuperview];
    [cover removeFromSuperview];
}
#pragma mark 选择商品点击
- (IBAction)clooseClick {
    cover = [TGCover coverWithTarget:self action:@selector(remove2)];
    cover.alpha = 0.25;
    cover.frame = CGRectMake(0, 0, 1024, self.view.height);
    [self.view addSubview:cover];
    prepareBuyView = [DACPrepareBuyView createBuyView];
    [prepareBuyView setModel:_xmodel];
    prepareBuyView.delagate =self;
    prepareBuyView.frame = CGRectMake(260, 100, 519, 589);
    [self.view addSubview:prepareBuyView];
}

#pragma mark 立即购买点击
- (IBAction)buyNowClick {
    [self addView];
}
-(void)addView
{
    cover = [TGCover coverWithTarget:self action:@selector(remove3)];
    cover.alpha = 0.25;
    cover.frame = CGRectMake(0, 0, 1024, self.view.height);
    [self.view addSubview:cover];
    buyView = [DACBuyNowView createBuyNowView];
    buyView.frame =CGRectMake(1024-700, 0, 700, 768);
    buyView.delegate = self;
    [buyView setModel:_xmodel];
    [self.view addSubview:buyView];
     //XQModel *model= _xmodel;
}

#pragma mark 加入购物车按钮
- (IBAction)addToBuyClick {
    [self addBuy];
    
}

-(void)addBuy
{
    DSZZYGshopDatabase *dataBase = [[DSZZYGshopDatabase alloc]init];
    [dataBase createDatabase];
    [dataBase createTable];
    NSString *ste =@"土大力";
    double dou = _xmodel.current_price;
    NSString *str = [NSString stringWithFormat:@"%.1f",dou];
//    [ dataBase insertname:ste thingimage:_xmodel.image_url title:_xmodel.title thingprice:str];
    if (!_tel) {
        //遮罩
        TGCover *cover1 = [TGCover coverWithTarget:self action:@selector(hide:)];
        cover1.frame = CGRectMake(0, 0,self.view.bounds.size.width, self.view.bounds.size.height);
        [self.view addSubview:cover1];
        _cover1 = cover1;
        
        //登陆或注册
        DSZZHMLoginView *login = [[DSZZHMLoginView alloc]init];
        login.frame = CGRectMake(self.view.center.x-175, self.view.center.y-125,0, 0);
        [self.view addSubview:login];
        _loginView = login;
        
        CAKeyframeAnimation *scale = [CAKeyframeAnimation animation];
        scale.keyPath = @"transform.scale";
        scale.values = @[@(0.0),@(1.0)];
        scale.duration = 0.6;
        scale.removedOnCompletion = NO;
        scale.fillMode = kCAFillModeForwards;
        
        [_loginView.layer addAnimation:scale forKey:nil];


    }else{
        [ dataBase insertid:_xmodel.deal_id name:@"土大力" thingimage:_xmodel.image_url title:_xmodel.title thingprice:str];
        [self hiddenBuyNumBtn:[dataBase query].count];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"buynumber2" object:nil];
        [MBProgressHUD showSuccess:@"加入购物车成功" toView:self.view];
    }
    

    
}


//保留通知传递的参数
-(void)notice:(NSNotification *)notification{
    
    _tel = notification.object;
    
    [NSKeyedArchiver archiveRootObject:_tel toFile:kFilePath];
    
    //接收通知改变购物车徽章数
    [[NSNotificationCenter defaultCenter]postNotificationName:@"loginsuccess2" object:nil];
    [self hiddenBuyNumBtn:1];
    
    [self hide:nil];
    
    
    
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
    [_cover1 removeFromSuperview];
    _cover1 = nil;
    
}


#pragma  mark 基本信息点击
- (IBAction)baseClick {
    CGRect frame = self.yelloView.frame;
    frame.origin.x = 48;
    self.yelloView.frame = frame;
    _selectButton.selected = NO;
    _baseView.selected = YES;
    _selectButton = _baseView;
    [self addWebView];
    _bigScrollerView.contentOffset = CGPointMake(0, 520);
}

#pragma mark 创建网页视图
-(void)addWebView
{
    //创建网页视图
    _web = [[UIWebView alloc]initWithFrame:CGRectMake(0, 47, 1024, self.bottomScrollView.height-40)];
    // 1.加载请求
    NSString *ID = [_dealid substringFromIndex:[_dealid rangeOfString:@"-"].location + 1];
    NSString *url = [NSString stringWithFormat:@"http://m.dianping.com/tuan/deal/moreinfo/%@", ID];
    [_bottomScrollView addSubview:_web];
    [_web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    _web.delegate = self;

}
#pragma mark 删除网页不需要的内容
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //图文详情页面的实现代码#############
    ///0.创建可变字符串
    NSMutableString *script = [NSMutableString string];
    
    ///1.获取指定节点的引用
    //获取 header 标签的引用（对象）
    [script appendString:@"var header= document.getElementsByTagName('header')[0];"];
    
    //获取 class=“cost-box” 所在div的引用（对象）
    [script appendString:@"var costBox= document.getElementsByClassName('cost-box')[0];"];
    
    //获取 底部购买按钮 所在 a 标签的引用（对象）
    [script appendString:@"var aa= document.getElementsByTagName('a')[2];"];
    
    //获取 footer 标签的引用（对象）
    [script appendString:@"var footer= document.getElementsByTagName('footer')[0];"];
    
    
    ///2.删除指定引用
    //删除 头部 返回 条
    [script appendString:@"document.getElementsByTagName('body')[0].removeChild(header);"];
    
    //删除 头部 购买 条
    [script appendString:@"document.getElementsByTagName('body')[0].removeChild(costBox);"];
    
    //删除 底部 购买 条
    [script appendString:@"document.getElementsByTagName('body')[0].removeChild(aa);"];
    
    //删除 底部 链接
    [script appendString:@"document.getElementsByTagName('body')[0].removeChild(footer);"];
    // 2.执行脚本
    [webView stringByEvaluatingJavaScriptFromString:script];
}

#pragma mark 商品参数点击
- (IBAction)goodsDetailShowClick {
    CGRect frame = self.yelloView.frame;
    frame.origin.x = 298;
    self.yelloView.frame = frame;
    _selectButton.selected = NO;
    _goodsDetailShowView.selected = YES;
    _selectButton = _goodsDetailShowView;
     _bigScrollerView.contentOffset = CGPointMake(0, 520);
    goodsDetailShowView *goodView = [goodsDetailShowView createGoodsDetailView];
    [goodView setModel:_xmodel];
    goodView.frame = CGRectMake(0, 47, 1024, self.bottomScrollView.height-40);
    [_bottomScrollView addSubview:goodView];
    _bottomScrollView.contentSize = CGSizeMake(_bottomScrollView.width,1850);
}

#pragma mark 评价点击
- (IBAction)goodsComentClick {
    CGRect frame = self.yelloView.frame;
    frame.origin.x = 586;
    self.yelloView.frame = frame;
    _selectButton.selected = NO;
    _goodsComentView.selected = YES;
    _selectButton = _goodsComentView;
    _bigScrollerView.contentOffset = CGPointMake(0, 520);
    
    DACCommnetCell1 *cell1 = [DACCommnetCell1 createCell1];
    cell1.frame = CGRectMake(0, 47, 1024, 110);
    [self.bottomScrollView addSubview:cell1];
    
     _CommentTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 157, 1024, self.bottomScrollView.height-49-110)];
    _CommentTable.delegate = self;
    _CommentTable.dataSource = self;
    _CommentTable.rowHeight = 127;
    [self.bottomScrollView addSubview:_CommentTable];
    _bottomScrollView.contentSize = CGSizeMake(1024, 704);
}
#pragma mark 咨询点击
- (IBAction)askClick {
    CGRect frame = self.yelloView.frame;
    frame.origin.x = 839;
    self.yelloView.frame = frame;
    _selectButton.selected = NO;
    _askView.selected = YES;
    _selectButton = _askView;
    _bigScrollerView.contentOffset = CGPointMake(0, 520);
    
    askHeadView *headView = [askHeadView createAskHeadView];
    headView.frame = CGRectMake(0, 47, 1024, 74);
    [self.bottomScrollView addSubview:headView];
    _askTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 121, 1024, self.bottomScrollView.height-49-74)];
    _askTable.delegate = self;
    _askTable.dataSource = self;
    _askTable.rowHeight = 188;
    [self.bottomScrollView addSubview:_askTable];
    _bottomScrollView.contentSize = CGSizeMake(1024, 704);

}

#pragma mark 请求plist数据
-(NSArray*)total
{
    _total = [NSArray array];
    _total = [DACCommentModel modelArrayWithFilename:@"DACComment.plist"];
    return _total;
}

-(NSArray*)total2
{
    _total2 = [NSArray array];
    _total2 = [askModel modelArrayWithFilename:@"askData.plist"];
    return _total2;
}
#pragma mark 表的代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    NSInteger coua =  0;
    if (tableView == _CommentTable) {
       coua =  self.total.count;
    }
    if (tableView == _askTable) {
        coua = self.total2.count;
    }
    return coua;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *name = @"cell";
    UITableViewCell *cell2;
    if (tableView == _CommentTable) {
        DACCommnetCell2 *cell = [tableView dequeueReusableCellWithIdentifier:name];
        if (cell == nil) {
            cell = [DACCommnetCell2 createCell2];
        }
        DACCommentModel *model = self.total[indexPath.row];
        [cell setModel:model];
        cell2 = cell;
    }
    if (tableView == _askTable) {
        askCellView *cell = [tableView dequeueReusableCellWithIdentifier:name];
        if (cell == nil) {
            cell = [askCellView createAskCell];
        }
        askModel *model = self.total2[indexPath.row];
        [cell setModel:model];
        cell2 = cell;
    }
        return cell2;
}

#pragma mark 拾取器代理方法
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

#pragma mark 进入大图滑动视图
-(void)pushBigImage
{
    bigIimageController *con = [[bigIimageController alloc]init];
    con.model = self.xmodel;
    [self presentViewController:con animated:NO completion:nil];
}

//代理
-(void)prepareBuyDelagate
{
    [prepareBuyView removeFromSuperview];
    [cover removeFromSuperview];
    [self addBuy];
}

-(void)buyNowClickDelegate
{
    [self remove2];
    [self addView];
}

#pragma mark 收藏点击
- (IBAction)favoriteClick {;
    //读档
    
    
    _muarray = [NSKeyedUnarchiver unarchiveObjectWithFile:FilePath2];
    if (_muarray==NULL) {
        _muarray = [NSMutableArray array];
    }
    //根据按钮是否被选中决定是收藏还是取消
    if (_favoriteButton.selected == YES) {
        //取消收藏
        for(DACFavoriteModel *fmodel in _muarray)
        {
//            NSLog(@"%@",fmodel.deal_id);
//            NSLog(@"%@",_xmodel.deal_id);
         if ([fmodel.deal_id isEqualToString:_xmodel.deal_id]) {
            [_muarray removeObject:fmodel];//删除模型
             //重新归档
             [NSKeyedArchiver archiveRootObject:_muarray toFile:FilePath2];
             //把按钮变为普通状态
             _favoriteButton.selected = NO;
             [MBProgressHUD showSuccess:@"取消收藏成功" toView:self.view];
            }
        }
        return;
    }
   if(_favoriteButton.selected == NO)
    {
        //收藏，归档
        //创建要归档的模型
        DACFavoriteModel *model = [[DACFavoriteModel alloc]init];
        model.title = _xmodel.title;
        model.imageUrl = _xmodel.image_url;
        model.deal_id = _xmodel.deal_id;
        //添加新数据
        [_muarray addObject:model];
        //归档
        [NSKeyedArchiver archiveRootObject:_muarray toFile:FilePath2];
        //把按钮状态变为被选中状态
       _favoriteButton.selected = YES;
        [MBProgressHUD showSuccess:@"收藏成功" toView:self.view];
    }
}
- (IBAction)searchClick {
    //模态
    UIStoryboard *story=[UIStoryboard storyboardWithName:@"DSZSYFSSViewController" bundle:nil];
    DSZSYFSSViewController *vc=[story instantiateViewControllerWithIdentifier:@"sousuo"];
    [self.navigationController pushViewController:vc animated:NO];

}

//分享点击
- (IBAction)shareClick {
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"55cdc13267e58e5dce0020b7"
                                      shareText:@"友盟社会化分享让您快速实现分享等社会化功能，www.umeng.com/social"
                                     shareImage:[UIImage imageNamed:@"psb-2.jpeg"]
                                shareToSnsNames:@[UMShareToSina,UMShareToQzone,UMShareToDouban,UMShareToRenren,UMShareToTencent]
                                       delegate:self];
    
}


-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


@end
