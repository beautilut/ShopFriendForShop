//
//  UserObject.h
//  ShopFriendForShop
//
//  Created by Beautilut on 14-3-10.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserObject : NSObject
@property(nonatomic,retain) NSString*userId;
@property(nonatomic,retain) NSString*userNickname;
@property(nonatomic,retain) NSNumber*friendFlag;

//数据库增删改查
+(BOOL)saveNewUser:(UserObject*)aUser;
+(BOOL)deleteUserById:(NSNumber*)userId;
+(BOOL)updateUser:(UserObject*)newUser;
+(BOOL)haveSaveUserById:(NSString*)userId;

+(NSMutableArray*)fetchAllFriendsFromLocal;

//将对象转换为字典
-(NSDictionary*)toDictionary;
+(UserObject*)userFromDictionary:(NSDictionary*)aDic;
@end
