//
//  DSZZHMYigouquanViewController.m
//  8.1苏宁ipad
//
//  Created by app01 on 15/8/4.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZZHMYigouquanViewController.h"
#import "Common.h"


#define kFilePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"login.data"]



@interface DSZZHMYigouquanViewController ()


@property(copy,nonatomic)NSString *tel;

@end

@implementation DSZZHMYigouquanViewController

-(instancetype)init{
    
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"My" bundle:nil];
    DSZZHMYigouquanViewController *vc = [story instantiateViewControllerWithIdentifier:@"yigou"];
    return vc;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    

    _btn.selected = YES;
    self.selectBtn = _btn;
    self.selectBg1.hidden = YES;
    self.selectBg2.hidden = YES;
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notice:) name:@"loginsuccessed" object:nil];
    //[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(exit) name:@"exit" object:nil]
    
}



-(void)notice:(NSNotification *)notification{
    
}



-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.view insertSubview:_lion atIndex:0];
    [self.view insertSubview:_infoLabel atIndex:0];
    
        //NSLog(@"%@",kFilePath);
        _tel = [NSKeyedUnarchiver unarchiveObjectWithFile:kFilePath];
        

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)btnAction:(UIButton *)sender {
    
    if (sender.tag == 5) {
        self.selectBg.hidden = NO;
        self.selectBg1.hidden = YES;
        self.selectBg2.hidden = YES;
    }else if(sender.tag == 6){
        self.selectBg.hidden = YES;
        self.selectBg1.hidden = NO;
        self.selectBg2.hidden = YES;
    }else{
        self.selectBg.hidden = YES;
        self.selectBg1.hidden = YES;
        self.selectBg2.hidden = NO;
    }
        
    _infoLabel.text = [NSString stringWithFormat:@"你还没有%@",sender.currentTitle];
    
    
    self.selectBtn.selected = NO;
    sender.selected = YES;
    self.selectBtn = sender;
    
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


@end
