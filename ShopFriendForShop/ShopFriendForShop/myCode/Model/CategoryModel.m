//
//  CategoryModel.m
//  ShopFriendForShop
//
//  Created by Beautilut on 14-3-11.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import "CategoryModel.h"
#import "FMDatabase.h"
#import "FMResultSet.h"
@implementation CategoryModel
@synthesize shopID,categoryID,categoryName,categoryRank;
+(BOOL)saveNewCategory:(CategoryModel *)aCategory
{
    FMDatabase*db=[FMDatabase databaseWithPath:DATABASE_PATH];
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return NO;
    };
    [CategoryModel checkTableCreatedInDb:db];
    
    NSString*insertStr=@"INSERT INTO 'SFCategory' ('categoryID','shopID','categoryName','categoryRank') VALUES(?,?,?,?)";
    BOOL worked=[db executeUpdate:insertStr,aCategory.categoryID,aCategory.shopID,aCategory.categoryName,aCategory.categoryRank];
    [db close];
    return worked;
}
+(BOOL)haveSaveCategoryByID:(NSString *)categoryID
{
    FMDatabase *db = [FMDatabase databaseWithPath:DATABASE_PATH];
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return YES;
    };
    [CategoryModel checkTableCreatedInDb:db];
    FMResultSet*rs=[db executeQuery:@"SELECT COUNT(*) FROM SFCategory WHERE categoryID=?",categoryID];
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
+(BOOL)deleteCategoryByID:(NSString *)categoryID
{
    FMDatabase *db = [FMDatabase databaseWithPath:DATABASE_PATH];
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return YES;
    };
    [CategoryModel checkTableCreatedInDb:db];
    BOOL worked=[db executeUpdate:@"DELETE FROM SFCategory WHERE categoryID=?",categoryID];
    return worked;
}
+(BOOL)updateCategory:(CategoryModel *)newCategory
{
    FMDatabase*db=[FMDatabase databaseWithPath:DATABASE_PATH];
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return YES;
    };
    [CategoryModel checkTableCreatedInDb:db];
    BOOL worked=[db executeUpdate:@"update SFCategory set categoryName=? where categoryID=?",newCategory.categoryName,newCategory.categoryID];
    return worked;
}
+(void)updateCategoryRank:(NSMutableArray *)categoryArray
{
    FMDatabase*db=[FMDatabase databaseWithPath:DATABASE_PATH];
    if (![db open]) {
        NSLog(@"数据库打开失败");
    };
    [CategoryModel checkTableCreatedInDb:db];
    for (int i=0; i<[categoryArray count]; i++) {
        NSArray*array=[categoryArray objectAtIndex:i];
        NSString*sql=[NSString stringWithFormat:@"update SFCategory set categoryRank=%@ where categoryID=%@",[array objectAtIndex:1],[array objectAtIndex:0]];
        BOOL worked=[db executeUpdate:sql];
    }
}
+(NSMutableArray*)fetchAllCategoryFromLocal
{
    NSMutableArray*resultArr=[[NSMutableArray alloc] init];
    FMDatabase *db = [FMDatabase databaseWithPath:DATABASE_PATH];
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return resultArr;
    };
    [CategoryModel checkTableCreatedInDb:db];
    NSString*shopID=[[NSUserDefaults standardUserDefaults]objectForKey:kXMPPmyJID];
    FMResultSet*rs=[db executeQuery:@"SELECT * FROM SFCategory WHERE shopID=? order by categoryRank asc",shopID];
    while ([rs next]) {
        CategoryModel*category=[[CategoryModel alloc] init];
        category.categoryID=[rs stringForColumn:sfCategoryID];
        category.categoryName=[rs stringForColumn:sfCategoryName];
        category.shopID=[rs stringForColumn:sfShopID];
        category.categoryRank=[NSNumber numberWithInt:[[rs stringForColumn:sfCategoryRank] integerValue]];
        [resultArr addObject:category];
    }
    return resultArr;
}
+(CategoryModel*)categoryFromDictionary:(NSDictionary *)aDic
{
    CategoryModel*category=[[CategoryModel alloc] init];
    [category setCategoryID:[aDic objectForKey:sfCategoryID]];
    [category setCategoryName:[aDic objectForKey:sfCategoryName]];
    [category setShopID:[aDic objectForKey:sfShopID]];
    [category setCategoryRank:[aDic objectForKey:sfCategoryRank]];
    return  category;
}
-(NSDictionary*)toDictionary
{
    NSDictionary*dic=[NSDictionary dictionaryWithObjectsAndKeys:categoryID,sfCategoryID,categoryName,sfCategoryName,shopID,sfShopID, nil];
    return  dic;
}
+(BOOL)checkTableCreatedInDb:(FMDatabase*)db
{
    NSString*createStr=@"CREATE TABLE IF NOT EXISTS 'SFCategory' ('categoryID' VARCHAR PRIMARY KEY NOT NULL UNIQUE,'shopID' VARCHAR ,'categoryName' VARCHAR,'categoryRank' INT)";
    BOOL worked=[db executeUpdate:createStr];
    FMDBQuickCheck(worked);
    return worked;
}
@end
