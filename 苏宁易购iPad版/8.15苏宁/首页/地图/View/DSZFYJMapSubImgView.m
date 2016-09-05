//
//  DSZFYJMapSubImgView.m
//  8.1苏宁ipad
//
//  Created by app05 on 15/8/6.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZFYJMapSubImgView.h"
#import "UIImageView+WebCache.h"
#define Angle2Radian(angle) ((angle) / 180.0 * M_PI)
@implementation DSZFYJMapSubImgView

+(id)FYJMapSubImg
{
    return [[NSBundle mainBundle]loadNibNamed:@"DSZFYJMapSubImgView" owner:nil options:nil][0];
}
-(void)awakeFromNib
{
    self.subViewImg.layer.cornerRadius=75;
    self.subViewImg.layer.masksToBounds=YES;
    self.subViewImg.layer.borderWidth=1;
    self.subViewImg.layer.borderColor=[UIColor whiteColor].CGColor;
    
    CAKeyframeAnimation *anim2 = [CAKeyframeAnimation animation];
    anim2.keyPath = @"transform.rotation";
    
    anim2.values =@[@(Angle2Radian(0)),  @(Angle2Radian(360))];
    anim2.duration = 16;
    
    anim2.repeatCount = MAXFLOAT;
    
    anim2.removedOnCompletion = NO;
    anim2.fillMode = kCAFillModeForwards;

    [self.subViewImg.layer  addAnimation:anim2 forKey:nil];
    
    CABasicAnimation *animation = [ CABasicAnimation
                                   animationWithKeyPath: @"transform" ];
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    
//    //围绕Z轴旋转，垂直与屏幕
//    animation.toValue = [ NSValue valueWithCATransform3D:
//                         
//                         CATransform3DMakeRotation(M_PI, 0.0, 0.0, 1.0) ];
//    animation.duration = 16;
//    //旋转效果累计，先转180度，接着再旋转180度，从而实现360旋转
//    animation.cumulative = YES;
//    animation.repeatCount = 1000;
//    
//    //在图片边缘添加一个像素的透明区域，去图片锯齿
//    CGRect imageRrect = CGRectMake(0, 0,self.subViewImg.frame.size.width,self.subViewImg.frame.size.height);
//    UIGraphicsBeginImageContext(imageRrect.size);
//    [self.subViewImg.image drawInRect:CGRectMake(1,1,self.subViewImg.frame.size.width-2,self.subViewImg.frame.size.height-2)];
//    self.subViewImg.image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    
//    [self.subViewImg.layer addAnimation:animation forKey:nil];
    
}
-(void)setImageString:(NSString *)imageString
{
    _imageString=imageString;
    
    [self.subViewImg setImageWithURL:[NSURL URLWithString:_imageString] placeholderImage:[UIImage imageNamed:@"SYF加载中"]];
}

@end
