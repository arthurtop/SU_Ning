//
//  NSString+MJ.h
//  大众点评  －－－ 7.24
//
//  Created by app01 on 15/7/29.
//  Copyright (c) 2015年 app01. All rights reserved.
//

#import <Foundation/Foundation.h>

//用于保留小数的处理，保留几位fractionCount传几就ok
//然后在model里重写对应变量set方法(利用第三方框架变model)
//- (void)setList_price:(double)list_price
//{
//    _list_price = list_price;
//    
//    _list_price_text = [NSString stringWithDouble:list_price fractionCount:2];
//}

@interface NSString (MJ)

// 生成一个保留fractionCount位小数的字符串(裁剪尾部多余的0)
+ (NSString *)stringWithDouble:(double)value fractionCount:(int)fractionCount;



@end
