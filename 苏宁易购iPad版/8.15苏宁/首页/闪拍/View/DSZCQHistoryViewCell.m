//
//  DSZCQHistoryViewCell.m
//  8.1苏宁ipad
//
//  Created by app20 on 15/8/3.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZCQHistoryViewCell.h"
#import "Common.h"

@implementation DSZCQHistoryViewCell

+ (instancetype)createDSZCQHistoryViewCell
{
    return [[[NSBundle mainBundle] loadNibNamed:@"DSZCQHistoryViewCell" owner:nil options:nil] lastObject];
}

- (void)setImage_url:(NSString *)image_url
{
    if (_image_url != image_url)
    {
        
        _image_url = image_url;
        [_image setImageWithURL:[NSURL URLWithString:_image_url]];
    }
}

- (void)setTitle:(NSString *)title
{
    if (_title != title)
    {
        
        _title = title;
        _nameLable.text = _title;
    }
}

- (void)setList_price:(float)list_price
{
    if (_list_price != list_price)
    {
        
        _list_price = list_price;
        _consultPrice.text =nil;
        NSString *priceString = [NSString stringWithFormat:@"%0.2f",list_price];
        _consultPrice.text = priceString;
        self.priceLine.width = 8.5 * priceString.length;
    }
    
}

- (void)setCurrent_price:(float)current_price
{
    if (_current_price != current_price)
    {
        _current_price = current_price;
        NSString *priceString = [NSString stringWithFormat:@"%0.2f",current_price];
        _currentPrice.text = priceString;
        
    }
    
}

@end
