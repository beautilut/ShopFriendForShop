//
//  OrderDetailObject.h
//  ShopFriendForShop
//
//  Created by Beautilut on 14-7-22.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import <Foundation/Foundation.h>
#define sfOrderDetailID @"orderDetail_ID"
#define sfGoodID @"good_ID"
#define sfGoodNumber @"good_number"
#define sfGoodPrice @"good_price"
@interface OrderDetailObject : NSObject
@property(nonatomic,retain) NSString*orderDetailID;
@property(nonatomic,retain) NSString*goodID;
@property(nonatomic,retain) NSNumber*goodNumber;
@property(nonatomic,retain) NSNumber*goodPrice;

//数据库增删改查
+(BOOL)saveNewOrderDetial:(OrderDetailObject*)aDetail;
+(BOOL)deleteOrderDetailById:(NSString*)detailID;
+(BOOL)updateOrderDetail:(OrderDetailObject*)aDetail;
+(BOOL)haveSaveOrderById:(NSString*)detailID;

//将对象转换为字典
-(NSDictionary*)toDictionary;
+(OrderDetailObject*)orderFromDictionary:(NSDictionary*)aDic;

@end
