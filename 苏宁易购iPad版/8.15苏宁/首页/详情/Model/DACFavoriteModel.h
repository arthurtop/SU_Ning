//
//  DACFavoriteModel.h
//  8.2二级界面
//
//  Created by mini on 15/8/6.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DACFavoriteModel : NSObject<NSCoding>
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *imageUrl;
@property (nonatomic, copy) NSString *deal_id;
@end
