//
//  DSZZYGAddViewController.m
//  8.1苏宁ipad
//
//  Created by app15 on 15/8/4.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZZYGAddViewController.h"
#import "DSZZYGAddressEditView.h"

#import "DSZZYGDataBase.h"

@interface DSZZYGAddViewController ()<DSZZYGAddressEditViewDelegate>
{
    DSZZYGDataBase *base;
    DSZZYGAddressEditView *view;
    BOOL editBool;
    NSArray *array;
}
@end

@implementation DSZZYGAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"编辑地址";
    view.phoneLabel.userInteractionEnabled=YES;
    
    base=[[DSZZYGDataBase alloc]init];
    [base createDatabase];
    [base createTable];
    if (_cellphone==nil) {
        editBool=NO;
    }else{
        array=[NSArray array];
        array=[base query:_cellphone];
        editBool=YES;
    }
    [self loadEdit];
    [self loadnav];
    

    // Do any additional setup after loading the view.
}

-(void)loadnav{
    UIBarButtonItem *left=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"navBack"] landscapeImagePhone:nil style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    left.tintColor=[UIColor blackColor];
    self.navigationItem.leftBarButtonItem=left;
    
    UIBarButtonItem *right=[[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(done)];
    [right setBackgroundImage:[UIImage imageNamed:@"yellow_button_normal1"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    right.tintColor=[UIColor orangeColor];
    self.navigationItem.rightBarButtonItem=right;
}
-(void)back{
    
    [self.navigationController popViewControllerAnimated:NO];
}
-(void)done{
    NSString *saddress=view.picktext.text;
    NSString *sname=view.nameLabel.text;
    NSString *sphone=view.phoneLabel.text;
    NSString *sdetailaddress=view.detailaddressLabel.text;
    NSNumber *sselect;
    if (view.selectSwitch.on) {
       sselect=@(1);
        array=[base query];
        for (NSDictionary *dic in array) {
            NSString *phone=dic[@"addressphone"];
            [base update:phone];
        }
        
    }else{
       sselect=@(0);
        
    }
    if (editBool==NO) {
        [base insertname:sname phone:sphone address:saddress detailaddress:sdetailaddress select:sselect];
    }else{
        [base updateAll:sphone naem:sname address:saddress detailaddress:sdetailaddress select:sselect];
    }
    
    [self.navigationController popViewControllerAnimated:NO];
}



-(void)loadEdit{
    DSZZYGAddressEditView *vi=[DSZZYGAddressEditView loadnib];
    vi.frame=CGRectMake(0, 64, 800, self.view.frame.size.height);
    view=vi;
    view.delegate=self;
    [self.view addSubview:view];
    if (editBool==YES) {
        NSDictionary *dic=array[0];
        view.nameLabel.text=dic[@"addressname"];
        view.phoneLabel.text=_cellphone;
        view.phoneLabel.userInteractionEnabled=NO;
        view.detailaddressLabel.text=dic[@"detailaddress"];
        view.picktext.text=dic[@"address"];
        view.selectSwitch.on=[dic[@"selectaddress"] intValue];
    }
    view.pickview.backgroundColor=[UIColor grayColor];
    
}


-(void)cellphone:(NSString *)sring{
    _cellphone=sring;
}

#pragma mark  代理
-(void)hiddlePick{
    if (view.pickview.hidden==YES) {
        view.pickview.hidden=NO;
        CGRect frame=  view.pickLabelView.frame;
        frame.size.height=view.pickLabelView.frame.size.height+165;
        view.pickLabelView.frame=frame;
        
        CGRect frame1=  view.switchView.frame;
        frame.size.height=view.switchView.frame.size.height+165;
        view.switchView.frame=frame1;
        
        CGRect detail= view.detailaddressLabel.frame;
        detail.origin.y=view.detailaddressLabel.frame.origin.y+165;
        view.detailaddressLabel.frame=detail;
        
        CGRect detail2= view.detailLabel.frame;
        detail2.origin.y=view.detailLabel.frame.origin.y+165;
        view.detailLabel.frame=detail2;
        
        
        
    }else{
        view.pickview.hidden=YES;
        CGRect frame=  view.pickLabelView.frame;
        frame.size.height=view.pickLabelView.frame.size.height-165;
        view.pickLabelView.frame=frame;
        
        CGRect frame1=  view.switchView.frame;
        frame.origin.y=view.switchView.frame.origin.y-165;
        view.switchView.frame=frame1;
        
        CGRect detail= view.detailaddressLabel.frame;
        detail.origin.y=view.detailaddressLabel.frame.origin.y-165;
        view.detailaddressLabel.frame=detail;
       
        CGRect detail2= view.detailLabel.frame;
        detail2.origin.y=view.detailLabel.frame.origin.y-165;
        view.detailLabel.frame=detail2;
        
        
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
