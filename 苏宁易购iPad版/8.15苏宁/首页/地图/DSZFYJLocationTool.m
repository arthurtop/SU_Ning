//
//  DSZFYJLocationTool.m
//  8.1苏宁ipad
//
//  Created by app05 on 15/8/2.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZFYJLocationTool.h"
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>
#import "DSZFYJDataTool.h"
#import "DSZFYJDataTool.h"
@interface DSZFYJLocationTool ()<CLLocationManagerDelegate>
{
    CLLocationManager *_mgr;
    CLGeocoder *_geo;
}
@end
@implementation DSZFYJLocationTool

singleton_implementation(DSZFYJLocationTool)

-(id)init
{
    if (self=[super init]) {
        _geo=[[CLGeocoder alloc]init];
        
        _mgr=[[CLLocationManager alloc]init];
        
        _mgr.delegate=self;
        //if ([[[UIDevice currentDevice] systemName] doubleValue]>=8.0) {
            
        [_mgr requestAlwaysAuthorization];//前后台同时定位
        //}
        //NSLog(@"%f",[[[UIDevice currentDevice] systemName] doubleValue]);
        [_mgr startUpdatingLocation];
    }
    return  self;
}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
   
    CLLocation *loc=locations[0];
    //NSLog(@" la--%3.5f  lo--%3.5f",loc.coordinate.latitude,loc.coordinate.longitude);
    
    //坐标位置反编码（坐标--》城市）
    [_geo reverseGeocodeLocation:loc completionHandler:^(NSArray *placemarks,NSError *error)
    {
        CLPlacemark *place=placemarks[0];
        
        NSString *cityName=place.addressDictionary[@"State"];
        NSString *city=[[place locality] substringToIndex:[place locality].length - 1];
        DSZFYJDataTool *data=[[DSZFYJDataTool alloc]init];
        data.city=city;
        
        NSString *name=place.name;
        data.placeName=name;
        NSLog(@"%@",[place name]);
        NSLog(@"%@",cityName);
    }];
    //[self performSelector:@selector(waits) withObject:nil afterDelay:2.0];
    
   
    
}
-(void)waits
{
    [_mgr stopUpdatingLocation];
}
@end


