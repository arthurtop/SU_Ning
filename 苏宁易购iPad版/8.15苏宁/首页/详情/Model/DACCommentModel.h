//
//  DACCommentModel.h
//  8.2二级界面
//
//  Created by app33 on 15/8/4.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DACCommentModel : NSObject
@property (nonatomic, copy) NSString *nickname; // 用户名
@property (nonatomic, copy) NSString *rating; // 评分
@property (nonatomic, copy) NSString *content; // 描述
@property (nonatomic, copy) NSString *name; // 店名
@property (nonatomic, copy) NSString *time; // 时间
@end
