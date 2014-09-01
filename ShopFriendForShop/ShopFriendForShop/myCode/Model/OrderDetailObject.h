//
//  OrderDetailObject.h
//  ShopFriendForShop
//
//  Created by Beautilut on 14-7-22.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderDetailObject : NSObject
@property(nonatomic,retain) NSString*orderID;
@property(nonatomic,retain) NSString*goodID;
@property(nonatomic,retain) NSString*goodName;
@property(nonatomic,retain) NSNumber*goodNumber;
@property(nonatomic,retain) NSNumber*goodPrice;

//数据库增删改查
+(BOOL)saveNewOrderDetial:(OrderDetailObject*)aDetail;
+(BOOL)deleteOrderDetailById:(NSString*)detailID;
+(BOOL)updateOrderDetail:(OrderDetailObject*)aDetail;
+(BOOL)haveSaveOrderById:(NSString*)detailID;
+(NSArray*)getDetailByID:(NSString*)orderID;
//将对象转换为字典
-(NSDictionary*)toDictionary;
+(OrderDetailObject*)orderFromDictionary:(NSDictionary*)aDic;

@end
