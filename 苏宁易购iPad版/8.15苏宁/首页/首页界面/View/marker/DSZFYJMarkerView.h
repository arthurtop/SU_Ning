//
//  DSZFYJMarkerView.h
//  8.1苏宁ipad
//
//  Created by app05 on 15/8/3.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol FYJMarkerBtnDelegate <NSObject>

-(void)clickMarkerBtnWithSender:(UIButton *)sender;

@end
@interface DSZFYJMarkerView : UIView
+(id)FYJMarkerView;
@property(nonatomic,weak)id<FYJMarkerBtnDelegate>delegate;

- (IBAction)FYJmarketBtn:(id)sender;

@end
