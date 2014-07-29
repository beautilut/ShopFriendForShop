//
//  ToolMethods.h
//  ShopFriendForShop
//
//  Created by Beautilut on 14-7-25.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToolMethods : NSObject
+(ToolMethods*)sharedMethods;
-(NSString*)JSONString:(id)data;
@end
