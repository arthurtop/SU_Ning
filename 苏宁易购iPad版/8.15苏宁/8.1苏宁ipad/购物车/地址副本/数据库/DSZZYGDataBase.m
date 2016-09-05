//
//  DSZZYGDataBase.m
//  8.1苏宁ipad
//
//  Created by app15 on 15/8/4.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZZYGDataBase.h"

@implementation DSZZYGDataBase
-(void)createDatabase{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths objectAtIndex:0];
    database_path = [documents stringByAppendingPathComponent:@"addresszyg.sqlite"];

    sqlite3 *sqlite = nil;
    if (sqlite3_open([database_path UTF8String], &sqlite) != SQLITE_OK) {
        sqlite3_close(sqlite);
        return;
    }
}

-(void)createTable{
    // 1.创建数据库队列
    self.queue = [FMDatabaseQueue databaseQueueWithPath:database_path];
    
    // 2.创表 队列queue对象会自动创建数据库FMDatabase实例 该数据库实例是加过锁的实例 具有线程安全性
    [self.queue inDatabase:^(FMDatabase *db) {
        BOOL result = [db executeUpdate:@"create table if not exists Addresszyg_table (  addressname text, addressphone text primary key,address text,detailaddress text,selectaddress integer);"];
        
        if (result) {

        } else {

        }
    }];

    
}

- (void)insertname :(NSString*) sname phone:(NSString*) sphone address:(NSString*) saddress detailaddress:(NSString*) sdetailaddress
             select:(NSNumber*) sselect
{

    [self.queue inDatabase:^(FMDatabase *db) {
        
            NSString *name = sname;
            NSString *phone=sphone;
            NSString *address = saddress;
            NSString *detailaddress = sdetailaddress;
            NSNumber *select = sselect;
           [db executeUpdate:@"insert into Addresszyg_table (addressname, addressphone,address,detailaddress,selectaddress) values (?, ?, ?, ?, ?);", name,phone,address,detailaddress,select];
        
    }];
}

- (NSArray*)query
{
    NSMutableArray *array=[NSMutableArray array];
    [self.queue inDatabase:^(FMDatabase *db) {
        // 1.查询数据
        FMResultSet *rs = [db executeQuery:@"select * from Addresszyg_table;"];
        
        // 2.遍历结果集
        while (rs.next) {
            NSString *name = [rs stringForColumn:@"addressname"];
            
            NSString *phone=[rs stringForColumn:@"addressphone"];
            NSString *address = [rs stringForColumn:@"address"];
            NSString *detailaddress = [rs stringForColumn:@"detailaddress"];
            int select = [rs intForColumn:@"selectaddress"];
            NSDictionary *dic=[NSDictionary dictionary];
            dic=@{@"addressname":name,@"addressphone":phone,@"address":address,@"detailaddress":detailaddress,@"selectaddress":@(select)};
            [array addObject:dic];
        }
    }];
    return array;
}

- (NSArray*)query:(NSString*)phone;
{
    NSMutableArray *array=[NSMutableArray array];
    [self.queue inDatabase:^(FMDatabase *db) {
        // 1.查询数据
        FMResultSet *rs = [db executeQuery:@"select * from Addresszyg_table where addressphone = ?;",phone];
        
        // 2.遍历结果集
        while (rs.next) {
            NSString *name = [rs stringForColumn:@"addressname"];
            
            NSString *phone=[rs stringForColumn:@"addressphone"];
            NSString *address = [rs stringForColumn:@"address"];
            NSString *detailaddress = [rs stringForColumn:@"detailaddress"];
            int select = [rs intForColumn:@"selectaddress"];
            NSDictionary *dic=[NSDictionary dictionary];
            dic=@{@"addressname":name,@"addressphone":phone,@"address":address,@"detailaddress":detailaddress,@"selectaddress":@(select)};
            [array addObject:dic];
        }
    }];
    return array;
}


- (void)delete:(NSString*) sphone
{
    [self.queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        NSString *phone=sphone;
        [db executeUpdate:@"delete  from Addresszyg_table where addressphone = ?;",phone];
        
        //        if (发现情况不对){
        //            // 回滚事务
        //            *rollback = YES;
        //        }
    }];
}

- (void)update:(NSString*) sphone
{
    [self.queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        NSString *phone=sphone;
        [db executeUpdate:@"update Addresszyg_table set selectaddress = ? where addressphone = ?;",@(0),phone ];
        
        //        if (发现情况不对){
        //            // 回滚事务
        //            *rollback = YES;
        //        }
    }];
}

- (void)updateAll:(NSString*) sphone  naem:(NSString*) sname  address:(NSString*) saddress detailaddress:(NSString*) sdetailaddress
           select:(NSNumber*) sselect
{
    [self.queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        NSString *name = sname;
        NSString *phone=sphone;
        NSString *address = saddress;
        NSString *detailaddress = sdetailaddress;
        NSNumber *select = sselect;
        [db executeUpdate:@"update Addresszyg_table set addressname= ?,address= ?,detailaddress= ?,selectaddress= ?  where addressphone = ?;",name,address,detailaddress,select,phone ];
        
        //        if (发现情况不对){
        //            // 回滚事务
        //            *rollback = YES;
        //        }
    }];
}

- (void)select:(NSString*) sphone
{
    [self.queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        NSString *phone=sphone;
        [db executeUpdate:@"update Addresszyg_table set selectaddress = ? where addressphone = ?;",@(1),phone ];
        
        //        if (发现情况不对){
        //            // 回滚事务
        //            *rollback = YES;
        //        }
    }];
}


@end
