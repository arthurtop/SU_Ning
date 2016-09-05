//
//  DSZZYGAddressCell.m
//  8.1苏宁ipad
//
//  Created by app15 on 15/8/5.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZZYGAddressCell.h"
#import "DSZZYGDataBase.h"
@implementation DSZZYGAddressCell

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
        self=[[[NSBundle mainBundle]loadNibNamed:@"DSZZYGAddressCell" owner:nil options:nil]lastObject];
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
        longPress.minimumPressDuration = 2;//最小长按时间
        [self addGestureRecognizer:longPress];
    }
    return  self;
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
        base=[[DSZZYGDataBase alloc]init];
        [base createDatabase];
        [base createTable];
        [base delete:self.phoneLabel.text];
        [self.delegate loadTable];
    }
    
}

- (IBAction)selectAction:(UIButton *)sender {
    base=[[DSZZYGDataBase alloc]init];
    [base createDatabase];
    [base createTable];
    NSArray *array=[base query];
    for (NSDictionary *dic in array) {
        NSString *phone=dic[@"addressphone"];
        [base update:phone];
    }
    [base select:self.phoneLabel.text];
    [self.delegate loadTable];
}

- (IBAction)EditAddress:(UIButton *)sender {
    [self.delegate pushEdit:self.phoneLabel.text];
    
}

-(void)setcell:(NSDictionary*)dict{
    self.peoplename.text=dict[@"addressname"];
    self.phoneLabel.text=dict[@"addressphone"];
    self.addresslabel.text=dict[@"detailaddress"];
    id i=dict[@"selectaddress"];
    if ([i intValue]==1) {
        
        self.addressselectBtn.selected=YES;
    }else{
        self.addressselectBtn.selected=NO;
    }
    [self.delegate loadTable];
}

@end
