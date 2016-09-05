//
//  DSZFYJSaoMiaoViewController.h
//  8.1苏宁ipad
//
//  Created by app05 on 15/8/4.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBarSDK.h"
@interface DSZFYJSaoMiaoViewController : UIViewController

{
    
    UIView *_QrCodeline;
    
    NSTimer *_timer;
    
    
    
    //设置扫描画面
    
    UIView *_scanView;
    
    ZBarReaderView *_readerView;
    
}
- (IBAction)ligthOpen:(id)sender;

- (IBAction)pushList:(id)sender;

- (IBAction)downPresendView:(id)sender;

@end
