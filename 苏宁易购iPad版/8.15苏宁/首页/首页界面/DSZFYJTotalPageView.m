//
//  DSZFYJTotalPageViewController.m
//  8.1苏宁ipad
//
//  Created by app05 on 15/8/2.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZFYJTotalPageView.h"

#import "DSZFYJHeaderCollectionView.h"
#import "DSZFYJBtnView.h"
#import "UIViewExt.h"
#import "DSZFYJMiddleView.h"
#import "DSZFYJBottomView.h"
#import "DSZFYJMarkerView.h"
#import "DSZFYJYiGouView.h"
#import "DSZFYJFriGo.h"
#import "DSZFYJCuxiaoRoomViewController.h"
@interface DSZFYJTotalPageView ()<FYJBtnDelegate,FYJMiddleDelegata,FYJBottomBtnDelegate,FYJMarkerBtnDelegate,FYJYiGouBtnDelegate,FYJFriGoBtnDelegate,FYJCollectionViewDelegate>

@property(nonatomic,strong)DSZFYJHeaderCollectionView *headerView;
@property(nonatomic,strong)DSZFYJBtnView *btnView;
@property(nonatomic,strong)DSZFYJMiddleView *middleView;
@property(nonatomic,strong)DSZFYJBottomView *bottomView;
@property(nonatomic,strong)DSZFYJMarkerView *MarkerView;
@property(nonatomic,strong)DSZFYJYiGouView *YiGouView;
@property(nonatomic,strong)DSZFYJFriGo *FriGoView;
@end

@implementation DSZFYJTotalPageView

-(void)layoutSubviews
{
    self .backgroundColor=[UIColor clearColor];
    

    
    self.scrollEnabled=YES;
    self.contentSize=CGSizeMake(self.width, 4400);
    
    [self addHeader];
    
    [self addBtn];
    
    [self addMiddle];
    
    [self AddBottomBtn];
    
    [self AddMarkerBtn];
    
    [self AddYiGouBtn];
    
    [self AddFriGoBtn];
}
-(void)addHeader
{
    _headerView =[DSZFYJHeaderCollectionView headerCollection];
    
    _headerView.delegate=self;
    
    _headerView.frame=CGRectMake(0, 0, self.frame.size.width, _headerView.frame.size.height);
    
    [self addSubview: _headerView];
}
-(void)addBtn
{
    DSZFYJBtnView *btn=[DSZFYJBtnView FYJBtnView];
    btn.delegate=self;
    btn.frame=CGRectMake(0, _headerView.bottom, self.width, btn.height);
    _btnView=btn;
    [self addSubview:btn];
}
-(void)addMiddle
{
    DSZFYJMiddleView *middle=[DSZFYJMiddleView FYJMiddleView];
    middle.frame=CGRectMake(0, _btnView.bottom, self.width, middle.height);
    middle.delegate=self;
    _middleView=middle;
    [self addSubview:middle];
}
-(void)AddBottomBtn
{
    DSZFYJBottomView *bottom=[DSZFYJBottomView FYJBottomBtnView];
    bottom.frame=CGRectMake(0, _middleView.bottom, self.width, bottom.height);
    bottom.delegate=self;
    _bottomView=bottom;
    [self addSubview:bottom];
    
}
-(void)AddMarkerBtn
{
    DSZFYJMarkerView *Marker=[DSZFYJMarkerView FYJMarkerView];
    Marker.frame=CGRectMake(0, _bottomView.bottom, self.width, Marker.height);
    Marker.delegate=self;
    _MarkerView=Marker;
    [self addSubview:Marker];
    
}
-(void)AddYiGouBtn
{
    DSZFYJYiGouView *YiGou=[DSZFYJYiGouView FYJYiGouView];
    YiGou.frame=CGRectMake(0, _MarkerView.bottom, self.width, YiGou.height);
    YiGou.delegate=self;
    _YiGouView=YiGou;
    [self addSubview:YiGou];
    
}
-(void)AddFriGoBtn
{
    DSZFYJFriGo *FriGo=[DSZFYJFriGo FYJFriGoView];
    FriGo.frame=CGRectMake(0, _YiGouView.bottom, self.width, FriGo.height);
    FriGo.delegate=self;
    _FriGoView=FriGo;
    [self addSubview:FriGo];
    
}
#pragma mark--代理方法
-(void)clickCollectionViewWithTag:(NSInteger)index
{
    if ([self.delegate respondsToSelector:@selector(FYJdidselectedController)]) {
        [self.delegate FYJdidselectedController];
    }
}
-(void)clickBtnWithSender:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(FYJdidBtnToControllerWithTag:)]) {
        [self.delegate FYJdidBtnToControllerWithTag:sender.tag];
    }

}
-(void)clickMiddleBtnWithSender:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(FYJdidselectedController)]) {
        [self.delegate FYJdidselectedController];
    }
}
-(void)clickBottomBtnWithSender:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(FYJdidselectedController)]) {
        [self.delegate FYJdidselectedController];
    }
}
-(void)clickMarkerBtnWithSender:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(FYJdidselectedController)]) {
        [self.delegate FYJdidselectedController];
    }
}
-(void)clickYiGouBtnWithSender:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(FYJdidselectedController)]) {
        [self.delegate FYJdidselectedController];
    }
}
-(void)clickFriGoBtnWithSender:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(FYJdidselectedController)]) {
        [self.delegate FYJdidselectedController];
    }
}
@end
