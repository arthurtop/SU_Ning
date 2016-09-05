//
//  DSZFYJSaoMiaoViewController.m
//  8.1苏宁ipad
//
//  Created by app05 on 15/8/4.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZFYJSaoMiaoViewController.h"
#import "ZBarSDK.h"
#import "UIViewExt.h"
#define SCANVIEW_EdgeTop 35.0

#define SCANVIEW_EdgeLeft 26.0


#define TINTCOLOR_ALPHA 1.0  //浅色透明度

#define DARKCOLOR_ALPHA 0.5  //深色透明度
@interface DSZFYJSaoMiaoViewController ()<ZBarReaderViewDelegate>

@property(nonatomic,weak)UIView *otherView;

@end

@implementation DSZFYJSaoMiaoViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil

{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        
        // Custom initialization
        
    }
    
    return self;
    
}


- (void)viewDidLoad

{
    
    [super viewDidLoad];
    [self setPreferredContentSize:CGSizeMake(348, 420)];
    
    //NSLog(@"%.f  %.f  %.f  %.f",self.view.width,self.view.height,self.view.origin.x,self.view.origin.y);
    //self.title=@"扫描二维码";
    
    //初始化扫描界面
    
    [self setScanView];
    
    
    
    _readerView= [[ZBarReaderView alloc]init];
    
    _readerView.frame =CGRectMake(13,78, self.view.frame.size.width-26 ,self.view.frame.size.height-78-13);
    _readerView.tracksSymbols=NO;
    
    _readerView.readerDelegate =self;
    
    [_readerView addSubview:_scanView];
    
    //关闭闪光灯
    
    _readerView.torchMode =0;
    
    
    
    [self.view addSubview:_readerView];
    
    
    
    //扫描区域
    
    //readerView.scanCrop =
    
    
    
    [_readerView start];
    
    
    
    [self createTimer];
    
    
}
#pragma mark -- ZBarReaderViewDelegate

-(void)readerView:(ZBarReaderView *)readerView didReadSymbols:(ZBarSymbolSet *)symbols fromImage:(UIImage *)image

{
    
    const zbar_symbol_t *symbol =zbar_symbol_set_first_symbol(symbols.zbarSymbolSet);
    
    NSString *symbolStr = [NSString stringWithUTF8String: zbar_symbol_get_data(symbol)];
    
    
    
    //判断是否包含 头'http:'
    
    NSString *regex =@"http+:[^\\s]*";
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    
    
    UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"" message:symbolStr delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
    
    [alertView show];
    
    
    
    //判断是否包含 头'ssid:'
    
    NSString *ssid =@"ssid+:[^\\s]*";;
    
    NSPredicate *ssidPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",ssid];
    
    
    
    if ([predicate evaluateWithObject:symbolStr]) {
        
        
        
    }
    
    else if([ssidPre evaluateWithObject:symbolStr]){
        
        
        
        NSArray *arr = [symbolStr componentsSeparatedByString:@";"];
        
        
        
        NSArray * arrInfoHead = [[arr objectAtIndex:0]componentsSeparatedByString:@":"];
        
        
        
        NSArray * arrInfoFoot = [[arr objectAtIndex:1]componentsSeparatedByString:@":"];
        
        
        
        
        
       // symbolStr = [NSString stringWithFormat:@"ssid: %@ \n password:%@",[arrInfoHead objectAtIndex:1],[arrInfoFoot objectAtIndex:1]];
        
        
        
        UIPasteboard *pasteboard=[UIPasteboard generalPasteboard];
        
        //然后，可以使用如下代码来把一个字符串放置到剪贴板上：
        
        pasteboard.string = [arrInfoFoot objectAtIndex:1];
        
    }
    
    
    
}



//二维码的扫描区域

- (void)setScanView

{
    
    _scanView=[[UIView alloc] initWithFrame:CGRectMake(0,0, self.view.frame.size.width ,self.view.frame.size.height)];
    
    _scanView.backgroundColor=[UIColor clearColor];
    
    
    
//    //最上部view
//    
//    UIView* upView = [[UIView alloc] initWithFrame:CGRectMake(0,0, 322,40)];
//    
//    
//    upView.alpha =TINTCOLOR_ALPHA;
//    
//    upView.backgroundColor = [UIColor blackColor];
//    
//    [_scanView addSubview:upView];
//    
//    
//    
//    //左侧的view
//    
//    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0,40, 26,self.view.frame.size.width-2*SCANVIEW_EdgeLeft)];
//    
//    leftView.alpha =TINTCOLOR_ALPHA;
//    
//    //[leftView addSubview:uplabel];
//    leftView.backgroundColor = [UIColor yellowColor];
//    
//    [_scanView addSubview:leftView];
    
    
    
    /******************中间扫描区域****************************/
    
    UIImageView *scanCropView=[[UIImageView alloc] initWithFrame:CGRectMake(26 ,35,270,270)];
    
    //scanCropView.image=[UIImage imageNamed:@"camera_focus_rectangle"];
    
    //scanCropView.alpha=0;
    //UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 100, 300, 300)];
    //imageView.image = [UIImage imageNamed:@"camera_focus_rectangle"];
    
    
    scanCropView.layer.borderColor=[UIColor cyanColor].CGColor;
    
    scanCropView.layer.borderWidth=2.0;
    
    
    
    scanCropView.backgroundColor=[UIColor clearColor];
    
    [_scanView addSubview:scanCropView];
    
    
    
    
    
//    //右侧的view
//    
//    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(270+22,25, 26,self.view.frame.size.width-2*SCANVIEW_EdgeLeft)];
//    
//    rightView.alpha =TINTCOLOR_ALPHA;
//    
//    rightView.backgroundColor = [UIColor yellowColor];
//    
//    [_scanView addSubview:rightView];
//    
//    
//    
//    
//    
//    //底部view
//    
//    UIView *downView = [[UIView alloc] initWithFrame:CGRectMake(0,40+270,self.view.frame.size.width, 28)];
//    
//    //downView.alpha = TINTCOLOR_ALPHA;self.view.frame.size.height-40-270
//    
//    downView.backgroundColor = [[UIColor yellowColor] colorWithAlphaComponent:TINTCOLOR_ALPHA];
//    
//    [_scanView addSubview:downView];
    
    
    
    //用于说明的label
    
    UILabel *labIntroudction= [[UILabel alloc] init];
    
    labIntroudction.backgroundColor = [UIColor clearColor];
    
    labIntroudction.frame=CGRectMake(0,5, 322,20);
    
    labIntroudction.numberOfLines=1;
    
    labIntroudction.font=[UIFont systemFontOfSize:15.0];
    
    labIntroudction.textAlignment=NSTextAlignmentCenter;
    
    labIntroudction.textColor=[UIColor whiteColor];
    
    labIntroudction.text=@"将二维码对准方框，即可自动扫描";
    
    [_scanView addSubview:labIntroudction];
    
    
    //画中间的基准线
    
    _QrCodeline = [[UIView alloc] initWithFrame:CGRectMake(SCANVIEW_EdgeLeft,SCANVIEW_EdgeTop, 270,2)];
    
    _QrCodeline.backgroundColor = [UIColor redColor];
    
    [_scanView addSubview:_QrCodeline];
    
}

