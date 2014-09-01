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
@synthesize orderID,orderCreateTime,serverID,shopID,userID,shopName,userName,userLocation,orderStatus,serverName,serverKind,serverSpend,orderTotalPrice;

+(BOOL)saveNewOrder:(OrderObject *)aOrder
{
    FMDatabase*db=[FMDatabase databaseWithPath:DATABASE_PATH];
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return NO;
    }
    [OrderObject checkTableCreatedInDb:db];
    NSString*insertStr=@"INSERT INTO 'SFOrder' ('order_ID','order_createtime','user_ID','user_name','user_location','shop_ID','shop_name','order_status','server_ID','server_name','server_kind','server_spend','order_total_price') VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?)";
    BOOL worked=[db executeUpdate:insertStr,aOrder.orderID,aOrder.orderCreateTime,aOrder.userID,aOrder.userName,aOrder.userLocation,aOrder.shopID,aOrder.shopName,aOrder.orderStatus,aOrder.serverID,aOrder.serverName,aOrder.serverKind,aOrder.serverSpend,aOrder.orderTotalPrice];
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
+(NSArray*)showOrders:(NSString *)shopID
{
    NSMutableArray*resultArr=[[NSMutableArray alloc]init];
    FMDatabase*db=[FMDatabase databaseWithPath:DATABASE_PATH];
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return NO;
    }
    [OrderObject checkTableCreatedInDb:db];
    FMResultSet*rs=[db executeQuery:@"SELECT * FROM SFOrder WHERE shop_ID=?",shopID];
    while ([rs next]) {
        OrderObject *order=[[OrderObject alloc] init];
        [order setOrderID:[rs objectForColumnName:sfOrderID]];
        [order setOrderCreateTime:[rs objectForColumnName:sfOrdercreatetime]];
        [order setUserID:[rs objectForColumnName:sfUserID]];
        [order setUserName:[rs objectForColumnName:sfUserName]];
        [order setUserLocation:[rs objectForColumnName:sfUserLocation]];
        [order setShopID:[rs objectForColumnName:sfShopID]];
        [order setShopName:[rs objectForColumnName:sfShopName]];
        [order setOrderStatus:[rs objectForColumnName:sfOrderStatus]];
        [order setServerID:[rs objectForColumnName:sfServerID]];
        [order setServerName:[rs objectForColumnName:sfServername]];
        [order setServerKind:[rs objectForColumnName:sfServerkind ]];
        [order setServerSpend:[rs objectForColumnName:sfServerSpend]];
        [order setOrderTotalPrice:[rs objectForColumnName:sfOrderTotalPrice]];
        [resultArr addObject:order];
    }
    [db close];
    return resultArr;
}
#pragma mark
+(OrderObject*)orderFromDictionary:(NSDictionary *)aDic
{
    OrderObject*order=[[OrderObject alloc] init];
    [order setOrderID:[aDic objectForKey:sfOrderID]];
    [order setOrderCreateTime:[aDic objectForKey:sfOrdercreatetime]];
    [order setUserID:[aDic objectForKey:sfUserID]];
    [order setUserName:[aDic objectForKey:sfUserName]];
    [order setUserLocation:[aDic objectForKey:sfUserLocation]];
    [order setShopID:[aDic objectForKey:sfShopID]];
    [order setShopName:[aDic objectForKey:sfShopName]];
    [order setOrderStatus:[aDic objectForKey:sfOrderStatus]];
    [order setServerID:[aDic objectForKey:sfServerID]];
    [order setServerName:[aDic objectForKey:sfServername]];
    [order setServerKind:[aDic objectForKey:sfServerkind]];
    [order setServerSpend:[aDic objectForKey:sfServerSpend]];
    [order setOrderTotalPrice:[aDic objectForKey:sfOrderTotalPrice]];
    return  order;
}
//-(NSDictionary*)toDictionary
//{
//    NSDictionary*dic=[NSDictionary dictionaryWithObjectsAndKeys:orderID,sfOrderID,orderCreateTime,sfOrdercreatetime,serverID,sfServerID,userID,sfUserID,shopID,sfShopID,orderStatus,sfOrderStatus, nil];
//    return dic;
//}
+(BOOL)checkTableCreatedInDb:(FMDatabase*)db
{
    NSString*createStr=@"CREATE TABLE IF NOT EXISTS 'SFOrder' ('order_ID' VARCHAR PRIMARY KEY,'order_createtime' DATETIME,'user_ID' VARCHAR,'user_name' VARCHAR,'user_location' VARCHAR,'shop_ID' VARCHAR,'shop_name' VARCHAR,'order_status' INT,'server_ID' VARCHAR,'server_name' VARCHAR,'server_kind' INT,'server_spend' FLOAT,'order_total_price' FLOAT)";
    BOOL worked = [db executeUpdate:createStr];
    FMDBQuickCheck(worked);
    return worked;
}
@end
