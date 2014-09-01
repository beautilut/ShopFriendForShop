//
//  CouponObject.m
//  ShopFriendForShop
//
//  Created by Beautilut on 14-7-26.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import "CouponObject.h"
#import "FMDatabase.h"
#import "FMResultSet.h"
@implementation CouponObject
@synthesize couponModel_ID,couponModel_info,couponModel_beginTime,couponModel_endTime,couponModel_name,couponModel_useInfo,couponModel_Image,couponModel_status;
+(BOOL)saveNewCoupon:(CouponObject *)aCoupon
{
    FMDatabase*db=[FMDatabase databaseWithPath:DATABASE_PATH];
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return NO;
    }
    [CouponObject checkTableCreatedInDb:db];
    if (aCoupon.couponModel_beginTime) {
        [aCoupon setCouponModel_beginTime:NULL];
    }
    NSString*insertStr=[NSString stringWithFormat:@"INSERT INTO 'SFCouponObject' ('%@','%@','%@','%@','%@','%@','%@','%@') VALUES(?,?,?,?,?,?,?,?)",sfCouponModelID,sfCouponModelName,sfCouponModelInfo,sfCouponModelBeginTime,sfCouponModelEndTime,sfCouponModelUserInfo,sfCouponModelImage,sfCouponModelStatus];
    BOOL worked=[db executeUpdate:insertStr,aCoupon.couponModel_ID,aCoupon.couponModel_name,aCoupon.couponModel_info,aCoupon.couponModel_beginTime,aCoupon.couponModel_endTime,aCoupon.couponModel_useInfo,aCoupon.couponModel_Image,aCoupon.couponModel_status];
    [db close];
    return worked;
}
+(BOOL)deleteCouponById:(NSString *)couponID
{
    FMDatabase*db=[FMDatabase databaseWithPath:DATABASE_PATH];
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return NO;
    }
    [CouponObject checkTableCreatedInDb:db];
    NSString*queryStr=@"DELETE FROM SFCouponObject WHERE couponModel_ID=?";
    BOOL worked=[db executeUpdate:queryStr,couponID];
    return worked;
}
+(BOOL)updateCoupon:(CouponObject*)aCoupon
{
    FMDatabase*db=[FMDatabase databaseWithPath:DATABASE_PATH];
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return NO;
    }
    [CouponObject checkTableCreatedInDb:db];
    NSString*update=[NSString stringWithFormat:@"UPDATE SFCouponObject SET %@=?,%@=？%@=?,%@=?,%@=? WHERE %@=?",sfCouponModelName,sfCouponModelInfo,sfCouponModelEndTime,sfCouponModelUserInfo,sfCouponModelImage,sfCouponModelID];
    BOOL worked=[db executeUpdate:update,aCoupon.couponModel_name,aCoupon.couponModel_info,aCoupon.couponModel_endTime,aCoupon.couponModel_useInfo,aCoupon.couponModel_Image,aCoupon.couponModel_ID];
    
    if (worked)
    {
        if (aCoupon.couponModel_beginTime!=nil) {
            NSString*changeBeginTime=[NSString stringWithFormat:@"UPDATE SFCouponObject set %@=? WHERE %@=?",sfCouponModelBeginTime,sfCouponModelID];
            BOOL  worked=[db executeUpdate:changeBeginTime,aCoupon.couponModel_beginTime,aCoupon.couponModel_ID];
        }
    }
    return worked;
}
+(BOOL)haveSaveCouponById:(NSString *)couponID
{
    FMDatabase*db=[FMDatabase databaseWithPath:DATABASE_PATH];
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return NO;
    }
    [CouponObject checkTableCreatedInDb:db];
    FMResultSet*rs=[db executeQuery:@"SELECT COUNT(*) FROM SFCouponObject WHERE couponModel_ID=?",couponID];
    while ([rs next]) {
        int count=[rs intForColumnIndex:0];
        if (count!=0) {
            [rs close];
            return YES;
        }else
        {
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
    NSDictionary*dic=[NSDictionary dictionaryWithObjectsAndKeys:couponModel_ID,sfCouponModelID,couponModel_name,sfCouponModelName,couponModel_info,sfCouponModelInfo,couponModel_beginTime,sfCouponModelBeginTime,couponModel_endTime,sfCouponModelEndTime,couponModel_useInfo,sfCouponModelUserInfo,couponModel_Image,sfCouponModelImage, nil];
    return dic;
}
+(CouponObject*)couponFromDictionary:(NSDictionary *)aDic
{
    CouponObject*aCoupon=[[CouponObject alloc] init];
    [aCoupon setCouponModel_ID:[aDic objectForKey:sfCouponModelID]];
    [aCoupon setCouponModel_name:[aDic objectForKey:sfCouponModelName]];
    [aCoupon setCouponModel_info:[aDic objectForKey:sfCouponModelInfo]];
    [aCoupon setCouponModel_beginTime:[aDic objectForKey:sfCouponModelBeginTime]];
    [aCoupon setCouponModel_endTime:[aDic objectForKey:sfCouponModelEndTime]];
    [aCoupon setCouponModel_useInfo:[aDic objectForKey:sfCouponModelUserInfo]];
    [aCoupon setCouponModel_Image:[aDic objectForKey:sfCouponModelImage]];
    return  aCoupon;
}
+(BOOL)checkTableCreatedInDb:(FMDatabase*)db
{
    NSString*createStr=[NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS 'SFCouponObject' ('%@' VARCHAR PRIMARY KEY,'%@' VARCHAR,'%@' VARCHAR,'%@' DATETIME,'%@' DATETIME,'%@' VARCHAR,'%@'VARCHAR,'%@' INT)",sfCouponModelID,sfCouponModelName,sfCouponModelInfo,sfCouponModelBeginTime,sfCouponModelEndTime,sfCouponModelUserInfo,sfCouponModelImage,sfCouponModelStatus];
    BOOL worked=[db executeUpdate:createStr];
    FMDBQuickCheck(worked);
    return worked;
}
@end
