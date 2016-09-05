//
//  DSZMainController.h
//  8.1苏宁ipad
//
//  Created by lovena on 15/8/1.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSZSYFLeftview.h" 
#import "DSZZYGBaseViewController.h"
@class DSZSYFtopView;
@interface DSZMainController : DSZZYGBaseViewController<DSZSYFLeftviewDelegate>

@property(copy,nonatomic)NSString *tel;

@property(weak,nonatomic)DSZSYFtopView *topview;
@property (weak, nonatomic) IBOutlet DSZSYFLeftview *leftView;
-(void)Buynum:(NSInteger)number;
@end
