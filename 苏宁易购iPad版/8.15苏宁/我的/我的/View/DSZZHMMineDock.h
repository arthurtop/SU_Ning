//
//  DSZZHMMineDock.h
//  8.1苏宁ipad
//
//  Created by app01 on 15/8/2.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DSZZHMButton,DSZZHMMineDock;

@protocol DSZZHMDockDelegate <NSObject>

- (void)dock:(DSZZHMMineDock *)dock ViewChangeFrom:(NSInteger)from to:(NSInteger)to;

-(void)exit;

@end


@interface DSZZHMMineDock : UIView

//按钮数组
@property (strong, nonatomic) IBOutletCollection(DSZZHMButton) NSArray *btns;

@property (strong, nonatomic)  DSZZHMButton *selectedBtn;
//退出按钮
@property (weak, nonatomic) IBOutlet DSZZHMButton *exitBtn;

@property(weak,nonatomic)id<DSZZHMDockDelegate>delegate;

//点击按钮
- (IBAction)clickBtn:(DSZZHMButton *)sender;
//退出
- (IBAction)ExitAction:(DSZZHMButton *)sender;

+(instancetype)createDock;

@end
