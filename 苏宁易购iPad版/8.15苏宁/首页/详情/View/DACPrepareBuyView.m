//
//  DACPrepareBuyView.m
//  8.2二级界面
//
//  Created by app33 on 15/8/4.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DACPrepareBuyView.h"
#import "UIImageView+WebCache.h"
@implementation DACPrepareBuyView

+(id)createBuyView
{
    return [[[NSBundle mainBundle]loadNibNamed:@"DACPrepareBuyView" owner:nil options:nil]lastObject];
}
-(void)awakeFromNib
{
    self.layer.cornerRadius = 8;
    self.layer.masksToBounds = YES;
    self.addToBuyView.layer.cornerRadius = 8;
    self.addToBuyView.layer.masksToBounds = YES;
    
    self.buyNowView.layer.cornerRadius = 8;
    self.buyNowView.layer.masksToBounds = YES;
}

- (IBAction)reduceClick {
   
    //取出数量的文字
    NSString *str = self.count.currentTitle;
    int cou = [str intValue];
    if (cou==1) {
        self.reduceCountView.enabled = NO;
    }
    else
    {
        self.reduceCountView.enabled = YES;
        cou--;
    }
    NSString *str2 = [NSString stringWithFormat:@"%d",cou];
    [self.count setTitle:str2 forState:UIControlStateNormal];
  
}

- (IBAction)addClick {
    NSString *str = self.count.currentTitle;
    int cou = [str intValue];
    if (cou>1) {
          self.reduceCountView.enabled = YES;
    }
    cou++;
    NSString *str2 = [NSString stringWithFormat:@"%d",cou];
    [self.count setTitle:str2 forState:UIControlStateNormal];

}

- (IBAction)buyNowClick {
    if ([self.delagate respondsToSelector:@selector(buyNowClickDelegate)]) {
        [self.delagate buyNowClickDelegate];
    }
}

- (IBAction)addToBuyClick {
    //取出购买的数量
    NSString *str = self.count.currentTitle;
    _buyCount = [str intValue];
    if ([self.delagate respondsToSelector:@selector(prepareBuyDelagate)]) {
        [self.delagate prepareBuyDelagate];
    }
}

-(void)setModel:(XQModel *)model
{
    _model = model;
    self.name.text =  _model.title;
    [self.image setImageWithURL:[NSURL URLWithString:_model.image_url] placeholderImage:[UIImage imageNamed:@"加载中"]];
    double dou = _model.current_price;
    NSString *str = [NSString stringWithFormat:@"%.2f",dou];
    self.price.text = [NSString stringWithFormat:@"¥ %@",str];
}
@end
