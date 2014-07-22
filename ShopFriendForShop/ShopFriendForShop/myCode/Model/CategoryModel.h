//
//  CategoryModel.h
//  ShopFriendForShop
//
//  Created by Beautilut on 14-3-11.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import <Foundation/Foundation.h>

#define sfCategoryShopID @"shopID"
#define sfCategoryID @"categoryID"
#define sfCategoryName @"categoryName"
#define sfCategoryRank @"categoryRank"
@interface CategoryModel : NSObject
@property(nonatomic,retain) NSString*shopID;
@property(nonatomic,retain) NSString*categoryID;
@property(nonatomic,retain) NSString*categoryName;
@property(nonatomic,retain) NSNumber*categoryRank;
//数据库增删改查
+(BOOL)saveNewCategory:(CategoryModel*)aCategory;
+(BOOL)deleteCategoryByID:(NSNumber*)categoryID;
+(BOOL)updateCategory:(CategoryModel*)newCategory;
+(BOOL)haveSaveCategoryByID:(NSString*)categoryID;
+(void)updateCategoryRank:(NSMutableArray*)categoryArray;
+(NSMutableArray*)fetchAllCategoryFromLocal;
//将对象转换成字典
-(NSDictionary*)toDictionary;
+(CategoryModel*)categoryFromDictionary:(NSDictionary*)aDic;
@end
