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
-(BOOL)checkPhone:(NSString *)string
{
    if ([string length]==0) {
        return NO;
    }
    NSString*regex=@"^((13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
    NSPredicate*pred=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    BOOL isMatch=[pred evaluateWithObject:string];
    return isMatch;
}
@end
