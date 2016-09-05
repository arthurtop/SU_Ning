//
//  DSZFYJMasterTool.m
//  8.1苏宁ipad
//
//  Created by app05 on 15/8/2.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZFYJMasterTool.h"
#import "DPAPI.h"
#import "DSZFYJTotalModel.h"
#import "NSObject+Value.h"
#import "DSZFYJLocationTool.h"
#import "DSZFYJDataTool.h"
typedef void (^RequestBlock)(id result, NSError *errorObj);

@interface DSZFYJMasterTool() <DPRequestDelegate>
{
    NSMutableDictionary *_blocks;
}
@end

@implementation DSZFYJMasterTool

singleton_implementation(DSZFYJMasterTool)

- (id)init
{
    if (self = [super init]) {
        _blocks = [NSMutableDictionary dictionary];
    }
    return self;
}

#pragma mark 获得大批量团购
- (void)getDealsWithParams:(NSDictionary *)params success:(DealsSuccessBlock)success error:(DealsErrorBlock)error
{
    [self requestWithURL:@"v1/deal/find_deals" params:params block:^(id result, NSError *errorObj) {
        if (errorObj) { // 请求失败
            if (error) {
                error(errorObj);
            }
        } else if (success) { // 请求成功
            NSArray *array = result[@"deals"];
            NSMutableArray *deals = [NSMutableArray array];
            
            for (NSDictionary *dict in array) {
                DSZFYJTotalModel *d = [[DSZFYJTotalModel alloc] init];
                [d setValues:dict];
                [deals addObject:d];
            }
            
            success(deals, [result[@"total_count"] intValue]);
        }
    }];
}

#pragma mark 获得周边的团购
- (void)dealsWithPos:(CLLocationCoordinate2D)pos success:(DealsSuccessBlock)success error:(DealsErrorBlock)error
{
    //NSString *city = [DSZFYJLocationTool sharedDSZFYJLocationTool].city;
    NSString *city=[DSZFYJDataTool sharedDSZFYJDataTool].city;
    //NSLog(@"7636363%@",city);
    if (city == nil) return;
    
    [self getDealsWithParams:
     @{
       @"city" : city,
       @"latitude" : @(pos.latitude),
       @"longitude" : @(pos.longitude),
       @"radius" : @5000,
       @"sort": @7
       }
success:success error:error];
}
#pragma mark 封装了点评的任何请求
- (void)requestWithURL:(NSString *)url params:(NSDictionary *)params block:(RequestBlock)block
{
    DPAPI *api = [DPAPI sharedDPAPI];
    DPRequest *request = [api requestWithURL:url params:params delegate:self];
    
    
    // 一次请求 对应 一个block
    // 不直接用request的原因是：字典的key必须遵守NSCopying协议
    // request.description返回的是一个格式为“<类名：内存地址>”的字符串，能代表唯一的一个request对象
    [_blocks setObject:block forKey:request.description];
    
}

#pragma mark - 大众点评的请求方法代理
- (void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result
{
    // 取出这次request对应的block
    RequestBlock block = _blocks[request.description];
    if (block) {
        block(result, nil);
    }
}

- (void)request:(DPRequest *)request didFailWithError:(NSError *)error
{
    // 取出这次request对应的block
    RequestBlock block = _blocks[request.description];
    if (block) {
        block(nil, error);
    }
}

@end
