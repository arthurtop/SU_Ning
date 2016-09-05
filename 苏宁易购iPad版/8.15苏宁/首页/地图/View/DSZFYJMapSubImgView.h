//
//  DSZFYJMapSubImgView.h
//  8.1苏宁ipad
//
//  Created by app05 on 15/8/6.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DSZFYJMapSubImgView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *subViewImg;
@property(nonatomic,copy)NSString *imageString;

+(id)FYJMapSubImg;

@end