- (void)openLight

{
    
    if (_readerView.torchMode ==0) {
        
        _readerView.torchMode =1;
        
    }else
        
    {
        
        _readerView.torchMode =0;
        
    }
    
}

- (void)viewWillDisappear:(BOOL)animated

{
    
    [super viewWillDisappear:animated];
    
    
    
    if (_readerView.torchMode ==1) {
        
        _readerView.torchMode =0;
        
    }
    
    [self stopTimer];
    
    
    
    [_readerView stop];
    
    
    
}

//二维码的横线移动

- (void)moveUpAndDownLine

{
    
    CGFloat Y=_QrCodeline.frame.origin.y;
    
    
    if (270+SCANVIEW_EdgeTop==Y){//到达下边缘
        
        
        
        [UIView beginAnimations:@"asa" context:nil];
        
        [UIView setAnimationDuration:1];
        
        _QrCodeline.frame=CGRectMake(SCANVIEW_EdgeLeft, SCANVIEW_EdgeTop, 270,1);
        
        [UIView commitAnimations];
        
    }else if(SCANVIEW_EdgeTop==Y){//到达上边缘
        
        [UIView beginAnimations:@"asa" context:nil];
        
        [UIView setAnimationDuration:1];
        
        _QrCodeline.frame=CGRectMake(SCANVIEW_EdgeLeft, 270+SCANVIEW_EdgeTop, 270,1);
        
        [UIView commitAnimations];
        
    }
    
    
    
}


- (void)createTimer

{
    
    //创建一个时间计数
    
    _timer=[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(moveUpAndDownLine) userInfo:nil repeats:YES];
    
}


- (void)stopTimer

{
    
    if ([_timer isValid] == YES) {
        
        [_timer invalidate];
        
        _timer =nil;
        
    }
    
}


- (void)didReceiveMemoryWarning

{
    
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
    

}

- (IBAction)ligthOpen:(id)sender {
    
    [self openLight];
}

- (IBAction)pushList:(id)sender {
    
    if (self.otherView!=nil) {
        
    }else{
    UIView *bgView=[[UIView alloc]init];
    bgView.backgroundColor=[UIColor whiteColor];
    bgView.frame=CGRectMake(self.view.width, 0, self.view.width, self.view.height);
    [self.view addSubview:bgView];
    self.otherView=bgView;
    
    UIView *topView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 65)];
    topView.backgroundColor=[UIColor clearColor];
    [bgView addSubview:topView];
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(111, 8, 123, 43)];
    label.text=@"扫描纪录";
    label.textColor=[UIColor darkGrayColor];
    label.font=[UIFont systemFontOfSize:21];
    label.textAlignment=NSTextAlignmentCenter;
    [topView addSubview:label];
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(16, 21, 13, 23);
    [button setBackgroundImage:[UIImage imageNamed:@"nav_back_normal.png"]forState:UIControlStateNormal];
    [button addTarget:self action:@selector(navBackBtn) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:button];
    
    UIView *grayView=[[UIView alloc]initWithFrame:CGRectMake(0, 64, self.view.width, 1)];
    [grayView setBackgroundColor:[UIColor lightGrayColor]];
    [topView addSubview:grayView];
        
    UIButton *backBtn=[[UIButton alloc]initWithFrame:CGRectMake(330, 46, 15, 15)];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"btn_delete_orange.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(downCurrentCont) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:backBtn];
    
    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(120, 148, 108, 114)];
    image.image=[UIImage imageNamed:@"Lion_normal.png"];
    [bgView addSubview:image];
    
    UILabel *descLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 267, self.view.width, 21)];
    descLabel.text=@"您还没有扫描纪录哦！";
    descLabel.textColor=[UIColor darkGrayColor];
    descLabel.font=[UIFont systemFontOfSize:16];
    descLabel.textAlignment=NSTextAlignmentCenter;
    [bgView addSubview:descLabel];
    }
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    self.otherView.frame=CGRectMake(0, 0, self.view.width, self.view.height);
    
    [UIView commitAnimations];
    
}

- (IBAction)downPresendView:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)navBackBtn
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    
    self.otherView.frame=CGRectMake(self.view.width, 0, self.view.width, self.view.height);
    
    [UIView commitAnimations];
    
}
-(void)downCurrentCont
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
