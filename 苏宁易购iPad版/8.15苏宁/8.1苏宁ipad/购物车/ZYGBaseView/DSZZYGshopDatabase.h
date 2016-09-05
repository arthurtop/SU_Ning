//
//  DSZZYGshopDatabase.h
//  8.1苏宁ipad
//
//  Created by app15 on 15/8/5.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "FMDB.h"
@interface DSZZYGshopDatabase : NSObject
{
    NSString *database_path;
    
}
@property (nonatomic, strong) FMDatabase *db;

@property (nonatomic, strong) FMDatabaseQueue *queue;
-(void)createDatabase;
-(void)createTable;
- (void)insertid :(NSString*)thingsid name :(NSString*) name thingimage:(NSString*) thingimg title:(NSString*) thingtitle thingprice:(NSString*) price;
- (NSArray*)query;
- (void)update:(NSString*) thingid selectthing:(int) select;//设置是否选中
- (NSArray*)queryselectthing: (int) selectthing;//查询选中
- (void)update:(NSString*) thingid thingnum:(int) num;//查询件数
- (void)delete:(NSString*) thinid;
@end
