//
//  MenuObject.h
//  ShopFriendForShop
//
//  Created by Beautilut on 14-3-11.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import <Foundation/Foundation.h>
#define sfGoodCategory @"menu_categoryID"
#define sfGoodID @"good_ID"
#define sfGoodName @"good_name"
#define sfGoodPrice @"good_price"
#define sfGoodPhotoCount @"good_photo_count"
#define sfGoodInfo @"good_info"
#define sfGoodOnSale @"good_onSale"
#define sfGoodRank @"good_rank"
@interface MenuObject : NSObject
@property(nonatomic,retain) NSString*categoryID;
@property(nonatomic,retain) NSString*goodID;
@property(nonatomic,retain) NSString*goodName;
@property(nonatomic,retain) NSNumber*goodPrice;
@property(nonatomic,retain) NSNumber*goodPhotoCount;
@property(nonatomic,retain) NSString*goodInfo;
@property(nonatomic,retain) NSNumber*goodOnSale;
@property(nonatomic,retain) NSNumber*goodRank;
//数据库增删改查
+(BOOL)saveNewGood:(MenuObject*)aMenu;
+(BOOL)deleteGoodById:(NSString *)goodID;
+(BOOL)updateGood:(MenuObject*)newGood;
+(BOOL)haveSaveGoodById:(NSString*)goodID;
+(void)updategoodRank:(NSMutableArray*)menuArray;
+(NSMutableArray*)fetchAllGoodFromLocal:(NSString*)categoryID;

//将对象转换为字典
+(NSString*)md5:(NSString*)str;
-(NSDictionary*)toDictionary;
+(MenuObject*)menuFromDictionary:(NSDictionary*)aDic;
@end
