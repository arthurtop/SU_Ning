//
//  DSZFYJMapViewController.m
//  8.1苏宁ipad
//
//  Created by app05 on 15/8/2.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZFYJMapViewController.h"
#import "DSZFYJNavView.h"
#import <QuartzCore/QuartzCore.h>
#import <MapKit/MapKit.h>
#import "DSZFYJMasterTool.h"
#import "DSZFYJBusiness.h"
#import "DSZFYJTotalModel.h"
#import "DSZFYJDealPosAnnotation.h"
#import "DSZFYJMapSubViewController.h"
#import "DSZDACXQController.h"
#define kSpan MKCoordinateSpanMake(0.018404, 0.031468)

@interface DSZFYJMapViewController ()<DSZFYJNavViewDelegate,MKMapViewDelegate,UIPopoverControllerDelegate,FYJMapSubDelegate>
{
    MKMapView *_mapView;
    
    NSMutableArray *_showingDeals;
    
    NSString* dealid;
    
    UIPopoverController *_popver;
}
@end

@implementation DSZFYJMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
    [self addNav];
    
    [self addMapView];
}
//加载自定义导航栏
-(void)addNav
{
    DSZFYJNavView *nav=[DSZFYJNavView createNavView];
    nav.frame=CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height-20);
    //nav.titleLabelText=@"地图";
    nav.delegate=self;
    [self.view addSubview:nav];
}
//添加地图视图
-(void)addMapView
{
    MKMapView *MyMapView=[[MKMapView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];
    
    [self.view addSubview:MyMapView];
    
    MyMapView .userInteractionEnabled=YES;
    
    MyMapView.delegate=self;
    
    MyMapView.showsUserLocation=YES;
    
    _showingDeals=[NSMutableArray array];
    //添加回到用户位置按钮
    UIButton *backUserBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *image=[UIImage imageNamed:@"btn_map_locate.png"];
    
    [backUserBtn setBackgroundImage:image forState:UIControlStateNormal];
    
    [backUserBtn setBackgroundImage:[UIImage imageNamed:@"btn_map_locate_hl.png"] forState:UIControlStateHighlighted];
    
    CGFloat w=image.size.width;
    CGFloat h=image.size.height;
    
    CGFloat margin = 20;
    CGFloat x = self.view.frame.size.width - w - margin;
    
    CGFloat y = self.view.frame.size.height - h - margin;
    backUserBtn.frame = CGRectMake(x, y, w, h);
    
    [backUserBtn addTarget:self action:@selector(backUserClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backUserBtn];
}
#pragma mark--mapView代理
#pragma mark--当定位到用户的位置就会调用
-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    if (_mapView) {
        return;
    }
    //位置，中心点
    CLLocationCoordinate2D center=userLocation.location.coordinate;
    
    //跨度
    MKCoordinateRegion region=MKCoordinateRegionMake(center, kSpan);
    
    //区域
    [mapView setRegion:region animated:YES];
    
    _mapView=mapView;
    
    
}
//响应协议
-(void)didclickNavBtn:(UIButton *)btn
{
    if ((btn.tag=104)) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}
#pragma mark--拖动地图就会调用
-(void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    //地图当前展示区域的中心位置
    CLLocationCoordinate2D center=mapView.region.center;
    
    
    [[DSZFYJMasterTool sharedDSZFYJMasterTool] dealsWithPos:center success:^(NSArray *deals,int totalCount)
     {
         
         for (DSZFYJTotalModel *d in deals) {
            
             if ([_showingDeals containsObject:d]) {
                 continue;
             }
             [_showingDeals addObject:d];
             
             for (DSZFYJBusiness *b in d.businesses){
                 DSZFYJDealPosAnnotation *anno=[[DSZFYJDealPosAnnotation alloc]init];
                 anno.business=b;
                 anno.deal=d;
                 
                 anno.title=b.name;
                 anno.subtitle=b.city;
                 anno.title=d.title;
                 anno.desc=d.desc;
                 anno.deal_id=d.deal_id;
                 anno.image=d.image_url;
                 //sub.business=d;

                 anno.coordinate=CLLocationCoordinate2DMake(b.latitude, b.longitude);
                 [mapView addAnnotation:anno];
             }
         }
    }
                                                      error:nil];
}
//优化指针视图
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{

    if (![annotation isKindOfClass:[DSZFYJDealPosAnnotation class]]) {
        return nil;
    }
    static NSString *ID=@"MKAnnotationView";
    
    MKAnnotationView *annoView=[mapView dequeueReusableAnnotationViewWithIdentifier:ID];
    
    if (annoView==nil) {
        annoView=[[MKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:ID];
    }
    
    //设置是否显示标题视图
    //annoView.canShowCallout = YES;
    
//    annoView.calloutOffset=CGPointMake(0, 1);//定义详情视图偏移量
//    
//    UIImageView *image=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_center_point.png"]];
//    annoView.leftCalloutAccessoryView=image;
//    
//    for (UIView *view in [annoView subviews]) {
//        [view removeFromSuperview];
//    }
//    
//    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
//    [button setBackgroundImage:[UIImage imageNamed:@"gift_bind_right_btn.png"] forState:UIControlStateNormal];
//    button.frame=CGRectMake(0, 0, 10, 20);
//    [button addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
//    
//    annoView.rightCalloutAccessoryView=button;
//    
//    annoView.annotation=annotation;
    
    annoView.image=[UIImage imageNamed:@"suning_button_map_default.png"];
    
    return annoView;
}
#pragma mark 点击了大头针
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
//    // 1.展示详情
    DSZFYJDealPosAnnotation *anno = view.annotation;
   
    dealid=anno.deal_id;
    
    DSZFYJMapSubViewController *map=[[DSZFYJMapSubViewController alloc]init];
    map.delegate=self;
    map.anno=anno;
    map.business=anno.deal.businesses;
    _popver=[[UIPopoverController alloc]initWithContentViewController:map];
    _popver.popoverContentSize=CGSizeMake(190, 267);
    _popver.delegate=self;
    [_popver presentPopoverFromRect:view.bounds inView:view permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
    
//    // 2.让选中的大头针居中
    //[mapView setCenterCoordinate:anno.coordinate animated:YES];
//    
    // 3.让view周边产生一些阴影效果
    view.layer.shadowColor = [UIColor redColor].CGColor;
    view.layer.shadowOpacity = 1;
    view.layer.shadowRadius = 10;
    
    
}
-(void)clickFYJMapSubBtnWithSender:(UIButton *)sender
{
    if (sender.tag==0) {
        [self clickBtn];
    }
//    else
//    {
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"FYJPushTheDetailView" object:nil];
//    }
}
-(void)clickBtn
{
    [_popver dismissPopoverAnimated:YES];
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"DSZDACXQController" bundle:nil];
    DSZDACXQController *con = [story instantiateViewControllerWithIdentifier:@"XQ"];
    con.dealid = dealid;
    [self.navigationController pushViewController:con animated:YES];
}
//回到用户位置
- (void)backUserClick
{
    CLLocationCoordinate2D center=_mapView.userLocation.location.coordinate;
    
    MKCoordinateRegion region=MKCoordinateRegionMake(center, kSpan);
    
    [_mapView setRegion:region animated:YES];
}
@end
