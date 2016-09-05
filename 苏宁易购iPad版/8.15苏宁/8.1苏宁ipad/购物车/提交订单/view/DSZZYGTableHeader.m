//
//  DSZZYGTableHeader.m
//  8.1苏宁ipad
//
//  Created by app15 on 15/8/3.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZZYGTableHeader.h"
#import "DSZZYGPopTable.h"
#import "MBProgressHUD+MJ.h"
@implementation DSZZYGTableHeader

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)changeAddress:(UIButton *)sender {
    [self.delegate pushAddress];
}

- (IBAction)addAddress:(UIButton *)sender {
    [self.delegate pushAddress];
}

- (IBAction)payStyle:(UIButton *)sender {
    if (self.payView.hidden) {
        self.payStyleBtn.selected=YES;
        self.payView.hidden=NO;
        CGRect frame= self.paystyleView.frame;
        frame.size.height=self.paystyleView.frame.size.height+190;
        self.paystyleView.frame=frame;
        
        CGRect frame1=self.addquanBtn.frame;
        frame1.origin.y=self.addquanBtn.frame.origin.y+190;
        self.addquanBtn.frame=frame1;
        
        CGRect frame2=self.addQuanLabel.frame;
        frame2.origin.y=self.addQuanLabel.frame.origin.y+190;
        self.addQuanLabel.frame=frame2;
        
        CGRect frame3=self.fapiaoView.frame;
        frame3.origin.y=self.fapiaoView.frame.origin.y+190;
        self.fapiaoView.frame=frame3;

        [self.delegate HeaderHeight:627];
        
    }else{
        self.payStyleBtn.selected=NO;
        self.payView.hidden=YES;
        CGRect frame= self.paystyleView.frame;
        frame.size.height=self.paystyleView.frame.size.height-190;
        self.paystyleView.frame=frame;
        
        CGRect frame1=self.addquanBtn.frame;
        frame1.origin.y=self.addquanBtn.frame.origin.y-190;
        self.addquanBtn.frame=frame1;
        
        CGRect frame2=self.addQuanLabel.frame;
        frame2.origin.y=self.addQuanLabel.frame.origin.y-190;
        self.addQuanLabel.frame=frame2;
        
        CGRect frame3=self.fapiaoView.frame;
        frame3.origin.y=self.fapiaoView.frame.origin.y-190;
        self.fapiaoView.frame=frame3;
        [self.delegate HeaderHeight:437];
    }
}

- (IBAction)addQuan:(UIButton *)sender {
    [self.delegate pushQuan];
}

- (IBAction)addTable:(UIButton *)sender {
    DSZZYGPopTable *table=[[DSZZYGPopTable alloc]init];
    UIPopoverController *pop=[[UIPopoverController alloc]initWithContentViewController:table];
    pop.popoverContentSize=CGSizeMake(100, 100);
    [pop presentPopoverFromRect:CGRectMake(100, 20, 0, 0) inView:sender permittedArrowDirections:UIPopoverArrowDirectionUp animated:NO];
}



- (IBAction)payNow:(id)sender {
    UIButton *btn=sender;
    
    if (btn.tag==1||btn.tag==2) {
        //[MBProgressHUD showError:@"对不起，您订单中含有第三方商家商品，暂不支持货到付款"];
        [MBProgressHUD showError:@"对不起，您订单中含有第三方商家商品，暂不支持货到付款" toView:self];
        
        //[self showalert];
    }
    else{
        btn.titleLabel.textColor=[UIColor yellowColor];
    }
}

-(void)showalert{
//    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"对不起，您订单中含有第三方商家商品，暂不支持货到付款" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
//    //[alert  setTintColor:[UIColor whiteColor]];
//    //[alert setBackgroundColor:[UIColor grayColor]];
//    
//    [alert show];
    
}

-(BOOL) setaddress:(NSDictionary*)dic{
     BOOL haveAddress=NO;
    id i=dic[@"selectaddress"];

    if ([i intValue]==1) {
        self.nameLabel.hidden=NO;
        self.changeBtn.hidden=NO;
        self.lablethingAddress.hidden=NO;
        _nameLabel.text=dic[@"addressname"];
        self.phoneLabel.hidden=NO;
        _phoneLabel.text=dic[@"addressphone"];
        self.addressLabel.hidden=NO;
        _addressLabel.text=dic[@"detailaddress"];
        self.addressAddLabel.hidden=YES;
        self.imageAddress.hidden=YES;
        self.headerfiled.text=dic[@"addressname"];
        haveAddress=YES;
    }else{
        self.changeBtn.hidden=YES;
        self.lablethingAddress.hidden=YES;
        self.nameLabel.hidden=YES;
        self.phoneLabel.hidden=YES;
        self.addressLabel.hidden=YES;
        self.addressAddLabel.hidden=NO;
        self.imageAddress.hidden=NO;
        self.headerfiled.text=@"顾客";
        haveAddress=NO;
    }
    return haveAddress;
}

+(instancetype)loadnib{
    return [[[NSBundle mainBundle]loadNibNamed:@"DSZZYGTableHeader" owner:nil options:nil]lastObject];
}

@end
