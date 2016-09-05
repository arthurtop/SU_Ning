//
//  DSZFYJNavView.m
//  8.1苏宁ipad
//
//  Created by app05 on 15/8/2.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZFYJNavView.h"
#import "DSZFYJDataTool.h"
@implementation DSZFYJNavView
+(id)createNavView
{
    return [[[NSBundle mainBundle]loadNibNamed:@"DSZFYJNavView" owner:nil options:nil] lastObject];
}
-(void)awakeFromNib
{
    NSString *str=[DSZFYJDataTool sharedDSZFYJDataTool].placeName;
    
    NSString *labelStr=[NSString stringWithFormat:@"您当前所在位置为:%@",str];
    self.titleLabel.text=labelStr;
}
- (IBAction)clickBtn:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(didclickNavBtn:)]) {
        [self.delegate didclickNavBtn:sender];
        //101  102   103  tag值
    }
}

@end
