//
//  DSZZYGDataBase.h
//  8.1苏宁ipad
//
//  Created by app15 on 15/8/4.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "FMDB.h"
@interface DSZZYGDataBase : NSObject
{
    NSString *database_path;
    
}
@property (nonatomic, strong) FMDatabase *db;

@property (nonatomic, strong) FMDatabaseQueue *queue;
-(void)createDatabase;
-(void)createTable;
- (void)insertname :(NSString*) sname phone:(NSString*) sphone address:(NSString*) saddress detailaddress:(NSString*) sdetailaddress
             select:(NSNumber*) sselect;
- (NSArray*)query;
- (NSArray*)query:(NSString*)phone;//查询phone
- (void)delete:(NSString*) sphone;
- (void)updateAll:(NSString*) sphone  naem:(NSString*) sname  address:(NSString*) saddress detailaddress:(NSString*) sdetailaddress
           select:(NSNumber*) sselect;
- (void)update:(NSString*) sphone;//所有都不是默认
- (void)select:(NSString*) sphone;//  1

@end
