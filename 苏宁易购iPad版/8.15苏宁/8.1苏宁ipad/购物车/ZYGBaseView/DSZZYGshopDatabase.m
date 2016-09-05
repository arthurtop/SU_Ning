//
//  DSZZYGshopDatabase.m
//  8.1苏宁ipad
//
//  Created by app15 on 15/8/5.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZZYGshopDatabase.h"

@implementation DSZZYGshopDatabase
-(void)createDatabase{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths objectAtIndex:0];
    database_path = [documents stringByAppendingPathComponent:@"shop.sqlite"];
    sqlite3 *sqlite = nil;
    if (sqlite3_open([database_path UTF8String], &sqlite) != SQLITE_OK) {
        sqlite3_close(sqlite);
        return;
    }
    sqlite3_close(sqlite);
}

-(void)createTable{
    // 1.创建数据库队列
    self.queue = [FMDatabaseQueue databaseQueueWithPath:database_path];
    
    // 2.创表 队列queue对象会自动创建数据库FMDatabase实例 该数据库实例是加过锁的实例 具有线程安全性
    [self.queue inDatabase:^(FMDatabase *db) {
         [db executeUpdate:@"create table if not exists shop_table (thingid text primary key,  storename text, thingimage text , thingtitle text, thingnum text, thingprice text, selectshop integer, selectthing integer,orderselect integer );"];
        
//        if (result) {
//            NSLog(@"创表成功");
//        } else {
//            NSLog(@"创表失败");
//        }
    }];
    
    
}

//插入数据
- (void)insertid :(NSString*)thingsid name :(NSString*) name thingimage:(NSString*) thingimg title:(NSString*) thingtitle thingprice:(NSString*) price
{
    
    [self.queue inDatabase:^(FMDatabase *db) {
        NSString *thingid=thingsid;
        NSString *storename = name;
        NSString *thingimage=thingimg;
        NSString *title = thingtitle;
        NSString *thingprice = price;
        
        [db executeUpdate:@"insert into shop_table (thingid,storename, thingimage,thingtitle,thingnum,thingprice,selectshop,selectthing,orderselect) values (?, ?, ?, ?, ?,?,?,?,?);", thingid,storename,thingimage,title,@"1",thingprice,@(0),@(1),@(0)];
        
    }];
}
//查询所有
- (NSArray*)query
{
    NSMutableArray *array=[NSMutableArray array];
    [self.queue inDatabase:^(FMDatabase *db) {
        // 1.查询数据
        FMResultSet *rs = [db executeQuery:@"select * from shop_table;"];
        
        // 2.遍历结果集
        while (rs.next) {
            NSString *thingid = [rs stringForColumn:@"thingid"];
            NSString *storename = [rs stringForColumn:@"storename"];
            NSString *thingimage=[rs stringForColumn:@"thingimage"];
            NSString *title = [rs stringForColumn:@"thingtitle"];
            int num = [rs intForColumn:@"thingnum"];
            NSString *thingprice = [rs stringForColumn:@"thingprice"];
            int selectshop = [rs intForColumn:@"selectshop"];
            int selectthing = [rs intForColumn:@"selectthing"];
            int orderselect = [rs intForColumn:@"orderselect"];

            NSDictionary *dic=[NSDictionary dictionary];
            dic=@{@"thingid":thingid,@"storename":storename,@"thingimage":thingimage,@"title":title,@"num":@(num),@"thingprice":thingprice,@"selectshop":@(selectshop),@"selectthing":@(selectthing),@"selectaddress":@(orderselect)};
            [array addObject:dic];
        }
    }];
    return array;
}

