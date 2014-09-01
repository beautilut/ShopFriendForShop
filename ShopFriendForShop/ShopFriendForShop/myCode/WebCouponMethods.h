//
//  WebCouponMethods.h
//  ShopFriendForShop
//
//  Created by Beautilut on 14-7-25.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CouponObject.h"
@protocol WebCouponMethodsDelegate;
@interface WebCouponMethods : NSObject
{
    id<WebCouponMethodsDelegate>delegate;
}
@property(nonatomic,strong)id <WebCouponMethodsDelegate> delegate;
+(WebCouponMethods*)sharedCoupon;
-(void)webCouponInsert:(NSDictionary*)dic;
-(void)webCouponChange:(NSDictionary*)dic;
-(void)webCouponGet;
@end
@protocol WebCouponMethodsDelegate <NSObject>
//webCouponInsert
-(void)webCouponInsertSuccess;
-(void)webCouponInsertFail;
//webCouponUpdate
-(void)webCouponChangeSuccess;
-(void)webCouponChangeFail;
//webCouponGet
-(void)webCouponGetSuccess:(NSArray*)dic;
-(void)webCouponGetFail;
@end