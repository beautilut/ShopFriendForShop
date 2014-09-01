//
//  WebServerMethods.m
//  ShopFriendForShop
//
//  Created by Beautilut on 14-8-15.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import "WebServerMethods.h"
static WebServerMethods*shareServer;
@implementation WebServerMethods
@synthesize delegate;
+(WebServerMethods*)shared
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareServer=[[WebServerMethods alloc] init];
    });
    return shareServer;
}
-(void)getServerList
{
    NSURL*url=[NSURL URLWithString:serverGetURL];
    ASIFormDataRequest*request=[ASIFormDataRequest requestWithURL:url];
    //[request setPostValue:[InfoManager sharedInfo].myShop.shopID forKey:@"shopID"];
    [request setCompletionBlock:^{
        SBJsonParser*parser=[[SBJsonParser alloc] init];
        NSDictionary*dic=[parser objectWithString:request.responseString];
        if ([[dic objectForKey:@"back"] integerValue]==1) {
            if ([delegate respondsToSelector:@selector(getServerListSuccess:)]  ) {
                [delegate getServerListSuccess:dic];
            }
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"getServerListSuccess" object:dic];
        }
    }];
    [request setFailedBlock:^{
        if ([delegate respondsToSelector:@selector(getServerListFial)]) {
            [delegate getServerListFial];
        }
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"getServerListFail" object:nil];
    }];
    [request startAsynchronous];
}
-(void)showMyServer:(NSString*)kind
{
    NSURL*url=[NSURL URLWithString:getMyServer];
    ASIFormDataRequest*request=[ASIFormDataRequest requestWithURL:url];
    [request setPostValue:[InfoManager sharedInfo].myShop.shopID forKey:@"shopID"];
    [request setPostValue:kind forKey:@"kind"];
    [request setCompletionBlock:^{
        SBJsonParser*parser=[[SBJsonParser alloc] init];
        NSDictionary*dic=[parser objectWithString:request.responseString];
        if ([[dic objectForKey:@"back"] integerValue]==1) {
            if ([delegate respondsToSelector:@selector(showMyServerSuccess:)]) {
                [delegate showMyServerSuccess:dic];
            }
        }
    }];
    [request setFailedBlock:^{
        if ([delegate respondsToSelector:@selector(showMyServerFail)]) {
            [delegate showMyServerFail];
        }
    }];
    [request startAsynchronous];
}
-(void)getGoodServer:(NSString *)goodID
{
    NSURL*url=[NSURL URLWithString:getGoodServerURL];
    ASIFormDataRequest*request=[ASIFormDataRequest requestWithURL:url];
    [request setPostValue:goodID forKey:@"goodID"];
    [request setPostValue:[InfoManager sharedInfo].myShop.shopID forKey:@"shopID"];
    [request setCompletionBlock:^{
        SBJsonParser*parser=[[SBJsonParser alloc] init];
        NSDictionary*dic=[parser objectWithString:request.responseString];
        if ([[dic objectForKey:@"back"] integerValue]==1) {
            if ([delegate respondsToSelector:@selector(getGoodServerSuccess:)]) {
                [delegate getGoodServerSuccess:dic];
            }
        }else{
            if ([delegate respondsToSelector:@selector(getGoodServerFail)]) {
                [delegate getGoodServerFail];
            }
        }
    }];
    [request setFailedBlock:^{
        if ([delegate respondsToSelector:@selector(showMyServerFail)]) {
            [delegate getGoodServerFail];
        }
    }];
    [request startAsynchronous];
}
-(void)changeServerRange:(NSString *)range withInfo:(NSString *)info with:(NSDictionary *)dic
{
    NSURL*url=[NSURL URLWithString:serverInfoChange];
    ASIFormDataRequest*request=[ASIFormDataRequest requestWithURL:url];
    [request setPostValue:range forKey:@"range"];
    [request setPostValue:info forKey:@"serverInfo"];
    [request setPostValue:[dic objectForKey:@"shop_ID"] forKey:@"shopID"];
    [request setPostValue:[dic objectForKey:@"server_ID"] forKey:@"serverID"];
    [request setCompletionBlock:^{
        SBJsonParser*parser=[[SBJsonParser alloc] init];
        NSDictionary*dic=[parser objectWithString:request.responseString];
        if ([[dic objectForKey:@"back"] integerValue]==1) {
            if ([delegate respondsToSelector:@selector(changeServerSuccess)]) {
                [delegate changeServerSuccess];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"newServerRegister" object:nil];
            }
        }else
        {
            if ([delegate respondsToSelector:@selector(changeServerFail)]) {
                [delegate changeServerFail];
            }
        }
    }];
    [request setFailedBlock:^{
        if ([delegate respondsToSelector:@selector(changeServerFail)]) {
            [delegate changeServerFail];
        }
    }];
    [request startAsynchronous];
}
-(void)registerServer:(NSDictionary *)dic
{
    NSURL*url=[NSURL URLWithString:registerServerURL];
    ASIFormDataRequest*request=[ASIFormDataRequest requestWithURL:url];
    [request setPostValue:[dic objectForKey:@"server_ID"] forKey:@"serverID"];
    [request setPostValue:[InfoManager sharedInfo].myShop.shopID forKey:@"shopID"];
    [request setCompletionBlock:^{
        SBJsonParser*parser=[[SBJsonParser alloc] init];
        NSDictionary*dic=[parser objectWithString:request.responseString];
        if ([[dic objectForKey:@"back"] integerValue]==1) {
            if ([delegate respondsToSelector:@selector(registerServerAccept)]) {
                [delegate registerServerAccept];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"newServerRegister" object:nil];
            }
        }else
        {
            if ([delegate respondsToSelector:@selector(registerServerFail)]) {
                [delegate registerServerFail];
            }
        }
    }];
    [request setFailedBlock:^{
        if ([delegate respondsToSelector:@selector(registerServerFail)]) {
            [delegate registerServerFail];
        }
    }];
    [request startAsynchronous];
}
@end
