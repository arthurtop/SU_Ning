//
//  DSZCQHelpView.h
//  8.1苏宁ipad
//
//  Created by app20 on 15/8/5.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DSZCQHelpView : UIView

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UITextView *textViewCellphone;
@property (weak, nonatomic) IBOutlet UITextView *protocol;

+ (instancetype)createDSZCQHelpView;

@end
