//
//  DSZZHMNavBar.h
//  8.1苏宁ipad
//
//  Created by app01 on 15/8/2.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSZFYJNavView.h"

#import "DSZZYGBtn.h"
@interface DSZZHMNavBar : UIView

//搜索框
@property (weak, nonatomic) IBOutlet UITextField *searchTextView;
@property (weak, nonatomic) IBOutlet UIButton *myLogo;

@property(weak,nonatomic)id<DSZFYJNavViewDelegate>delegate;

@property(nonatomic,retain)DSZZYGBtn *zygBtn;

@property(copy,nonatomic)NSString *tel;
//点击按钮
- (IBAction)clickBtnAction:(UIButton *)sender;


+(instancetype)createNavBar;

-(void)setbtnTitle;
//搜索
- (IBAction)clickSearch;
@property(nonatomic,copy)void(^myBlock)();

@end
