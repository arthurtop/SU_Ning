//
//  DSZZHMHistoryHeader.h
//  8.1苏宁ipad
//
//  Created by app01 on 15/8/7.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CenterDeleteHistory <NSObject>

-(void)deleteHistoryAction;

@end


@interface DSZZHMHistoryHeader : UIView

@property(nonatomic,weak)id <CenterDeleteHistory>delegate;


//删除历史纪录
- (IBAction)deleteHistory:(UIButton *)sender;


@end
