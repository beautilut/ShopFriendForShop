//
//  WebCouponMethods.m
//  ShopFriendForShop
//
//  Created by Beautilut on 14-7-25.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import "WebCouponMethods.h"
static WebCouponMethods*sharedCoupon;
@implementation WebCouponMethods
@synthesize delegate;
+(WebCouponMethods*)sharedCoupon
{
    static dispatch_once_t  onceToken;
    dispatch_once(&onceToken, ^{
        sharedCoupon=[[WebCouponMethods alloc] init];
    });
    return sharedCoupon;
}
-(void)webCouponInsert:(NSDictionary *)dic
{
    //data
    NSString*shopID=[dic objectForKey:sfShopID];
    NSString*couponName=[dic objectForKey:sfCouponModelName];
    NSString*couponInfo=[dic objectForKey:sfCouponModelInfo];
    NSString*couponBeginTime=[dic objectForKey:sfCouponModelBeginTime];
    NSString*couponEndTime=[dic objectForKey:sfCouponModelEndTime];
    NSString*couponUserInfo=[dic objectForKey:sfCouponModelUserInfo];
    NSString*couponImage=[dic objectForKey:sfCouponModelImage];
    
    //web
    NSURL*url=[NSURL URLWithString:couponModelInsertURL];
    ASIFormDataRequest*request=[ASIHTTPRequest requestWithURL:url];
    [request setPostValue:shopID forKey:sfShopID];
    [request setPostValue:couponName forKey:sfCouponModelName];
    [request setPostValue:couponInfo forKey:sfCouponModelInfo];
    [request setPostValue:couponBeginTime forKey:sfCouponModelBeginTime];
    [request setPostValue:couponEndTime forKey:sfCouponModelEndTime];
    [request setPostValue:couponUserInfo forKey:sfCouponModelUserInfo];
    [request setPostValue:couponImage forKey:sfCouponModelImage];
    [request setCompletionBlock:^{
        
    }];
    [request setFailedBlock:^{
        
    }];
    [request startAsynchronous];
}
-(void)webCouponChange:(NSDictionary *)dic
{
    //data
    NSString*couponID=[dic objectForKey:sfCouponModelID];
    NSString*couponName=[dic objectForKey:sfCouponModelName];
    NSString*couponInfo=[dic objectForKey:sfCouponModelInfo];
    NSString*couponBeginTime=[dic objectForKey:sfCouponModelBeginTime];
    NSString*couponEndTime=[dic objectForKey:sfCouponModelEndTime];
    NSString*couponUserInfo=[dic objectForKey:sfCouponModelUserInfo];
    NSString*couponImage=[dic objectForKey:sfCouponModelImage];
    
    //web
    NSURL*url=[NSURL URLWithString:couponModelChangeURL];
    ASIFormDataRequest*request=[ASIFormDataRequest requestWithURL:url];
    [request setPostValue:couponID forKey:sfCouponModelID];
    [request setPostValue:couponName forKey:sfCouponModelName];
    [request setPostValue:couponInfo forKey:sfCouponModelInfo];
    [request setPostValue:couponBeginTime forKey:sfCouponModelBeginTime];
    [request setPostValue:couponEndTime forKey:sfCouponModelEndTime];
    [request setPostValue:couponUserInfo forKey:sfCouponModelUserInfo];
    [request setPostValue:couponImage forKey:sfCouponModelImage];
    [request setCompletionBlock:^{
        
    }];
    [request setFailedBlock:^{
        
    }];
    [request startAsynchronous];
}
@end
