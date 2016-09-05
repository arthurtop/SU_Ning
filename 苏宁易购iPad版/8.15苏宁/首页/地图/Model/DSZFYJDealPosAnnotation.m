//
//  TGDealPosAnnotation.m
//  团购
//
//  Created by app43 on 15/7/31.
//  Copyright (c) 2015年 app43. All rights reserved.
//

#import "DSZFYJDealPosAnnotation.h"


@implementation DSZFYJDealPosAnnotation


-(void)setImage:(NSString *)image
{
    _image=image;
}
-(void)setDeal_id:(NSString * )deal_id
{
    _deal_id=deal_id;
}
-(void)setTitle:(NSString *)title
{
    _title=title;
    
}
-(void)setName:(NSString *)name
{
    _name=name;
}
-(void)setSubtitle:(NSString *)subtitle
{
    _subtitle=subtitle;
}
-(void)setDesc:(NSString *)desc
{
    _desc=desc;
}
-(void)setCount:(NSInteger)count
{
    _count=count;
}

@end
