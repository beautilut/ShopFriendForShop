//
//  OrderObject.h
//  ShopFriendForShop
//
//  Created by Beautilut on 14-7-22.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderObject : NSObject
@property(nonatomic,retain) NSString*orderID;
@property(nonatomic,retain) NSDate*orderCreateTime;
@property(nonatomic,retain) NSString*userID;
@property(nonatomic,retain) NSString*userName;
@property(nonatomic,retain) NSString*userLocation;
@property(nonatomic,retain) NSString*shopID;
@property(nonatomic,retain) NSString*shopName;
@property(nonatomic,retain) NSNumber*orderStatus;
@property(nonatomic,retain) NSString*serverID;
@property(nonatomic,retain) NSString*serverName;
@property(nonatomic,retain) NSNumber*serverKind;
@property(nonatomic,retain) NSNumber*serverSpend;
@property(nonatomic,retain) NSNumber*orderTotalPrice;
//数据库增删改查
+(BOOL)saveNewOrder:(OrderObject*)aOrder;
+(BOOL)deleteOrderById:(NSString*)orderID;
+(BOOL)updateOrder:(OrderObject*)aOrder;
+(BOOL)haveSaveOrderById:(NSString*)orderID;
+(NSArray*)showOrders:(NSString*)shopID;
//将对象转换为字典
-(NSDictionary*)toDictionary;
+(OrderObject*)orderFromDictionary:(NSDictionary*)aDic;


@end
