//
//  TGDealPosAnnotation.h
//  团购
//
//  Created by app43 on 15/7/31.
//  Copyright (c) 2015年 app43. All rights reserved.
//

#import <MapKit/MapKit.h>
@class DSZFYJBusiness,DSZFYJTotalModel;
@interface DSZFYJDealPosAnnotation : NSObject <MKAnnotation>
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, strong) DSZFYJTotalModel *deal; // 显示的哪个团购
@property (nonatomic, strong) DSZFYJBusiness *business; // 显示的是哪个商家

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *subtitle;

@property(nonatomic,copy)NSString *image;

@property(nonatomic,copy)NSString * deal_id;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *desc;

@property(nonatomic,assign)NSInteger count;

//@property (nonatomic, copy) NSString *icon;
@end
