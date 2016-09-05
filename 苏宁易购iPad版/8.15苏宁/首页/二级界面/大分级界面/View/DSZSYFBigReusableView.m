//
//  DSZSYFBigReusableView.m
//  8.2二级界面
//
//  Created by lovena on 15/8/2.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZSYFBigReusableView.h"
#import "UIImageView+WebCache.h"
#import "DSZSYFejModel.h"
//角度边弧度 180 ---> M_PI   10/180.0 * M_PI 如传递90  就是2/M_PI
#define Angle2Radian(angle) ((angle) / 180.0 * M_PI)
@interface DSZSYFBigReusableView()
@property(nonatomic,retain)NSArray *array;//数组
@property (nonatomic, strong) NSTimer *timer;
@end
@implementation DSZSYFBigReusableView

//事件
-(void)awakeFromNib
{
    //第一张图片变化
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    anim.keyPath = @"transform.scale";
    
    anim.values = @[@(1.1),@(1),@(1.1)];
    anim.duration = 3;
    // 动画的重复执行次数
    anim.repeatCount = MAXFLOAT;
    
    // 保持动画执行完毕后的状态
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    
    CAKeyframeAnimation *anim2 = [CAKeyframeAnimation animation];
    anim2.keyPath = @"transform.rotation";
    
    anim2.values =@[@(Angle2Radian(-10)),  @(Angle2Radian(10)), @(Angle2Radian(-10))];
    anim2.duration = 3;
    // 动画的重复执行次数
    anim2.repeatCount = MAXFLOAT;
    
    //第一张图片变化
    CAKeyframeAnimation *anim3 = [CAKeyframeAnimation animation];
    anim3.keyPath = @"transform.scale";
    
    anim3.values = @[@(1.2),@(1),@(1.2)];
    anim3.duration = 4;
    // 动画的重复执行次数
    anim3.repeatCount = MAXFLOAT;
    
//    CABasicAnimation *anim4=[CABasicAnimation animation];
//    anim4.keyPath=@"transform.position";
//    anim4.fromValue=[NSValue valueWithCGPoint:CGPointMake(100, 50)];
//    anim4.toValue=[NSValue valueWithCGPoint:CGPointMake(400, 50)];
//    anim4.duration=4;
//    // 动画的重复执行次数
//    anim4.repeatCount = MAXFLOAT;
//    anim4.removedOnCompletion = NO;
//    anim4.fillMode = kCAFillModeForwards;

    
    // 保持动画执行完毕后的状态
    anim3.removedOnCompletion = NO;
    anim3.fillMode = kCAFillModeForwards;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[anim,anim2];
    group.duration = 3.0;
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    group.repeatCount=MAXFLOAT;
    
    CAAnimationGroup *group2 = [CAAnimationGroup animation];
    group2.animations = @[anim,anim2];
    group2.duration = 3.0;
    group2.removedOnCompletion = NO;
    group2.fillMode = kCAFillModeForwards;
    group2.repeatCount=MAXFLOAT;
    
    
    [self.bgImage.layer addAnimation:anim forKey:nil];
    [self.firImage.layer addAnimation:group forKey:@"shake"];
    [self.secImage.layer addAnimation:anim3 forKey:nil];
    [self.thrImage.layer addAnimation:group forKey:nil];
    [self.fourImage.layer addAnimation:group forKey:nil];
    [self.fiveImage.layer addAnimation:anim3 forKey:nil];
}



@end
