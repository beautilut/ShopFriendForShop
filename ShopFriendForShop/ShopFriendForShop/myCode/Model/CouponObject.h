//
//  CouponObject.h
//  ShopFriendForShop
//
//  Created by Beautilut on 14-7-26.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface CouponObject : NSObject
@property(nonatomic,retain) NSString*couponModel_ID;
@property(nonatomic,retain) NSString*couponModel_name;
@property(nonatomic,retain) NSString*couponModel_info;
@property(nonatomic,retain) NSDate*couponModel_beginTime;
@property(nonatomic,retain) NSDate*couponModel_endTime;
@property(nonatomic,retain) NSString*couponModel_useInfo;
@property(nonatomic,retain) NSString*couponModel_Image;
@property(nonatomic,retain) NSNumber*couponModel_status;
//数据库增删改查
+(BOOL)saveNewCoupon:(CouponObject*)aCoupon;
+(BOOL)deleteCouponById:(NSString*)couponID;
+(BOOL)updateCoupon:(CouponObject*)aCoupon;
+(BOOL)haveSaveCouponById:(NSString*)couponID;

//将对象转化为字典
-(NSDictionary*)toDictionary;
+(CouponObject*)couponFromDictionary:(NSDictionary*)aDic;

@end