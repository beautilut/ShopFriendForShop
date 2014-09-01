//
//  MessageModel.h
//  ShopFriendForShop
//
//  Created by Beautilut on 14-3-10.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import <Foundation/Foundation.h>


enum bSFMessageType {
    bSFMessageTypePlain = 0,
    bSFMessageTypeImage = 1,
    bSFMessageTypeVoice =2,
    bSFMessageTypeLocation=3
};
enum bSFMessageCellStyle {
    bSFMessageCellStyleMe = 0,
    bSFMessageCellStyleOther = 1,
    bSFMessageCellStyleMeWithImage=2,
    bSFMessageCellStyleOtherWithImage=3
};

@interface MessageModel : NSObject
@property (nonatomic,retain) NSString *messageFrom;
@property (nonatomic,retain) NSString *messageTo;
@property (nonatomic,retain) NSString *messageContent;
@property (nonatomic,retain) NSDate *messageDate;
@property (nonatomic,retain) NSNumber *messageType;
@property (nonatomic,retain) NSNumber *messageId;
+(MessageModel*)messageWithType:(int)aType;
//转成字典
-(NSDictionary*)toDictionary;
+(MessageModel*)messageFromDication:(NSDictionary*)adic;
//数据库增删
+(BOOL)save:(MessageModel*)aMessage;
+(BOOL)deleteMessageById:(NSNumber*)aMessageId;
+(BOOL)merge:(MessageModel*)aMessage;
+(BOOL)cleanMessage:(NSString*)userId;
//获取某联系人聊天记录
+(NSMutableArray*)fetchMessageListWithUser:(NSString*)userId byPage:(int)pageIndex;
//获取最近联系人
+(NSMutableArray*)fetchRecentChatByPage:(int)pageIndex;
@end
