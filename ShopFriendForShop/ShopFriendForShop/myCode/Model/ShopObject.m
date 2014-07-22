 //
//  ShopObject.m
//  ShopFriendForShop
//
//  Created by Beautilut on 14-3-11.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import "ShopObject.h"
#import "FMDatabase.h"
#import "FMResultSet.h"
@implementation ShopObject
@synthesize shopID,shopName,shopCategoryWord,shopCategory,shopAddress,shopCategoryDetail,shopTel,shopOpenTime;
+(BOOL)saveNewShop:(ShopObject *)aShop
{
    FMDatabase *db = [FMDatabase databaseWithPath:DATABASE_PATH];
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return NO;
    };
    [ShopObject checkTableCreatedInDb:db];
    NSString*insertStr=@"INSERT INTO 'SFShop' ('shopID','shopName','shopCategory','shopCategoryWord','shopCategoryDetail','shopAddress','shopTel','shopOpenTime') VALUES(?,?,?,?,?,?,?,?)";
    BOOL worked=[db executeUpdate:insertStr,aShop.shopID,aShop.shopName,aShop.shopCategory,aShop.shopCategoryWord,aShop.shopCategoryDetail,aShop.shopAddress,aShop.shopTel,@"0"];

    [db close];
    return worked;
}
+(BOOL)haveSaveShopByID:(NSString *)shopID
{
    FMDatabase *db = [FMDatabase databaseWithPath:DATABASE_PATH];
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return NO;
    };
    [ShopObject checkTableCreatedInDb:db];
    FMResultSet*rs=[db executeQuery:@"SELECT COUNT(*) FROM SFShop WHERE shopID=?",shopID];
    while ([rs next]) {
        int count= [rs intForColumnIndex:0];
        
        if (count!=0){
            [rs close];
            return YES;
        }else
        {
            [rs close];
            return NO;
        }
        
    };
    [rs close];
    return YES;
}
+(BOOL)deleteShopByID:(NSString *)shopID
{
    return NO;
}
+(BOOL)updateShop:(NSString*)column with:(id)data
{
    FMDatabase *db = [FMDatabase databaseWithPath:DATABASE_PATH];
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return NO;
    };
    [ShopObject checkTableCreatedInDb:db];
    NSString*string=[NSString stringWithFormat:@"UPDATE SFShop SET %@ = ? WHERE shopID=?",column];
    NSString*hostID=[[NSUserDefaults standardUserDefaults]objectForKey:kXMPPmyJID];
    BOOL worked=[db executeUpdate:string,data,hostID];
    return worked;
}
+(ShopObject*)fetchShopInfo
{
    ShopObject*shop=[[ShopObject alloc] init];
    FMDatabase *db = [FMDatabase databaseWithPath:DATABASE_PATH];
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return NO;
    };
    [ShopObject checkTableCreatedInDb:db];
    NSString*shopID=[[NSUserDefaults standardUserDefaults]objectForKey:kXMPPmyJID];
    FMResultSet*rs=[db executeQuery:@"SELECT * FROM SFShop WHERE shopID=?",shopID];
    while ([rs next]) {
        [shop setShopID:[rs objectForColumnName:sfShopID]];
        [shop setShopName:[rs objectForColumnName:sfShopName]];
        [shop setShopCategory:[rs objectForColumnName:sfShopCategory]];
        [shop setShopCategoryWord:[rs objectForColumnName:sfShopCategoryWord]];
        [shop setShopCategoryDetail:[rs objectForColumnName:sfShopCategoryDetail]];
        [shop setShopAddress:[rs objectForColumnName:sfShopAddress]];
        [shop setShopTel:[rs objectForColumnName:sfShopTel]];
        [shop setShopOpenTime:[rs objectForColumnName:sfShopOpenTime]];
    }
    return shop;
}
+(ShopObject*)shopFromDictionary:(NSDictionary *)aDic
{
    ShopObject*shop=[[ShopObject alloc] init];
    [shop setShopID:[aDic objectForKey:sfShopID]];
    [shop setShopName:[aDic objectForKey:sfShopName]];
    [shop setShopCategory:[aDic objectForKey:sfShopCategory]];
    [shop setShopCategoryWord:[aDic objectForKey:sfShopCategoryWord]];
    [shop setShopCategoryDetail:[aDic objectForKey:sfShopCategoryDetail]];
    [shop setShopAddress:[aDic objectForKey:sfShopAddress]];
    [shop setShopTel:[aDic objectForKey:sfShopTel]];
    [shop setShopOpenTime:[aDic objectForKey:sfShopOpenTime]];
    return shop;
}
-(NSDictionary*)toDictionary
{
    NSDictionary*dic=[NSDictionary dictionaryWithObjectsAndKeys:shopID,sfShopID,shopName,sfShopName,shopCategory,sfShopCategory,shopCategoryWord,sfShopCategoryWord,shopCategoryDetail,sfShopCategoryDetail,shopAddress,sfShopAddress,shopTel,sfShopTel,shopOpenTime,sfShopOpenTime, nil];
    return dic;
}
+(BOOL)checkTableCreatedInDb:(FMDatabase*)db
{
    NSString *createStr=@"CREATE TABLE IF NOT EXISTS 'SFShop' ('shopID' VARCHAR PRIMARY KEY NOT NULL UNIQUE,'shopName' VARCHAR,'shopCategory' VARCHAR,'shopCategoryWord' VARCHAR,'shopCategoryDetail' VARCHAR,'shopAddress' VARCHAR,'shopTel' VARCHAR,'shopOpenTime' VARCHAR)";
    
    BOOL worked = [db executeUpdate:createStr];
    FMDBQuickCheck(worked);
    return worked;
}
@end
