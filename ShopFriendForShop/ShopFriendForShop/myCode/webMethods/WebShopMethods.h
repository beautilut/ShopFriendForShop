//
//  WebShopMethods.h
//  ShopFriendForShop
//
//  Created by Beautilut on 14-8-7.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol WebShopMethodsDelegate;
@interface WebShopMethods : NSObject
{
    id <WebShopMethodsDelegate> delegate;
}
@property(nonatomic,strong) id <WebShopMethodsDelegate> delegate;
+(WebShopMethods*)share;
-(void)getInvitation:(NSString*)string;
-(void)inviation:(NSString*)phone withInvitation:(NSString*)number;
-(void)enter:(NSDictionary*)dic;
-(void)shopRegister:(NSDictionary*)dic;
@end
@protocol WebShopMethodsDelegate <NSObject>

//enterDelegate
-(void)enterSuccess;
-(void)enterFail;
-(void)enterPasswordError;
//registerDelegate
-(void)registerSuccess;
-(void)registerFail;
//invitation
-(void)invitationSuccess;
-(void)invitationFail:(NSString*)note;
@end