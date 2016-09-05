//
//  DSZCQTomorrowViewCell.m
//  8.1苏宁ipad
//
//  Created by app20 on 15/8/3.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZCQTomorrowViewCell.h"
#import "Common.h"

@implementation DSZCQTomorrowViewCell

+ (instancetype)createDSZCQTomorrowViewCell
{
    return [[[NSBundle mainBundle] loadNibNamed:@"DSZCQTomorrowViewCell" owner:nil options:nil] lastObject];
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

- (void)setList_price:(CGFloat)list_price
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

// 缴纳保证金
- (IBAction)payDeposit {
}

@end
