//
//  UserObject.m
//  ShopFriendForShop
//
//  Created by Beautilut on 14-3-10.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import "UserObject.h"
#import "FMDatabase.h"
#import "FMResultSet.h"
@implementation UserObject
@synthesize userId,userNickname,friendFlag;
+(BOOL)saveNewUser:(UserObject*)aUser
{
    
    
    FMDatabase *db = [FMDatabase databaseWithPath:DATABASE_PATH];
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return NO;
    };
    
    [UserObject checkTableCreatedInDb:db];
    
    
    
    NSString *insertStr=@"INSERT INTO 'SFUser' ('user_ID','user_name','friendFlag') VALUES (?,?,?)";
    BOOL worked = [db executeUpdate:insertStr,aUser.userId,aUser.userNickname,[NSNumber numberWithInt:0]];
    // FMDBQuickCheck(worked);
    
    
    
    [db close];
    
    
    return worked;
}
+(BOOL)haveSaveUserById:(NSString*)userId
{
    
    FMDatabase *db = [FMDatabase databaseWithPath:DATABASE_PATH];
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return YES;
    };
    [UserObject checkTableCreatedInDb:db];
    
    FMResultSet *rs=[db executeQuery:@"select count(*) from SFUser where user_ID=?",userId];
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
+(BOOL)deleteUserById:(NSNumber*)userId
{
    return NO;
    
}
+(BOOL)updateUser:(UserObject*)newUser
{
    
    FMDatabase *db = [FMDatabase databaseWithPath:DATABASE_PATH];
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return NO;
    };
    [UserObject checkTableCreatedInDb:db];
    BOOL worked=[db executeUpdate:@"update SFUser set friendFlag=1 where user_ID=?",newUser.userId];
    
    return worked;
    
}

+(NSMutableArray*)fetchAllFriendsFromLocal
{
    NSMutableArray *resultArr=[[NSMutableArray alloc]init];
    
    FMDatabase *db = [FMDatabase databaseWithPath:DATABASE_PATH];
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return resultArr;
    };
    [UserObject checkTableCreatedInDb:db];
    
    FMResultSet *rs=[db executeQuery:@"select * from SFUser where friendFlag=?",[NSNumber numberWithInt:1]];
    while ([rs next]) {
        UserObject*user=[[UserObject alloc]init];
        user.userId=[rs stringForColumn:kUSER_ID];
        user.userNickname=[rs stringForColumn:kUSER_NICKNAME];
        //user.userHead=[rs stringForColumn:kUSER_USERHEAD];
        //user.userDescription=[rs stringForColumn:kUSER_DESCRIPTION];
        user.friendFlag=[NSNumber numberWithInt:1];
        [resultArr addObject:user];
    }
    [rs close];
    return resultArr;
    
}

+(UserObject*)userFromDictionary:(NSDictionary*)aDic
{
    UserObject *user=[[UserObject alloc]init];
    [user setUserId:[aDic objectForKey:kUSER_ID]];
    //[user setUserHead:[aDic objectForKey:kUSER_USERHEAD]];
    //[user setUserDescription:[aDic objectForKey:kUSER_DESCRIPTION]];
    [user setUserNickname:[aDic objectForKey:kUSER_NICKNAME]];
    return user;
}

-(NSDictionary*)toDictionary
{
    NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:userId,kUSER_ID,userNickname,kUSER_NICKNAME,friendFlag,kUSER_FRIEND_FLAG,nil];
    return dic;
}


+(BOOL)checkTableCreatedInDb:(FMDatabase *)db
{
    NSString *createStr=@"CREATE  TABLE  IF NOT EXISTS 'SFUser' ('user_ID' VARCHAR PRIMARY KEY  NOT NULL  UNIQUE , 'user_name' VARCHAR,'friendFlag' INT)";
    
    BOOL worked = [db executeUpdate:createStr];
    FMDBQuickCheck(worked);
    return worked;
    
}
@end
