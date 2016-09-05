//
//  DSZCQLotViewCell.m
//  8.1苏宁ipad
//
//  Created by app20 on 15/8/2.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZCQTodayViewCell.h"
#import "NSDate+MJ.h"
#import "Common.h"

@implementation DSZCQTodayViewCell

- (IBAction)subtract {
    
    NSInteger raisePrice = [_raisePrice.text integerValue];
    raisePrice -= 5;
    NSString *text = [NSString stringWithFormat:@"%ld",(long)raisePrice];
    _raisePrice.text = text;
    
}

- (IBAction)plus {
    
    NSInteger raisePrice = [_raisePrice.text integerValue];
    raisePrice += 5;
    NSString *text = [NSString stringWithFormat:@"%ld",(long)raisePrice];
    _raisePrice.text = text;
    
}

- (IBAction)payDeposit {
}

+ (instancetype)createDSZCQLotViewCell
{
    return [[[NSBundle mainBundle] loadNibNamed:@"DSZCQTodayViewCell" owner:nil options:nil]lastObject];
}

- (void)awakeFromNib
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeRefresh) userInfo:nil repeats:YES];
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

- (void)setList_price:(double)list_price
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

- (void)setCurrent_price:(double)current_price
{
    if (_current_price != current_price)
    {
        _current_price = current_price;
        NSString *priceString = [NSString stringWithFormat:@"%0.2f",current_price];
        _currentPrice.text = priceString;
 
    }

}

- (void)setPurchase_deadline:(NSString *)purchase_deadline
{
    if (_purchase_deadline != purchase_deadline)
    {
        
        _purchase_deadline = purchase_deadline;
        
    }
}

- (void)timeRefresh
{
    if (_purchase_deadline != nil) {
        
        NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
        fmt.dateFormat = @"yyyy-MM-dd";
        NSDate *dealline = [fmt dateFromString:_purchase_deadline];
        NSDate *now = [NSDate date];
        NSDateComponents *cmps = [now compare:dealline];
        NSString *hourStr = [NSString stringWithFormat:@"%02d", (int)cmps.hour];
        
        unichar *hourStr1 = [hourStr characterAtIndex:0];
        unichar *hourStr2 = [hourStr characterAtIndex:1];
        
        NSString *hour = [NSString stringWithFormat:@"%c %c",hourStr1,hourStr2];
        _hour.text = hour;
        
        NSString *minutesStr = [NSString stringWithFormat:@"%02d", (int)cmps.minute];
        
        unichar *minutesStr1 = [minutesStr characterAtIndex:0];
        unichar *minutesStr2 = [minutesStr characterAtIndex:1];
        
        NSString *minutes = [NSString stringWithFormat:@"%c %c",minutesStr1,minutesStr2];
        _minutes.text = minutes;
        
        NSString *secondStr = [NSString stringWithFormat:@"%02d", (int)cmps.second];
        
        unichar *secondStr1 = [secondStr characterAtIndex:0];
        unichar *secondStr2 = [secondStr characterAtIndex:1];
        
        NSString *second = [NSString stringWithFormat:@"%c %c",secondStr1,secondStr2];
        _second.text = second;
        
    }
}

@end
