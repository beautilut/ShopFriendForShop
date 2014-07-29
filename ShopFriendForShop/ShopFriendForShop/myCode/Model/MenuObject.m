//
//  MenuObject.m
//  ShopFriendForShop
//
//  Created by Beautilut on 14-3-11.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import "MenuObject.h"
#import "FMDatabase.h"
#import "FMResultSet.h"
#import <CommonCrypto/CommonDigest.h>
@implementation MenuObject
@synthesize categoryID,goodID,goodName,goodPrice,goodPhotoCount,goodInfo,goodOnSale,goodRank;

+(BOOL)saveNewGood:(MenuObject *)aMenu
{
    FMDatabase *db = [FMDatabase databaseWithPath:DATABASE_PATH];
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return NO;
    };
    [MenuObject checkTableCreatedInDb:db];
    
    NSString*insertStr=@"INSERT INTO 'SFMenu'('good_ID','menu_categoryID','good_name','good_price','good_photo_count','good_info','good_onSale','good_rank') VALUES (?,?,?,?,?,?,?,?)";
    BOOL worked=[db executeUpdate:insertStr,aMenu.goodID,aMenu.categoryID,aMenu.goodName,aMenu.goodPrice,aMenu.goodPhotoCount,aMenu.goodInfo,aMenu.goodOnSale,aMenu.goodRank];
    [db close];
    return  worked;
}
+(BOOL)haveSaveGoodById:(NSString *)goodID
{
    FMDatabase *db = [FMDatabase databaseWithPath:DATABASE_PATH];
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return NO;
    };
    [MenuObject checkTableCreatedInDb:db];
    FMResultSet*rs=[db executeQuery:@"SELECT COUNT(*) FROM SFMenu WHERE good_ID=?",goodID];
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
        
    }
    [rs close];
    return YES;
}
+(BOOL)deleteGoodById:(NSString*)goodID
{
    FMDatabase *db = [FMDatabase databaseWithPath:DATABASE_PATH];
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return NO;
    };
    [MenuObject checkTableCreatedInDb:db];
    NSString*queryStr=@"DELETE FROM SFMenu WHERE good_ID=?";
    BOOL worked=[db executeUpdate:queryStr,goodID];
    [db close];
    return worked;
}
+(BOOL)updateGood:(MenuObject *)newGood
{
    FMDatabase *db = [FMDatabase databaseWithPath:DATABASE_PATH];
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return NO;
    };
    [MenuObject checkTableCreatedInDb:db];
    BOOL worked=[db executeUpdate:@"UPDATE SFMenu SET good_name=?,good_price=?,good_photo_count=?,good_info=? WHERE good_ID=?",newGood.goodName,newGood.goodPrice,newGood.goodPhotoCount,newGood.goodInfo,newGood.goodID];
    return worked;
}
+(void)updategoodRank:(NSMutableArray *)menuArray
{
    FMDatabase*db=[FMDatabase databaseWithPath:DATABASE_PATH];
    if (![db open]) {
        NSLog(@"数据库打开失败");
    };
    [MenuObject checkTableCreatedInDb:db];
    for (int i=0; i<[menuArray count]; i++) {
        NSArray*array=[menuArray objectAtIndex:i];
        NSString*sql=[NSString stringWithFormat:@"UPDATE SFMenu SET good_rank=? WHERE good_ID=?"];
        BOOL worked=[db executeUpdate:sql,[NSNumber numberWithInt:[[array objectAtIndex:1] integerValue]],[array objectAtIndex:0]];
    }
}
+(NSMutableArray*)fetchAllGoodFromLocal:(NSString *)categoryID
{
    NSMutableArray *resultArr=[[NSMutableArray alloc]init];
    
    FMDatabase *db = [FMDatabase databaseWithPath:DATABASE_PATH];
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return resultArr;
    };
    [MenuObject checkTableCreatedInDb:db];
    FMResultSet*rs=[db executeQuery:@"SELECT * FROM SFMenu WHERE menu_categoryID=? order by good_rank asc",categoryID];
    while ([rs next]) {
        MenuObject*good=[[MenuObject alloc] init];
        [good setCategoryID:[rs objectForColumnName:sfGoodCategory]];
        [good setGoodID:[rs objectForColumnName:sfGoodID]];
        [good setGoodName:[rs objectForColumnName:sfGoodName]];
        [good setGoodPrice:[rs objectForColumnName:sfGoodPrice]];
        [good setGoodPhotoCount:[rs objectForColumnName:sfGoodPhotoCount]];
        [good setGoodInfo:[rs objectForColumnName:sfGoodInfo]];
        [good setGoodOnSale:[rs objectForColumnName:sfGoodOnSale]];
        [good setGoodRank:[rs objectForKeyedSubscript:sfGoodRank]];
        [resultArr addObject:good];
    }
    [db close];
    return resultArr;
}
+(MenuObject*)menuFromDictionary:(NSDictionary *)aDic
{
    MenuObject*good=[[MenuObject alloc] init];
    [good setCategoryID:[aDic objectForKey:sfGoodCategory]];
    [good setGoodID:[aDic objectForKey:sfGoodID]];
    [good setGoodName:[aDic objectForKey:sfGoodName]];
    [good setGoodPrice:[NSNumber numberWithFloat:[[aDic objectForKey:sfGoodPrice] floatValue]]];
    [good setGoodPhotoCount:[aDic objectForKey:sfGoodPhotoCount]];
    [good setGoodInfo:[aDic objectForKey:sfGoodInfo]];
    [good setGoodOnSale:[NSNumber numberWithInt:[[aDic objectForKey:sfGoodOnSale] integerValue]]];
    [good setGoodRank:[NSNumber numberWithInt:[[aDic objectForKey:sfGoodRank] integerValue]]];
    return  good;
}
-(NSDictionary*)toDictionary
{
    NSDictionary*dic=[NSDictionary dictionaryWithObjectsAndKeys:categoryID,sfGoodCategory,goodID,sfGoodID,goodName,sfGoodName,goodPrice,sfGoodPrice,goodPhotoCount,sfGoodPhotoCount,goodInfo,sfGoodInfo,goodOnSale,sfGoodOnSale,goodRank,sfGoodRank,nil];
    return dic;
}
//
+(BOOL)checkTableCreatedInDb:(FMDatabase*)db
{
    NSString *createStr=@"CREATE TABLE IF NOT EXISTS 'SFMenu' ('good_ID' INT, 'good_name' VARCHAR PRIMARY KEY,'menu_categoryID' VARCHAR NOT NULL, 'good_price' FLOAT ,'good_photo_count' INT,'good_info' VARCHAR,'good_onSale' INT,'good_rank' INT)";
    
    BOOL worked = [db executeUpdate:createStr];
    FMDBQuickCheck(worked);
    return worked;
}
#pragma mark - md5
+(NSString*)md5:(NSString*)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, strlen(cStr), result );
    NSString*string=[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",result[0],result[1],result[2],result[3],result[4],result[5],result[6],result[7],result[8],result[9],result[10],result[11],result[12],result[13],result[14],result[15]];
    return string;
}
@end
