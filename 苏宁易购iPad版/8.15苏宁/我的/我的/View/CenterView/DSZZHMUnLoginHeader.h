//
//  DSZZHMUnLoginHeader.h
//  8.1苏宁ipad
//
//  Created by app01 on 15/8/3.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DSZZHMUnLoginHeader : UICollectionReusableView


@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property(copy,nonatomic)void (^loginBlock)();




- (IBAction)loginAction:(UIButton *)sender;

@end
