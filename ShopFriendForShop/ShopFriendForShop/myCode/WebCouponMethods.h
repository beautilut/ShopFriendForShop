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
@end
@protocol WebCouponMethodsDelegate <NSObject>
//webCouponInsert
-(void)webCouponInsertSuccess;
-(void)webCouponInsertFail;
//webCouponUpdate
-(void)webCouponChangeSuccess;
-(void)webCouponChangeFail;

@end