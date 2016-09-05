//
//  goodsDetailShowView.m
//  8.2二级界面
//
//  Created by app33 on 15/8/3.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "goodsDetailShowView.h"
#import "SDImageCache.h"
#import "UIImageView+WebCache.h"
#import "NSDate+MJ.h"
#import "UIViewExt.h"
@implementation goodsDetailShowView

+(id)createGoodsDetailView
{
    return [[[NSBundle mainBundle]loadNibNamed:@"goodsDetailShow" owner:nil options:nil]lastObject];
}

-(void)setModel:(XQModel *)model
{
    _model = model;
    if (_model.restrictions) {//有约束
        _goodsDetail.enabled = _model.restrictions.is_refundable;
        _buyKnow.enabled = _model.restrictions.is_reservation_required;
        
    }
       //下载图片
        [_bigImage setImageWithURL:[NSURL URLWithString:_model.image_url] placeholderImage:[UIImage imageNamed:@"加载中"]];    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd"; // 2013-11-17
    // 2013-11-17
    NSDate *dealline = [fmt dateFromString:_model.purchase_deadline];
    // 2013-11-18 00:00:00
    dealline = [dealline dateByAddingTimeInterval:24 * 3600];
    // 2013-11-17 10:50
    NSDate *now = [NSDate date];
    
    NSDateComponents *cmps = [now compare:dealline];
    
    NSString *timeStr = [NSString stringWithFormat:@"%ld 天 %ld 小时 %ld 分钟", (long)cmps.day, (long)cmps.hour, (long)cmps.minute];
    [_time setTitle:timeStr forState:UIControlStateNormal];

// 4.购买人数
 NSString *pc = [NSString stringWithFormat:@"%d 人已购买",_model.purchase_count];
[_purchaseCount setTitle:pc forState:UIControlStateNormal];

 // 5.设置描述
   _title.text = _model.title;
// 描述的高度
CGFloat descH = [_model.title sizeWithFont:_title.font constrainedToSize:CGSizeMake(_title.frame.size.width, MAXFLOAT) lineBreakMode:_title.lineBreakMode].height + 20;

    CGRect frame3 = _title.frame;
    CGFloat flo = descH - frame3.size.height;
    frame3.size.height = descH;
    _title.frame = frame3;
    
    CGRect frame4 = self.headView.frame;
    frame4.size.height = frame4.size.height + flo;
    self.headView.frame = frame4;
// 7 团购详情
    NSString *str = _model.details;
    _goodsDetail.font = [UIFont boldSystemFontOfSize:18];
    //CGFloat strH = [str sizeWithFont:_goodsDetail.font constrainedToSize:CGSizeMake(_goodsDetail.frame.size.width, MAXFLOAT) lineBreakMode:_goodsDetail.lineBreakMode].height+20;
    CGSize sizegood=[str boundingRectWithSize:CGSizeMake(_goodsDetail.frame.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} context:nil].size;
    CGFloat strH=sizegood.height;
    _goodsDetail.text = str;
    CGRect frame1 = _goodsDetail.frame;
    CGFloat flo2 = strH - frame1.size.height;
    frame1.size.height = strH;
    _goodsDetail.frame = frame1;
    
    CGRect frame = _goodsDetailView.frame;
    frame.origin.y = _headView.bottom +20;
    frame.size.height = frame.size.height + flo2;
    frame.origin.x = 258;
    _goodsDetailView.frame = frame;
  
    //8 购买须知
    NSString *str2 = _model.restrictions.special_tips;;
    CGFloat strH2 = [str2 sizeWithFont:_goodsDetail.font constrainedToSize:CGSizeMake(_buyKnow.frame.size.width, MAXFLOAT) lineBreakMode:_buyKnow.lineBreakMode].height+20;
    _buyKnow.text = str2;
    CGRect frame5 = _buyKnow.frame;
    CGFloat flo5 = strH2 - frame5.size.height;
    frame5.size.height = strH2;
    _buyKnow.frame = frame5;

    CGRect frame6 = _buyKnowView.frame;
    frame6.origin.y = _goodsDetailView.bottom + 20;
    frame6.size.height = frame6.size.height + flo5;
    _buyKnowView.frame = frame6;
    
    self.height = _buyKnowView.bottom + 30;
    
}
@end
