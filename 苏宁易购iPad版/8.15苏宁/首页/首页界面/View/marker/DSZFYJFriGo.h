//
//  DSZFYJFriGo.h
//  8.1苏宁ipad
//
//  Created by app05 on 15/8/3.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FYJFriGoBtnDelegate <NSObject>

-(void)clickFriGoBtnWithSender:(UIButton *)sender;

@end
@interface DSZFYJFriGo : UIView
+(id)FYJFriGoView;
@property(nonatomic,weak)id<FYJFriGoBtnDelegate>delegate;


- (IBAction)FYJFriendGo:(id)sender;

@end
