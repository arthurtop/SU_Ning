//
//  MyCell.m
//  7.30界面
//
//  Created by lovena on 15/7/31.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZSYMyCell.h"
#import "Common.h"
@implementation DSZSYMyCell

+(id)createCell
{
    return [[[NSBundle mainBundle]loadNibNamed:@"DSZSYMyCell" owner:nil options:nil] lastObject];
}
// 重写set方法
-(void)setFirmodel:(DSZSYFirstModel *)firmodel
{
    _firmodel=firmodel;
    //循环创造按钮
    

    CGFloat btnMarginLeft=30;
    CGFloat btnTX=btnMarginLeft;

    CGFloat btnTW=self.contentView.frame.size.width;
    
    CGFloat btnY=10;
    
    for(int i=0;i<firmodel.subcategories.count;i++)
    {
       UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:firmodel.subcategories[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        btn.titleLabel.font=[UIFont systemFontOfSize:13];
        [btn setBackgroundColor:[UIColor whiteColor]];
        
//        //圆角
//        btn.layer.cornerRadius=3;
//        btn.layer.masksToBounds=YES;
        
        CGSize sizebtn=[firmodel.subcategories[i] boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
        CGFloat btnw=sizebtn.width+20;
        if (btnw<66) {
            btnw=66;
        }
        CGFloat btnh=sizebtn.height+10;
        
        CGFloat margin=10;
        
        CGFloat index=btnTW-btnTX;
        if (index>btnw) {
            btn.frame=CGRectMake(btnTX, btnY, btnw, btnh);
            btnTX=btnw+margin+btnTX;
        }else
        {
            btnTX=btnMarginLeft;
            btnY=margin+btnh+btnY;
            btn.frame=CGRectMake(btnTX, btnY, btnw, btnh);
            btnTX=btnw+margin+btnTX;
        }
        

        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btn];
        
        if (i==firmodel.subcategories.count-1) {
            _cellHeight=btn.bottom+margin*2;
        }
    }
    
    
}
//传值
-(void)click:(UIButton *)btn
{
    NSString *str=[btn titleForState:UIControlStateNormal];
//    if ([self.delegate respondsToSelector:@selector(didselectedBtnCell:)]) {
//        [self.delegate didselectedBtnCell:str];
//    }
    //通知
    NSDictionary *dic=@{@"str":str};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"cellstr" object:nil userInfo:dic];
}
@end
