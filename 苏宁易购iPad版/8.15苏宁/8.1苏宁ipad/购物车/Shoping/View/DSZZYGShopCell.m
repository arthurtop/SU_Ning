//
//  DSZZYGShopCell.m
//  8.1苏宁ipad
//
//  Created by app15 on 15/8/2.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZZYGShopCell.h"
#import "DSZZYGThingsModel.h"
#import "DSZZYGShopModel.h"
#import "UIImageView+WebCache.h"
#import "DSZZYGshopDatabase.h"


@implementation DSZZYGShopCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self=[[[NSBundle mainBundle]loadNibNamed:@"DSZZYGShopCell" owner:nil options:nil]lastObject];
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
        longPress.minimumPressDuration = 2;//最小长按时间
        [self addGestureRecognizer:longPress];

    }
    return self;
}

- (void)longPressAction:(UILongPressGestureRecognizer *)longPress {
    //如果不判断会调用2次 按下2秒后自己调用一次 松开后又要调用一次
    if (longPress.state == UIGestureRecognizerStateEnded) {
        [self alertview];
        return;
    }
    
}

-(void)alertview{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"是否删除该地址" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:@"取消", nil];
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==1) {
        
    }else{
        //做事
        shopdata=[[DSZZYGshopDatabase alloc]init];
        [shopdata createDatabase];
        [shopdata createTable];
        [shopdata delete:self.thingid];
        [self.delegate tabledata];
    }
    
}


- (IBAction)deleNum:(id)sender {
    if ([_number.titleLabel.text intValue]<=1) {
        return;
    }else{
        int num=[_number.titleLabel.text intValue]-1;
        shopdata=[[DSZZYGshopDatabase alloc]init];
        [shopdata update:self.thingid thingnum:num];
        [_number setTitle:[NSString stringWithFormat:@"%i",num] forState:UIControlStateNormal];
        [self.delegate tabledata];
    }
}

- (IBAction)addNum:(id)sender {
    int num=[_number.titleLabel.text intValue]+1;
    shopdata=[[DSZZYGshopDatabase alloc]init];
    [shopdata update:self.thingid thingnum:num];
    [_number setTitle:[NSString stringWithFormat:@"%i",num] forState:UIControlStateNormal];
    [self.delegate tabledata];
}

- (IBAction)select:(UIButton *)sender {
    if (sender.selected==YES) {
        sender.selected=NO;
        shopdata=[[DSZZYGshopDatabase alloc]init];
        [shopdata update:self.thingid selectthing:0];
        
        [self.delegate tabledata];
        
    }else{
        sender.selected=YES;
        shopdata=[[DSZZYGshopDatabase alloc]init];
        [shopdata update:self.thingid selectthing:1];
        
        [self.delegate tabledata];
        
        

    }
}


-(void)setcell:(NSDictionary*)dic{
    NSString *thing=dic[@"thingid"];
    self.thingid=thing ;
    
    self.priceLabel.text=dic[@"thingprice"];
    
    [self.thingimage setImageWithURL:[NSURL URLWithString:dic[@"thingimage"]]];
    
    self.titleLabel.text=dic[@"title"];
    
    id i=dic[@"num"];
    NSString *num=[NSString stringWithFormat:@"%@",i];
    [self.number setTitle:num forState:UIControlStateNormal];
    
    id selectthings=dic[@"selectthing"];
    int selectthing=[selectthings intValue];
    if (selectthing==1) {
        self.selectBtn.selected=YES;
    }
    else{
        self.selectBtn.selected=NO;
    }
    
    
    _number.highlighted=NO;
    
}
@end