//查询所有选中的
- (NSArray*)queryselectthing: (int) selectthing
{
    NSMutableArray *array=[NSMutableArray array];
    [self.queue inDatabase:^(FMDatabase *db) {
        
        int selectthings=selectthing;

           FMResultSet *rs= [db executeQuery:@"select * from shop_table where selectthing=?;",@(selectthings)];
    
        // 2.遍历结果集
        while (rs.next) {
            NSString *thingid = [rs stringForColumn:@"thingid"];
            NSString *storename = [rs stringForColumn:@"storename"];
            NSString *thingimage=[rs stringForColumn:@"thingimage"];
            NSString *title = [rs stringForColumn:@"thingtitle"];
            int num = [rs intForColumn:@"thingnum"];
            NSString *thingprice = [rs stringForColumn:@"thingprice"];
            int selectshop = [rs intForColumn:@"selectshop"];
            int selectthing = [rs intForColumn:@"selectthing"];
            int orderselect = [rs intForColumn:@"orderselect"];
            
            NSDictionary *dic=[NSDictionary dictionary];
            dic=@{@"thingid":thingid,@"storename":storename,@"thingimage":thingimage,@"title":title,@"num":@(num),@"thingprice":thingprice,@"selectshop":@(selectshop),@"selectthing":@(selectthing),@"selectaddress":@(orderselect)};
            [array addObject:dic];
        }
    }];
    return array;
}

- (void)delete:(NSString*) thinid
{
    [self.queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        NSString *phone=[NSString stringWithFormat:@"%@",thinid];
        [db executeUpdate:@"delete  from shop_table where thingid = ?;",phone];
        
        //        if (发现情况不对){
        //            // 回滚事务
        //            *rollback = YES;
        //        }
    }];
}

//- (NSArray*)query:(NSString*)phone;
//{
//    NSMutableArray *array=[NSMutableArray array];
//    [self.queue inDatabase:^(FMDatabase *db) {
//        // 1.查询数据
//        FMResultSet *rs = [db executeQuery:@"select * from shop_table where addressphone = ?;",phone];
//        
//        // 2.遍历结果集
//        while (rs.next) {
//            NSString *name = [rs stringForColumn:@"addressname"];
//            
//            NSString *phone=[rs stringForColumn:@"addressphone"];
//            NSString *address = [rs stringForColumn:@"address"];
//            NSString *detailaddress = [rs stringForColumn:@"detailaddress"];
//            int select = [rs intForColumn:@"selectaddress"];
//            NSDictionary *dic=[NSDictionary dictionary];
//            dic=@{@"addressname":name,@"addressphone":phone,@"address":address,@"detailaddress":detailaddress,@"selectaddress":@(select)};
//            [array addObject:dic];
//        }
//    }];
//    return array;
//}


//- (void)delete:(NSString*) sphone
//{
//    [self.queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
//        NSString *phone=sphone;
//        [db executeUpdate:@"delete  from shop_table where addressphone = ?;",phone];
//        
//        //        if (发现情况不对){
//        //            // 回滚事务
//        //            *rollback = YES;
//        //        }
//    }];
//}

- (void)update:(NSString*) thingid selectthing:(int) select
{
    [self  createDatabase];
    [self  createTable];
    [self.queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        NSString *thing=thingid;
        int selectnum=select;
        [db executeUpdate:@"update shop_table set selectthing = ? where thingid = ?;",@(selectnum),thing ];

    }];
}

- (void)update:(NSString*) thingid thingnum:(int) num
{
    [self  createDatabase];
    [self  createTable];
    [self.queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        NSString *thing=thingid;
        int selectnum=num;
        [db executeUpdate:@"update shop_table set thingnum = ? where thingid = ?;",@(selectnum),thing ];
        
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
        [db executeUpdate:@"update shop_table set addressname= ?,address= ?,detailaddress= ?,selectaddress= ?  where addressphone = ?;",name,address,detailaddress,select,phone ];
        
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
        [db executeUpdate:@"update shop_table set selectaddress = ? where addressphone = ?;",@(1),phone ];
        
        //        if (发现情况不对){
        //            // 回滚事务
        //            *rollback = YES;
        //        }
    }];
}
@end
