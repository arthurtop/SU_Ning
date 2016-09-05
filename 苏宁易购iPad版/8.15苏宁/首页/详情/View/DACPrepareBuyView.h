//
//  DACPrepareBuyView.h
//  8.2二级界面
//
//  Created by app33 on 15/8/4.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XQModel.h"
@protocol DACPrepareBuyViewDelagate <NSObject>
-(void)prepareBuyDelagate;
-(void)buyNowClickDelegate;
@end
@interface DACPrepareBuyView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *image;

@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UILabel *price;

@property (weak, nonatomic) IBOutlet UIButton *count;

@property (weak, nonatomic) IBOutlet UIButton *buyNowView;

@property (weak, nonatomic) IBOutlet UIButton *addToBuyView;

@property (weak, nonatomic) IBOutlet UIButton *reduceCountView;

- (IBAction)reduceClick;

- (IBAction)addClick;

- (IBAction)buyNowClick;

- (IBAction)addToBuyClick;

+(id)createBuyView;

@property(nonatomic,strong)XQModel *model;

@property(nonatomic,assign)int buyCount;

@property(nonatomic,weak)id<DACPrepareBuyViewDelagate>delagate;
@end
