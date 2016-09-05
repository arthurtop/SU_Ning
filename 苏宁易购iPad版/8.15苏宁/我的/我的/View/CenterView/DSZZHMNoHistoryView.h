//
//  DSZZHMNoHistoryView.h
//  8.1苏宁ipad
//
//  Created by app01 on 15/8/3.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface DSZZHMNoHistoryView : UIView

@property (weak, nonatomic) IBOutlet UIButton *goBtn;

//点击去逛逛
@property(copy,nonatomic)void (^goBlock)();

- (IBAction)goAction:(UIButton *)sender;


@end
