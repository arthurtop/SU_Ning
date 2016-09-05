//
//  DSZCQCellphoneRechargeView.m
//  8.1苏宁ipad
//
//  Created by app20 on 15/8/4.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZCQCellphoneRechargeView.h"
#import "Common.h"

@implementation DSZCQCellphoneRechargeView

+ (instancetype)createDSZCQCellphoneRechargeView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"DSZCQCellphoneRechargeView" owner:nil options:nil] lastObject];
}

- (void)awakeFromNib
{
    _numberTextField.delegate = self;
    
    _numberTextFieldText = [NSMutableString string];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.numberTextField];
}

- (IBAction)priceBtns:(UIButton *)sender
{
    if (_numberTextField.text.length < 11) {
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
        hud.mode = MBProgressHUDModeCustomView;
        hud.labelText=@"请输入正确的手机号";
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [hud hide:YES];
            
        });

    }else{
        
        _lastBtn.selected = NO;
        
        sender.selected = YES;
        
        _lastBtn = sender;
        
        
        _price.hidden = YES;
        
        if (sender.tag == 101) {
            
            _shouldPrice = 30;
            _truePrice = 30 * 0.98;
            
            CGFloat x = 30;
            _price.origin = CGPointMake(x, 230);
            
        }else if(sender.tag == 102){
            
            _shouldPrice = 50;
            _truePrice = 50 * 0.98;
            
            CGFloat x = 190;
            _price.origin = CGPointMake(x, 230);
        }else if(sender.tag == 103){
            
            _shouldPrice = 100;
            _truePrice = 100 * 0.98;
            
            CGFloat x = 350;
            _price.origin = CGPointMake(x, 230);
            
        }else if(sender.tag == 104){
            
            _shouldPrice = 200;
            _truePrice = 200 * 0.98;
            
            CGFloat x = 30;
            _price.origin = CGPointMake(x, 335);
            
        }else if(sender.tag == 105){
            
            _shouldPrice = 300;
            _truePrice = 300 * 0.98;
            
            CGFloat x = 190;
            _price.origin = CGPointMake(x, 335);
            
        }else{
            
            _shouldPrice = 500;
            _truePrice = 500 * 0.98;
            
            CGFloat x = 350;
            _price.origin = CGPointMake(x, 335);
            
        }
        
        NSString *priceStr = [NSString stringWithFormat:@"售价:%0.2f元",_truePrice];
        _price.text = priceStr;
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.labelText=@"加载中...";
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [hud hide:YES];
            _price.hidden = NO;
            
        });
    
    }
    
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_numberTextField resignFirstResponder];
    
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}

- (void)textChange
{
    
    if (_numberTextField.text.length == 11) {
        
        
        [_numberTextFieldText setString:@""];
        
        [_numberTextFieldText appendString:_numberTextField.text];
        
        
    }else if (_numberTextField.text.length > 11){
    
        _numberTextField.text = _numberTextFieldText;
    }
}

@end
