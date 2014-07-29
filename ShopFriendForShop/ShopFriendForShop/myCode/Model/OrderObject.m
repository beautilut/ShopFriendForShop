//
//  OrderObject.m
//  ShopFriendForShop
//
//  Created by Beautilut on 14-7-22.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import "OrderObject.h"
#import "FMDatabase.h"
#import "FMResultSet.h"

@implementation OrderObject
@synthesize orderID,orderCreateTime,serverID,shopID,userID,orderStatus;

+(BOOL)saveNewOrder:(OrderObject *)aOrder
{
    FMDatabase*db=[FMDatabase databaseWithPath:DATABASE_PATH];
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return NO;
    }
    [OrderObject checkTableCreatedInDb:db];
    NSString*insertStr=@"INSERT INTO 'SFOrder' ('order_ID','order_createtime','server_ID','user_ID','shop_ID','order_status') VALUES(?,?,?,?,?,?)";
    BOOL worked=[db executeUpdate:insertStr,aOrder.orderID,aOrder.orderCreateTime,aOrder.serverID,aOrder.userID,aOrder.shopID,aOrder.orderStatus];
    [db close];
    return  worked;
}
+(BOOL)deleteOrderById:(NSString *)orderID
{
    FMDatabase*db=[FMDatabase databaseWithPath:DATABASE_PATH];
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return NO;
    }
    [OrderObject checkTableCreatedInDb:db];
    NSString*queryStr=@"DELETE FROM SFOrder WHERE order_ID=?";
    BOOL worked=[db executeUpdate:queryStr,orderID];
    [db close];
    return worked;
}
+(BOOL)updateOrder:(OrderObject *)aOrder
{
    FMDatabase *db = [FMDatabase databaseWithPath:DATABASE_PATH];
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return NO;
    };
    [OrderObject checkTableCreatedInDb:db];
    BOOL worked=[db executeUpdate:@"UPDATE SFOrder SET order_status=? WHERE order_ID=?",aOrder.orderStatus,aOrder.orderID];
    return worked;
}
+(BOOL)haveSaveOrderById:(NSString *)orderID
{
    FMDatabase*db=[FMDatabase databaseWithPath:DATABASE_PATH];
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return NO;
    }
    [OrderObject checkTableCreatedInDb:db];
    FMResultSet*rs=[db executeQuery:@"SELECT COUNT(*) FROM SFOrder WHERE order_ID=?",orderID];
    while ([rs next]) {
        int count=[rs intForColumnIndex:0];
        if (count!=0)
        {
            [rs close];
            return YES;
        }else{
            [rs close];
            return NO;
        }
    }
    [rs close];
    return NO;
}
#pragma mark
+(OrderObject*)orderFromDictionary:(NSDictionary *)aDic
{
    OrderObject*order=[[OrderObject alloc] init];
    [order setOrderID:[aDic objectForKey:sfOrderID]];
    [order setOrderCreateTime:[aDic objectForKey:sfOrdercreatetime]];
    [order setServerID:[aDic objectForKey:sfServerID]];
    [order setUserID:[aDic objectForKey:sfUserID]];
    [order setShopID:[aDic objectForKey:sfShopID]];
    [order setOrderStatus:[aDic objectForKey:sfOrderStatus]];
    return  order;
}
-(NSDictionary*)toDictionary
{
    NSDictionary*dic=[NSDictionary dictionaryWithObjectsAndKeys:orderID,sfOrderID,orderCreateTime,sfOrdercreatetime,serverID,sfServerID,userID,sfUserID,shopID,sfShopID,orderStatus,sfOrderStatus, nil];
    return dic;
}
+(BOOL)checkTableCreatedInDb:(FMDatabase*)db
{
    NSString*createStr=@"CREATE TABLE IF NOT EXISTS 'SFOrder' ('order_ID' VARCHAR PRIMARY KEY,'order_createtime' DATETIME,'server_ID' VARCHAR,'user_ID' VARCHAR,'shop_ID' VARCHAR,'order_status' INT)";
    BOOL worked = [db executeUpdate:createStr];
    FMDBQuickCheck(worked);
    return worked;
}
@end
