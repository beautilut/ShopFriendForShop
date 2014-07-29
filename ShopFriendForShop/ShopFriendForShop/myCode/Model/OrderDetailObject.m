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
@synthesize orderDetailID,goodID,goodNumber,goodPrice;
+(BOOL)saveNewOrderDetial:(OrderDetailObject *)aDetail
{
    FMDatabase*db=[FMDatabase databaseWithPath:DATABASE_PATH];
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return NO;
    }
    [OrderDetailObject checkTableCreatedInDb:db];
    NSString*insertStr=@"INSERT INTO 'SFOrderDetail' ('orderDetail_ID','good_ID','good_number','good_Price') VALUES (?,?,?,?)";
    BOOL worked=[db executeUpdate:insertStr,aDetail.orderDetailID,aDetail.goodID,aDetail.goodNumber,aDetail.goodPrice];
    [db close];
    return  worked;
}
+(BOOL)deleteOrderDetailById:(NSString *)detailID
{
    FMDatabase*db=[FMDatabase databaseWithPath:DATABASE_PATH];
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return NO;
    }
    [OrderDetailObject checkTableCreatedInDb:db];
    NSString*queryStr=@"DELETE FROM SFOrderDetail WHERE orderDetail_ID=?";
    BOOL worked=[db executeUpdate:queryStr,detailID];
    return worked;
}
+(BOOL)updateOrderDetail:(OrderDetailObject *)aDetail
{
    FMDatabase*db=[FMDatabase databaseWithPath:DATABASE_PATH];
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return NO;
    }
    [OrderDetailObject checkTableCreatedInDb:db];
    BOOL worked=[db executeUpdate:@"UPDATE SFOrderDetail SET good_number=? WHERE orderDetail_ID=?",aDetail.goodNumber,aDetail.orderDetailID];
    return worked;
}
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
#pragma mark 
-(NSDictionary*)toDictionary
{
    NSDictionary*dic=[NSDictionary dictionaryWithObjectsAndKeys:orderDetailID,sfOrderDetailID,goodID,sfGoodID,goodNumber,sfGoodNumber,goodPrice,sfGoodPrice, nil];
    return dic;
}
+(OrderDetailObject*)orderFromDictionary:(NSDictionary *)aDic
{
    OrderDetailObject*orderDetail=[[OrderDetailObject alloc] init];
    [orderDetail setOrderDetailID:[aDic objectForKey:sfOrderDetailID]];
    [orderDetail setGoodID:[aDic objectForKey:sfGoodID]];
    [orderDetail setGoodNumber:[aDic objectForKey:sfGoodNumber]];
    [orderDetail  setGoodPrice:[aDic objectForKey:sfGoodPrice]];
    return orderDetail;
}
+(BOOL)checkTableCreatedInDb:(FMDatabase*)db
{
    NSString*createStr=@"CREATE TABLE IF NOT EXISTS 'SFOrderDetail' ('orderDetail_ID' VARCHAR PRIMARY KEY,'good_ID' VARCHAR,'good_number' INT,'good_price' INT)";
    BOOL worked=[db executeUpdate:createStr];
    FMDBQuickCheck(worked);
    return worked;
}
@end
