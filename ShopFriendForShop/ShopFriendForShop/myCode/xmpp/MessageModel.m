//
//  MessageModel.m
//  ShopFriendForShop
//
//  Created by Beautilut on 14-3-10.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import "MessageModel.h"
#import "FMDatabase.h"
#import "FMResultSet.h"
@implementation MessageModel
@synthesize messageContent,messageDate,messageFrom,messageTo,messageType,messageId;
+(MessageModel*)messageWithType:(int)aType
{
    MessageModel*msg=[[MessageModel alloc] init];
    [msg setMessageType:[NSNumber numberWithInt:aType]];
    return msg;
}
+(MessageModel*)messageFromDication:(NSDictionary *)adic
{
    MessageModel*msg=[[MessageModel alloc] init];
    [msg setMessageFrom:[adic objectForKey:kMESSAGE_FROM]];
    [msg setMessageTo:[adic objectForKey:kMESSAGE_TO]];
    [msg setMessageContent:[adic objectForKey:kMESSAGE_CONTENT]];
    [msg setMessageDate:[adic objectForKey:kMESSAGE_DATE]];
    //[msg setMessageType:[NSNumber numberWithInt:[adic objectForKey:kMESSAGE_TYPE]]];
    return msg;
}
//讲对象转换成字典
-(NSDictionary*)toDictionary
{
    NSDictionary*dic=[NSDictionary dictionaryWithObjectsAndKeys:messageId,kMESSAGE_ID,messageFrom,kMESSAGE_FROM,messageTo,kMESSAGE_TO,messageContent,kMESSAGE_CONTENT,messageDate,kMESSAGE_DATE,messageType,kMESSAGE_TYPE,nil];
    return dic;
}
//数据库操作
+(BOOL)save:(MessageModel *)aMessage
{
    FMDatabase *db = [FMDatabase databaseWithPath:DATABASE_PATH];
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return NO;
    }
    NSString *createStr=@"CREATE  TABLE  IF NOT EXISTS 'SFMessage' ('messageId' INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL  UNIQUE , 'messageFrom' VARCHAR, 'messageTo' VARCHAR, 'messageContent' VARCHAR, 'messageDate' DATETIME,'messageType' INTEGER )";
    
    BOOL worked = [db executeUpdate:createStr];
    FMDBQuickCheck(worked);
    
    NSString *insertStr=@"INSERT INTO 'SFMessage' ('messageFrom','messageTo','messageContent','messageDate','messageType') VALUES (?,?,?,?,?)";
    worked = [db executeUpdate:insertStr,aMessage.messageFrom,aMessage.messageTo,aMessage.messageContent,aMessage.messageDate,aMessage.messageType];
    FMDBQuickCheck(worked);
    
    
    
    [db close];
    //发送全局通知
    [[NSNotificationCenter defaultCenter]postNotificationName:kXMPPNewMsgNotifaction object:aMessage ];
    //[aMessage release];
    
    
    return worked;
}
//获取某联系人的聊天记录
+(NSMutableArray*)fetchMessageListWithUser:(NSString *)userId byPage:(int)pageInde
{
    NSMutableArray *messageList=[[NSMutableArray alloc]init];
    
    FMDatabase *db=[FMDatabase databaseWithPath:DATABASE_PATH];
    if (![db open]) {
        NSLog(@"数据打开失败");
        return messageList;
    }
    NSString*hostID=[[NSUserDefaults standardUserDefaults]objectForKey:kXMPPmyJID];
    NSString *queryString=@"select * from SFMessage where messageFrom=? or messageTo=?  order by messageDate";
    FMResultSet *rs=[db executeQuery:queryString,userId,userId];
    while ([rs next]) {
        MessageModel*message=[[MessageModel alloc]init];
        [message setMessageId:[rs objectForColumnName:kMESSAGE_ID]];
        [message setMessageContent:[rs stringForColumn:kMESSAGE_CONTENT]];
        [message setMessageDate:[rs dateForColumn:kMESSAGE_DATE]];
        [message setMessageFrom:[rs stringForColumn:kMESSAGE_FROM]];
        [message setMessageTo:[rs stringForColumn:kMESSAGE_TO]];
        [message setMessageType:[rs objectForColumnName:kMESSAGE_TYPE]];
        if ([message.messageFrom isEqualToString:hostID]||[message.messageTo isEqualToString:hostID]) {
            [ messageList addObject:message];
        }
    }
    [db close];
    return  messageList;
    
}
//获取最近联系人
+(NSMutableArray *)fetchRecentChatByPage:(int)pageIndex
{
    NSMutableArray *messageList=[[NSMutableArray alloc]init];
    
    FMDatabase *db=[FMDatabase databaseWithPath:DATABASE_PATH];
    if (![db open]) {
        NSLog(@"数据打开失败");
        return messageList;
    }
    NSString*hostID=[[NSUserDefaults standardUserDefaults]objectForKey:kXMPPmyJID];
    NSString *queryString=@"select * from (select * from SFMessage where messageFrom=? or messageTo=? order by messageDate asc) as m ,SFUser as u where u.userId=m.messageFrom or u.userId=m.messageTo group by u.userId  order by m.messageDate desc limit ?,10";
    FMResultSet *rs=[db executeQuery:queryString,hostID,hostID,[NSNumber numberWithInt:pageIndex-1]];
    while ([rs next]) {
        MessageModel*message=[[MessageModel alloc]init];
        [message setMessageId:[rs objectForColumnName:kMESSAGE_ID]];
        [message setMessageContent:[rs stringForColumn:kMESSAGE_CONTENT]];
        [message setMessageDate:[rs dateForColumn:kMESSAGE_DATE]];
        [message setMessageFrom:[rs stringForColumn:kMESSAGE_FROM]];
        [message setMessageTo:[rs stringForColumn:kMESSAGE_TO]];
        [message setMessageType:[rs objectForColumnName:kMESSAGE_TYPE]];
        
        UserObject*user=[[UserObject alloc]init];
        [user setUserId:[rs stringForColumn:kUSER_ID]];
        [user setUserNickname:[rs stringForColumn:kUSER_NICKNAME]];
        //[user setUserHead:[rs stringForColumn:kUSER_USERHEAD]];
        //[user setUserDescription:[rs stringForColumn:kUSER_DESCRIPTION]];
        [user setFriendFlag:[rs objectForColumnName:kUSER_FRIEND_FLAG]];
        
        MessageUserUnionObject*unionObject=[MessageUserUnionObject unionWithMessage:message andUser:user ];
        
        [ messageList addObject:unionObject];
        
    }
    return  messageList;
    
}

@end
