//
//  ShopObject.h
//  ShopFriendForShop
//
//  Created by Beautilut on 14-3-11.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopObject : NSObject
@property(nonatomic,retain) NSString*shopID;
@property(nonatomic,retain) NSString*shopName;
@property(nonatomic,retain) NSNumber*shopCategory;
@property(nonatomic,retain) NSString*shopCategoryWord;
@property(nonatomic,retain) NSString*shopAddress;
@property(nonatomic,retain) NSString*shopCategoryDetail;
@property(nonatomic,retain) NSString*shopTel;
@property(nonatomic,retain) NSString*shopOpenTime;

//数据库增删查改
+(BOOL)saveNewShop:(ShopObject*)aShop;
+(BOOL)deleteShopByID:(NSString*)shopID;
+(BOOL)updateShop:(NSString*)column with:(id)data;
+(BOOL)haveSaveShopByID:(NSString*)shopID;
+(ShopObject*)fetchShopInfo;

//将对象转换成字典
-(NSDictionary*)toDictionary;
+(ShopObject*)shopFromDictionary:(NSDictionary*)aDic;
@end
