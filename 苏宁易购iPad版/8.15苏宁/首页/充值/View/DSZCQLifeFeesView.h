//
//  DSZCQLifeFeesView.h
//  8.1苏宁ipad
//
//  Created by app20 on 15/8/5.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DSZCQLifeFeesTypeViewDelegate <NSObject>

- (void)clickLifeFeesTypeBtn:(NSInteger)index;

@end

@interface DSZCQLifeFeesView : UIView

+ (instancetype)createDSZCQLifeFeesView;

@property (weak, nonatomic) IBOutlet UIButton *firstBtn;
@property(nonatomic,weak) UIButton *lastBtn;
@property(nonatomic,weak) id <DSZCQLifeFeesTypeViewDelegate> delegate;

@end
