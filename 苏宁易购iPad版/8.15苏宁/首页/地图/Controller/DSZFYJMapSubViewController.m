//
//  DSZFYJMapSubViewController.m
//  8.1苏宁ipad
//
//  Created by app05 on 15/8/6.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZFYJMapSubViewController.h"
#import "DSZFYJDealPosAnnotation.h"
#import "DSZFYJMapSubImgView.h"
#import "DSZFYJDealPosAnnotation.h"
#import "DSZFYJBusiness.h"
#import "DSZFYJTotalModel.h"
#import "NSObject+Value.h"
@interface DSZFYJMapSubViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property(nonatomic,strong)DSZFYJMapSubImgView *sub;
- (IBAction)mapBtn:(id)sender;
- (IBAction)backBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *detailView;
//@property (weak, nonatomic) IBOutlet UIButton *detailBtn;
@property(nonatomic,weak)UITableView *tableView;

@end

@implementation DSZFYJMapSubViewController
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self .sub=[[DSZFYJMapSubImgView alloc]init];
    _sub=[DSZFYJMapSubImgView FYJMapSubImg];
    _sub.frame=CGRectMake(20, 8, 150, 150);
    [self.view addSubview:_sub];
    self.titleLabel.text=_anno.title;
    self.descLabel.text=_anno.desc;
    _sub.imageString=_anno.image;
    
    [self.view bringSubviewToFront:self.detailView];

}
- (void)setBusiness:(NSArray *)business{}
-(void)setAnno:(DSZFYJDealPosAnnotation *)anno
{
    _anno=anno;
}

- (IBAction)mapBtn:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(clickFYJMapSubBtnWithSender:)]) {
        [self.delegate clickFYJMapSubBtnWithSender:sender];
    }
}
-(void)viewWillDisappear:(BOOL)animated
{
    if (self.view.window==nil) {
        self.view=nil;
    }
}

@end
