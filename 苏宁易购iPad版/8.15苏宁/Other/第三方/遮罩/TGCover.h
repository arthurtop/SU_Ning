//
//  TGCover.h
//  团购
//
//  Created by lovena on 15/7/29.
//  Copyright (c) 2015年 sk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TGCover : UIView
+ (id)cover;
+ (id)coverWithTarget:(id)target action:(SEL)action;

- (void)reset;
@end
