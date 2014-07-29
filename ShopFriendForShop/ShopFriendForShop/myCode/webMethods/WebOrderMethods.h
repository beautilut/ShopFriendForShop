//
//  WebOrderMethods.h
//  ShopFriendForShop
//
//  Created by Beautilut on 14-7-22.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderDetailObject.h"
#import "OrderObject.h"
@protocol WebOrderMethodsDelegate;
@interface WebOrderMethods : NSObject
{
    id <WebOrderMethodsDelegate>delegate;
}
@property(nonatomic,strong)id <WebOrderMethodsDelegate> delegate;
+(WebOrderMethods*)sharedOrder;
-(void)webOrderInsert:(NSDictionary*)dic;
-(void)webOrderUpdate:(NSDictionary*)dic;
@end
@protocol WebOrderMethodsDelegate  <NSObject>
//webOrderInsert
-(void)webOrderInsertSuccess;
-(void)webOrderInsertFail;
//webOrderUpdate
-(void)webOrderUpdateSuccess;
-(void)webOrderUpdateFail;
@end