//
//  DSZCQFeesView.h
//  8.1苏宁ipad
//
//  Created by app20 on 15/8/5.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DSZCQFeesView : UIView

@property (weak, nonatomic) IBOutlet UILabel *ammeterNumName;
@property (weak, nonatomic) IBOutlet UITextField *ammeterNum;

+ (instancetype)createDSZCQFeesView;

@end
