//
//  WebOrderMethods.m
//  ShopFriendForShop
//
//  Created by Beautilut on 14-7-22.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import "WebOrderMethods.h"
static WebOrderMethods *shareOrder;
@implementation WebOrderMethods
@synthesize delegate;
+(WebOrderMethods*)sharedOrder
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareOrder=[[WebOrderMethods alloc] init];
    });
    return shareOrder;
}
-(void)webOrderInsert:(NSDictionary *)dic
{
    //data
    NSString*shopID=[dic objectForKey:sfShopID];
    NSString*userID=[dic objectForKey:sfUserID];
    NSString*serverID=[dic objectForKey:sfServerID];
    NSArray*orderDetailArray=[dic objectForKey:@"orderDetail"];
    
    //web
    NSURL*url=[NSURL URLWithString:insertOrderURL];
    ASIFormDataRequest*request=[ASIHTTPRequest requestWithURL:url];
    [request setPostValue:shopID forKey:sfShopID];
    [request setPostValue:userID forKey:sfUserID];
    [request setPostValue:serverID forKey:sfServerID];
    NSString*detailString=[[ToolMethods sharedMethods] JSONString:orderDetailArray];
    [request setPostValue:detailString forKey:@"OrderDetail"];
    [request setCompletionBlock:^{
        
        SBJsonParser*parser=[[SBJsonParser alloc] init];
        NSDictionary*dic=[parser objectWithString:request.responseString];
        //待
    }];
    [request setFailedBlock:^{
        //待
    }];
    [request startAsynchronous];
}

-(void)webOrderUpdate:(NSDictionary *)dic
{
    //data
    NSString*userID=[dic objectForKey:sfUserID];
    NSString*orderID=[dic objectForKey:sfOrderID];
    
    //web
    NSURL*url=[NSURL URLWithString:updateOrderURL];
    ASIFormDataRequest*request=[ASIHTTPRequest requestWithURL:url];
    [request setPostValue:userID forKey:sfUserID];
    [request setPostValue:orderID forKey:sfOrderID];
    [request setCompletionBlock:^{
        //待
    }];
    [request setFailedBlock:^{
        //待
    }];
    [request startAsynchronous];
}

@end
