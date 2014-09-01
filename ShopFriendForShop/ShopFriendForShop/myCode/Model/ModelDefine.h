//
//  NSObject_ModelDefine.h
//  ShopFriendForShop
//
//  Created by Beautilut on 14-8-11.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#pragma mark messageModel

#define kMESSAGE_TYPE @"messageType"
#define kMESSAGE_FROM @"messageFrom"
#define kMESSAGE_TO @"messageTo"
#define kMESSAGE_CONTENT @"messageContent"
#define kMESSAGE_DATE @"messageDate"
#define kMESSAGE_ID @"messageId"

#pragma mark userModel

#define sfUserID @"user_ID"
#define sfUserName @"user_name"
#define sfUserFlag @"friendFlag"

#pragma mark categoryModel

#define sfCategoryShopID @"shop_ID"
#define sfCategoryID @"menu_categoryID"
#define sfCategoryName @"menu_category"
#define sfCategoryRank @"menu_rank"

#pragma mark menuModel

#define sfGoodCategory @"menu_categoryID"
#define sfGoodID @"good_ID"
#define sfGoodName @"good_name"
#define sfGoodPrice @"good_price"
#define sfGoodPhotoCount @"good_photo_count"
#define sfGoodInfo @"good_info"
#define sfGoodOnSale @"good_onSale"
#define sfGoodRank @"good_rank"

#pragma mark ShopModel

#define sfShopID @"shop_ID"
#define sfShopName @"shop_name"
#define sfShopCategoryWord @"shopCategoryWord"
#define sfShopCategory @"shop_category"
#define sfShopCategoryDetail @"shop_category_detail"
#define sfShopAddress @"shop_address"
#define sfShopTel @"shop_tel"
#define sfShopOpenTime @"shop_opening_time"

#pragma mark orderModel

#define sfOrderID @"order_ID"
#define sfOrdercreatetime @"order_createtime"
#define sfUserLocation @"user_location"
#define sfOrderStatus @"order_status"
#define sfServerID @"server_ID"
#define sfServername @"server_name"
#define sfServerkind @"server_kind"
#define sfServerSpend @"server_spend"
#define sfOrderTotalPrice @"order_total_price"

#pragma mark orderDetailmodel

#define sfGoodNumber @"good_number"
#define sfGoodPrice @"good_price"

#pragma mark CouponModel

#define sfCouponModelID @"couponModel_ID"
#define sfCouponModelName @"couponModel_Name"
#define sfCouponModelInfo @"couponModel_Info"
#define sfCouponModelBeginTime @"couponModel_BeginTime"
#define sfCouponModelEndTime @"couponModel_EndTime"
#define sfCouponModelUserInfo @"couponModel_useInfo"
#define sfCouponModelImage @"couponModel_Image"
#define sfCouponModelNumber @"couponModel_shop_number"
#define sfCouponModelStatus @"couponModel_status"
