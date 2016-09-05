//
//  bigIimageController.m
//  8.2二级界面
//
//  Created by app33 on 15/8/4.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "bigIimageController.h"
#import "UIViewExt.h"
#import "UIImageView+WebCache.h"
@interface bigIimageController ()<UIScrollViewDelegate>

@end

@implementation bigIimageController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.bigScrollView.delegate = self;
    self.bigScrollView.pagingEnabled = YES;
    self.bigScrollView.showsHorizontalScrollIndicator = NO;
    self.smallScrollView.delegate = self;
    self.smallScrollView.showsHorizontalScrollIndicator = NO;
    [self addImages];
    self.titleLabel.text = _model.title;
}

#pragma  mark 添加图片
-(void)addImages
{
    if (_model.more_image_urls.count!=0) {
        int x1 = 0;
        int x2 = 0;
        //给大图添加图片
        for (int i = 0; i < _model.more_image_urls.count; i++) {
            UIImageView *image = [[UIImageView alloc]init];
            image.frame = CGRectMake(x1, 0, self.bigScrollView.width, self.bigScrollView.height);
            [image setImageWithURL:[NSURL URLWithString:_model.more_image_urls[i]] placeholderImage:[UIImage imageNamed:@"加载中"]];
            [self.bigScrollView addSubview:image];
            x1 = x1 +self.bigScrollView.width;
        }
        self.bigScrollView.contentSize = CGSizeMake(x1, self.bigScrollView.height);
        
        //给小图添加图片
        for (int i = 0; i< _model.more_s_image_urls.count; i++) {
            _bgImage = [[UIImageView alloc]initWithFrame:CGRectMake(x2, 0, 140, _smallScrollView.height)];
            _bgImage.image = [UIImage imageNamed:@"imageBgView"];
            _bgImage.userInteractionEnabled = YES;
            [self.smallScrollView addSubview:_bgImage];
            //给每个背景图添加点击事件，
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeBgView:)];
            [_bgImage addGestureRecognizer:tap];
            UIImageView *simage = [[UIImageView alloc]init];
            simage.frame = CGRectMake(10, 10, 120, _smallScrollView.height-20);
            [simage setImageWithURL:[NSURL URLWithString:_model.more_s_image_urls[i]] placeholderImage:[UIImage imageNamed:@"加载中"]];
            [_bgImage addSubview:simage];
            x2 = x2 +180;
            if(i == 0)
            {
                _bgImage.image = [UIImage imageNamed:@"imgBG_act"];
                _selectImage = _bgImage;
            }
        }
        self.smallScrollView.contentSize = CGSizeMake(x2, _smallScrollView.height);
    }
    else
    {
        UIImageView *bigImage = [[UIImageView alloc]init];
        bigImage.frame = _bigScrollView.bounds;
        [bigImage setImageWithURL:[NSURL URLWithString:_model.image_url] placeholderImage:[UIImage imageNamed:@"加载中"]];
        [self.bigScrollView addSubview:bigImage];
        
        _bgImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 140, _smallScrollView.height)];
        _bgImage.image = [UIImage imageNamed:@"imageBgView"];
        _bgImage.userInteractionEnabled = YES;
        [self.smallScrollView addSubview:_bgImage];
        
        UIImageView *simage = [[UIImageView alloc]init];
        simage.frame = CGRectMake(10, 10, 120, _smallScrollView.height-20);
        [simage setImageWithURL:[NSURL URLWithString:_model.image_url] placeholderImage:[UIImage imageNamed:@"加载中"]];
        [_bgImage addSubview:simage];
        _bgImage.image = [UIImage imageNamed:@"imgBG_act"];
        _selectImage = _bgImage;
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
    int index = point.x / 180;
    //改变大的图
    _bigScrollView.contentOffset = CGPointMake(index*self.bigScrollView.width, 0);
}
- (IBAction)closeClick {
    [self dismissViewControllerAnimated:NO completion:nil];
}
@end
