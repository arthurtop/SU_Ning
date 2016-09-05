//
//  DSZFYJTotalPageViewController.h
//  8.1苏宁ipad
//
//  Created by app05 on 15/8/2.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DSZFYJTotalPageView;
@protocol DSZFYJTotalPageViewDelegate <NSObject>
-(void)FYJdidselectedController;
-(void)FYJdidBtnToControllerWithTag:(NSInteger)tag;


@end
@interface DSZFYJTotalPageView : UIScrollView
@property(nonatomic,weak)id<DSZFYJTotalPageViewDelegate>delegate;
@end
