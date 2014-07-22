//
//  MenuObject.h
//  ShopFriendForShop
//
//  Created by Beautilut on 14-3-11.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import <Foundation/Foundation.h>
#define sfGoodCategory @"categoryID"
#define sfGoodID @"goodID"
#define sfGoodName @"goodName"
#define sfGoodPrice @"goodPrice"
#define sfGoodPhotoCount @"goodPhotoCount"
#define sfGoodInfo @"goodInfo"
#define sfGoodOnSale @"goodOnSale"
#define sfGoodRank @"goodRank"
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
