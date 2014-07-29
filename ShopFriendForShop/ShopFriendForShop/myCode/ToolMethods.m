//
//  ToolMethods.m
//  ShopFriendForShop
//
//  Created by Beautilut on 14-7-25.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import "ToolMethods.h"
static ToolMethods*tool;
@implementation ToolMethods
+(ToolMethods*)sharedMethods
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        tool=[[ToolMethods alloc] init];
    });
    return tool;
}
-(NSString*)JSONString:(id)data;
{
    NSError* error = nil;
    id result = [NSJSONSerialization dataWithJSONObject:data options:kNilOptions
                                                  error:&error];
    if (error != nil) return nil;
    NSString*string=[[NSString alloc] initWithData:result encoding:NSASCIIStringEncoding];
    return string;
}
@end
