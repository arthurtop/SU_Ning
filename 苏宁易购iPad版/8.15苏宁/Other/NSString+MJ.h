//
//  NSString+MJ.h
//  团购
//
//  Created by lovena on 15/7/29.
//  Copyright (c) 2015年 sk. All rights reserved.
//
//用来保留小数处理的类别，你只需要关心把什么数保留几位，如果小树位都是0，他会帮你舍弃
#import <Foundation/Foundation.h>

@interface NSString (MJ)
// 生成一个保留fractionCount位小数的字符串(裁剪尾部多余的0)
+ (NSString *)stringWithDouble:(double)value fractionCount:(int)fractionCount;

@end
