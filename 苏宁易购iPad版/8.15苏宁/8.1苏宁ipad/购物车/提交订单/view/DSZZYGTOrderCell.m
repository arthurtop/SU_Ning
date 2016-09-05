//
//  DSZZYGTOrderCell.m
//  8.1苏宁ipad
//
//  Created by app15 on 15/8/5.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZZYGTOrderCell.h"
#import "UIImageView+WebCache.h"
@implementation DSZZYGTOrderCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self=[[[NSBundle mainBundle]loadNibNamed:@"DSZZYGTOrderCell" owner:nil options:nil]lastObject];
    }
    return  self;
}

-(void)setcell:(NSDictionary*)dic{

    
    self.orderprice.text=dic[@"thingprice"];
    
    [self.orderimage setImageWithURL:[NSURL URLWithString:dic[@"thingimage"]]];
    
    self.ordertitle.text=dic[@"title"];
    
    id i=dic[@"num"];
    NSString *num=[NSString stringWithFormat:@"x%@",i];
    [self.ordernum setTitle:num forState:UIControlStateNormal];
    
    
}

@end
