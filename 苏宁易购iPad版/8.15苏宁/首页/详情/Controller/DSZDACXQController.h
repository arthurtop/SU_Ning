//
//  DSZDACXQController.h
//  8.1苏宁ipad
//
//  Created by app33 on 15/8/2.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSZSYFejModel.h"
#import "XQModel.h"
#import "DACPrepareBuyView.h"
#import "DACBuyNowView.h"
#import "DSZZYGBaseViewController.h"
@class DSZZYGBtn;

@interface DSZDACXQController : DSZZYGBaseViewController<UIScrollViewDelegate,UIWebViewDelegate,UITableViewDataSource,UITableViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate,DACPrepareBuyViewDelagate,DACBuyNowViewDelegate>

@property(nonatomic,copy)NSString *id;//ID号（没什么作用）

@property(nonatomic,copy)NSString *dealid;//需要的ID号

@property(nonatomic,strong)NSArray *total;//

@property(nonatomic,strong)NSArray *total2;

@property(nonatomic,strong)DSZSYFejModel *smodel;

@property(nonatomic,strong)XQModel *xmodel;//详情model

@property(nonatomic,strong)NSTimer *time;//计时器

@property(nonatomic,strong)UIImageView *bgImage;

@property(nonatomic,strong)UIImageView *selectImage;//记录选中的背景图

@property(nonatomic,strong)UIButton *selectButton;

@property(nonatomic,strong)UITableView *CommentTable;//评论表

@property(nonatomic,strong)UITableView *askTable;//咨询表

@property(nonatomic,strong)UIWebView *web;

@property(nonatomic,strong) NSMutableArray *muarray;

@property (weak, nonatomic) IBOutlet UITextField *textField;//文本框属性

@property (weak, nonatomic) IBOutlet UIImageView *bigimage;//大图属性

@property (weak, nonatomic) IBOutlet UIScrollView *bigScrollerView;//大的滑动视图

@property (weak, nonatomic) IBOutlet UIView *buttonTotalView;//四个按钮所在视图

@property (weak, nonatomic) IBOutlet UIScrollView *smallScrollView;//小的滑动视图的属性

@property (weak, nonatomic) IBOutlet UIScrollView *bottomScrollView;//底部滑动视图

@property (weak, nonatomic) IBOutlet UILabel *titleName;//主标题属性

@property (weak, nonatomic) IBOutlet UILabel *subTitle;//子标题属性

@property (weak, nonatomic) IBOutlet UILabel *nowPrice;//现在价钱

@property (weak, nonatomic) IBOutlet UILabel *oldPrice;//原先价钱

@property (weak, nonatomic) IBOutlet UILabel *buyCount;//购买数量

@property (weak, nonatomic) IBOutlet UIButton *address;//地区

@property (weak, nonatomic) IBOutlet UIButton *buyDetail;//购买详细信息

@property (weak, nonatomic) IBOutlet UILabel *day;//天数

@property (weak, nonatomic) IBOutlet UILabel *hour;//小时

@property (weak, nonatomic) IBOutlet UILabel *second;//分钟

@property (weak, nonatomic) IBOutlet UILabel *inver;//秒

@property (weak, nonatomic) IBOutlet UIView *yelloView;//黄线属性

@property (weak, nonatomic) IBOutlet UIButton *baseView;//基本信息属性

@property (weak, nonatomic) IBOutlet UIButton *goodsDetailShowView;//商品参数

@property (weak, nonatomic) IBOutlet UIButton *goodsComentView;//商品评论

@property (weak, nonatomic) IBOutlet UIButton *askView;//咨询

@property (weak, nonatomic) IBOutlet UIButton *buyNowView;//立即购买按钮

@property (weak, nonatomic) IBOutlet UIButton *prepareBuyView;//加入购物车按钮

@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;

- (IBAction)returnClick;//返回事件

- (IBAction)homeClick;//首页事件

- (IBAction)goBuyClick;//去购物车事件

- (IBAction)personClick;//个人点击事件

- (IBAction)addressClick;//地址点击事件

- (IBAction)clooseClick;//选择点击事件

- (IBAction)buyNowClick;//立即购买点击事件

- (IBAction)addToBuyClick;//加入购物车点击事件

- (IBAction)baseClick;//基本信息点击事件

- (IBAction)goodsDetailShowClick;//商品参数点击事件

- (IBAction)goodsComentClick;//商品评论点击事件

- (IBAction)askClick;//咨询点击事件

- (IBAction)favoriteClick;//收藏点击事件

- (IBAction)searchClick;

- (IBAction)shareClick;//分享点击

@property(nonatomic,retain)DSZZYGBtn *zygBtn;//徽章

@end
