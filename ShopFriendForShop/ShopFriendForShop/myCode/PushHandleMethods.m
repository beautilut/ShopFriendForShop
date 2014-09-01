//
//  PushHandleMethods.m
//  ShopFriendForShop
//
//  Created by Beautilut on 14-8-5.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import "PushHandleMethods.h"
#import "WebOrderMethods.h"
static PushHandleMethods*sharedPush;
@implementation PushHandleMethods
+(PushHandleMethods*)shared
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedPush=[[PushHandleMethods alloc] init];
    });
    return sharedPush;
}
-(void)handleWithAPI:(NSString *)api with:(NSString*)data
{
    if (api !=[NSNull null]) {
        if ([api isEqualToString:@"newOrder"]) {
            [[WebOrderMethods sharedOrder] getNewOrder:data];
        }
    }
}
@end
