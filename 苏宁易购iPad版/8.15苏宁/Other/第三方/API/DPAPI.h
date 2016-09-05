//
//  DPAPI.h
//  apidemo
//
//  Created by ZhouHui on 13-1-28.
//  Copyright (c) 2013年 Dianping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DPRequest.h"
#import "Singleton.h"
#define kDPAppKey             @"7796545823"
#define kDPAppSecret          @"c6b31d72a7674825ab462ea6d8471748"

#ifndef kDPAppKey
#error
#endif

#ifndef kDPAppSecret
#error
#endif

@interface DPAPI : NSObject
singleton_interface(DPAPI)

- (DPRequest*)requestWithURL:(NSString *)url
					  params:(NSDictionary *)params
					delegate:(id<DPRequestDelegate>)delegate;

- (DPRequest *)requestWithURL:(NSString *)url
				 paramsString:(NSString *)paramsString
					 delegate:(id<DPRequestDelegate>)delegate;

@end
