//
//  OrderDetailObject.m
//  ShopFriendForShop
//
//  Created by Beautilut on 14-7-22.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import "OrderDetailObject.h"
#import "FMDatabase.h"
#import "FMResultSet.h"
@implementation OrderDetailObject
@synthesize orderID,goodID,goodNumber,goodPrice,goodName;
+(BOOL)saveNewOrderDetial:(OrderDetailObject *)aDetail
{
    FMDatabase*db=[FMDatabase databaseWithPath:DATABASE_PATH];
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return NO;
    }
    [OrderDetailObject checkTableCreatedInDb:db];
    NSString*insertStr=@"INSERT INTO 'SFOrderDetail' ('order_ID','good_ID','good_name','good_number','good_Price') VALUES (?,?,?,?,?)";
    BOOL worked=[db executeUpdate:insertStr,aDetail.orderID,aDetail.goodID,aDetail.goodName,aDetail.goodNumber,aDetail.goodPrice];
    [db close];
    return  worked;
}
//+(BOOL)deleteOrderDetailById:(NSString *)detailID
//{
//    FMDatabase*db=[FMDatabase databaseWithPath:DATABASE_PATH];
//    if (![db open]) {
//        NSLog(@"数据库打开失败");
//        return NO;
//    }
//    [OrderDetailObject checkTableCreatedInDb:db];
//    NSString*queryStr=@"DELETE FROM SFOrderDetail WHERE order_ID=?";
//    BOOL worked=[db executeUpdate:queryStr,detailID];
//    return worked;
//}
//+(BOOL)updateOrderDetail:(OrderDetailObject *)aDetail
//{
//    FMDatabase*db=[FMDatabase databaseWithPath:DATABASE_PATH];
//    if (![db open]) {
//        NSLog(@"数据库打开失败");
//        return NO;
//    }
//    [OrderDetailObject checkTableCreatedInDb:db];
//    BOOL worked=[db executeUpdate:@"UPDATE SFOrderDetail SET good_number=? WHERE order_ID=?",aDetail.goodNumber,aDetail.orderDetailID];
//    return worked;
//}
+(BOOL)haveSaveOrderById:(NSString *)detailID
{
    FMDatabase*db=[FMDatabase databaseWithPath:DATABASE_PATH];
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return NO;
    }
    [OrderDetailObject checkTableCreatedInDb:db];
    FMResultSet*rs=[db executeQuery:@"SELECT COUNT(*) FROM SFOrderDetail WHERE orderDetail_ID=?",detailID];
    while ([rs next]) {
        int count=[rs intForColumnIndex:0];
        if (count!=0) {
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
+(NSArray*)getDetailByID:(NSString *)orderID
{
    NSMutableArray*resultAry=[[NSMutableArray alloc] init];
    FMDatabase*db=[FMDatabase databaseWithPath:DATABASE_PATH];
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return NO;
    }
    [OrderDetailObject checkTableCreatedInDb:db];
    FMResultSet*rs=[db executeQuery:@"select * from SFOrderDetail where order_ID=?",orderID];
    while ([rs next]) {
        OrderDetailObject*aDetail=[[OrderDetailObject alloc] init];
        [aDetail setOrderID:[rs objectForColumnName:sfOrderID]];
        [aDetail setGoodID:[rs objectForColumnName:sfGoodID]];
        [aDetail setGoodName:[rs objectForColumnName:sfGoodName]];
        [aDetail setGoodNumber:[rs objectForColumnName:sfGoodNumber]];
        [aDetail setGoodPrice:[rs objectForColumnName:sfGoodPrice]];
        [resultAry addObject:aDetail];
    }
    return resultAry;
}

#pragma mark 
-(NSDictionary*)toDictionary
{
    NSDictionary*dic=[NSDictionary dictionaryWithObjectsAndKeys:orderID,sfOrderID,goodID,goodName,sfGoodName,sfGoodID,goodNumber,sfGoodNumber,goodPrice,sfGoodPrice, nil];
    return dic;
}
+(OrderDetailObject*)orderFromDictionary:(NSDictionary *)aDic
{
    OrderDetailObject*orderDetail=[[OrderDetailObject alloc] init];
    [orderDetail setOrderID:[aDic objectForKey:sfOrderID]];
    [orderDetail setGoodID:[aDic objectForKey:sfGoodID]];
    [orderDetail setGoodName:[aDic objectForKey:sfGoodName]];
    [orderDetail setGoodNumber:[aDic objectForKey:sfGoodNumber]];
    [orderDetail  setGoodPrice:[aDic objectForKey:sfGoodPrice]];
    return orderDetail;
}
+(BOOL)checkTableCreatedInDb:(FMDatabase*)db
{
    NSString*createStr=@"CREATE TABLE IF NOT EXISTS 'SFOrderDetail' ('order_ID' VARCHAR,'good_ID' VARCHAR,'good_name' VARCHAR ,'good_number' INT,'good_price' INT,PRIMARY KEY ('order_ID','good_ID'))";
    BOOL worked=[db executeUpdate:createStr];
    FMDBQuickCheck(worked);
    return worked;
}
@end
