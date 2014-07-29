//
//  CategoryModel.h
//  ShopFriendForShop
//
//  Created by Beautilut on 14-3-11.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import <Foundation/Foundation.h>

#define sfCategoryShopID @"shop_ID"
#define sfCategoryID @"menu_categoryID"
#define sfCategoryName @"menu_category"
#define sfCategoryRank @"menu_rank"
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
