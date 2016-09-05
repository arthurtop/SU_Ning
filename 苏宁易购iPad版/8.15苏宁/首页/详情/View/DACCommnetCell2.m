//
//  DACCommnetCell2.m
//  8.2二级界面
//
//  Created by app33 on 15/8/4.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DACCommnetCell2.h"

@implementation DACCommnetCell2

+(id)createCell2
{
    return [[[NSBundle mainBundle]loadNibNamed:@"DACCommnetCell2" owner:nil options:nil]lastObject];
}

-(void)setModel:(DACCommentModel *)model
{
    _model = model;
    self.nickname.text = _model.nickname;
    self.content.text = _model.content;
    self.name.text = _model.name;
    self.time.text = _model.time;
    NSString *rating = _model.rating;
   float rat = [rating floatValue];
    CGRect frame = _yellowView.frame;
    CGFloat wid = rat/10.0*150;
    frame.size.width = wid;
    _yellowView.frame = frame;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
