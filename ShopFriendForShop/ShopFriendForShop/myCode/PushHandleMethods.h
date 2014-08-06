//
//  PushHandleMethods.h
//  ShopFriendForShop
//
//  Created by Beautilut on 14-8-5.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PushHandleMethods : NSObject
+(PushHandleMethods*)shared;

-(void)handleWithAPI:(NSString *)api with:(NSString*)data;
@end
