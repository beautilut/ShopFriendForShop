//
//  WebOrderMethods.m
//  ShopFriendForShop
//
//  Created by Beautilut on 14-7-22.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import "WebOrderMethods.h"
#import "FMDatabase.h"
#import "FMResultSet.h"
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
//not use
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
        if ([delegate respondsToSelector:@selector(webOrderInsertSuccess)]) {
            [delegate webOrderInsertFail];
        }
    }];
    [request startAsynchronous];
}

-(void)webOrderUpdate:(OrderObject*)aOrder
{
    //web
    NSURL*url=[NSURL URLWithString:updateOrderURL];
    ASIFormDataRequest*request=[ASIFormDataRequest requestWithURL:url];
    [request setPostValue:aOrder.userID forKey:@"to"];
    [request setPostValue:aOrder.shopID forKey:@"from"];
    [request setPostValue:@"shop" forKey:@"kind"];
    [request setPostValue:aOrder.orderID forKey:sfOrderID];
    [request setPostValue:aOrder.orderStatus forKey:sfOrderStatus];
    [request setCompletionBlock:^{
        SBJsonParser*parser=[[SBJsonParser alloc] init];
        NSDictionary*dic=[parser objectWithString:request.responseString];
        if ([[dic objectForKey:@"back"] integerValue]==1) {
            if ([OrderObject updateOrder:aOrder]) {
                if ([delegate respondsToSelector:@selector(webOrderUpdateSuccess)]) {
                    [delegate webOrderUpdateSuccess];
            }
            }
        }
    }];
    [request setFailedBlock:^{
        if ([delegate respondsToSelector:@selector(webOrderUpdateFail)]) {
            [delegate webOrderUpdateFail];
        }
    }];
    [request startAsynchronous];
}
-(void)getNewOrder:(NSString*)orderID
{
    NSURL*url=[NSURL URLWithString:getOrderURL];
    ASIFormDataRequest*request=[ASIFormDataRequest requestWithURL:url];
    [request setPostValue:orderID forKey:@"order_ID"];
    [request setCompletionBlock:^{
        //
        SBJsonParser*parser=[[SBJsonParser alloc] init];
        NSDictionary*dic=[parser objectWithString:request.responseString];
        if ([[dic objectForKey:@"back"] integerValue]==1) {
//            OrderObject*aOrder=[OrderObject orderFromDictionary:[dic objectForKey:@"order"]];
//            [OrderObject saveNewOrder:aOrder];
//            NSArray*detailArray=[dic objectForKey:@"orderDetail"];
//            for (NSDictionary*detailDic in detailArray) {
//                OrderDetailObject*aDetail=[OrderDetailObject orderFromDictionary:detailDic];
//                [OrderDetailObject saveNewOrderDetial:aDetail];
//            }
            [[NSNotificationCenter defaultCenter] postNotificationName:@"orderNumberChange" object:nil];
            [[InfoManager sharedInfo] playAudio:@"order"];
        }
    }];
    [request setFailedBlock:^{
       
    }];
    [request startAsynchronous];
}
-(void)getAllOrders
{
    NSURL*url=[NSURL URLWithString:getAllOrderURL];
    ASIFormDataRequest*request=[ASIFormDataRequest requestWithURL:url];
    [request setPostValue:[InfoManager sharedInfo].myShop.shopID forKey:@"shop_ID"];
    [request setCompletionBlock:^{
        
        SBJsonParser*parser=[[SBJsonParser alloc] init];
        NSDictionary*dic=[parser objectWithString:request.responseString];
        if ([[dic objectForKey:@"back"] integerValue]==1) {
        if ([delegate respondsToSelector:@selector(getAllOrdersSuccess:)]) {
            [delegate getAllOrdersSuccess:dic];
        }
        }else{
            if ([delegate respondsToSelector:@selector(getAllOrdersFail)]) {
                [delegate getAllOrdersFail];
            }
        }
    }];
    [request setFailedBlock:^{
        if ([delegate respondsToSelector:@selector(getAllOrdersFail)]) {
            [delegate getAllOrdersFail];
        }
    }];
    [request startAsynchronous];
}
@end
