//
//  OrderObject.h
//  ShopFriendForShop
//
//  Created by Beautilut on 14-7-22.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import <Foundation/Foundation.h>
#define sfOrderID @"order_ID"
#define sfOrdercreatetime @"order_createtime"
#define sfServerID @"server_ID"
#define sfUserID @"user_ID"
#define sfShopID @"shop_ID"
#define sfOrderStatus @"order_status"
@interface OrderObject : NSObject
@property(nonatomic,retain) NSString*orderID;
@property(nonatomic,retain) NSDate*orderCreateTime;
@property(nonatomic,retain) NSString*serverID;
@property(nonatomic,retain) NSString*userID;
@property(nonatomic,retain) NSString*shopID;
@property(nonatomic,retain) NSNumber*orderStatus;

//数据库增删改查
+(BOOL)saveNewOrder:(OrderObject*)aOrder;
+(BOOL)deleteOrderById:(NSString*)orderID;
+(BOOL)updateOrder:(OrderObject*)aOrder;
+(BOOL)haveSaveOrderById:(NSString*)orderID;

//将对象转换为字典
-(NSDictionary*)toDictionary;
+(OrderObject*)orderFromDictionary:(NSDictionary*)aDic;


@end
