//
//  DSZCQPayTypeView.h
//  8.1苏宁ipad
//
//  Created by app20 on 15/8/4.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DSZCQPayTypeViewDelegate <NSObject>

- (void)clickBankBtn;

@end

@interface DSZCQPayTypeView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *efubaoImage;
@property (weak, nonatomic) IBOutlet UIImageView *bankImage;

@property (weak, nonatomic) IBOutlet UILabel *efubaoLabel;
@property (weak, nonatomic) IBOutlet UILabel *bankLabel;

@property (weak, nonatomic) id <DSZCQPayTypeViewDelegate> delegate;

@property(nonatomic,copy)void(^myblock)();

- (IBAction)efubaoBtn;
- (IBAction)bankBtn;

+ (instancetype)createDSZCQPayTypeView;

@end
