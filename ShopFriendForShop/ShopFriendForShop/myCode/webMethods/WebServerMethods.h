//
//  WebServerMethods.h
//  ShopFriendForShop
//
//  Created by Beautilut on 14-8-15.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol webServerMethodsDelegate;
@interface WebServerMethods : NSObject
{
    id <webServerMethodsDelegate> delegate;
}
@property(nonatomic,strong) id <webServerMethodsDelegate> delegate;
+(WebServerMethods*)shared;
-(void)getServerList;
-(void)showMyServer:(NSString*)kind;
-(void)getGoodServer:(NSString*)goodID;
-(void)changeServerRange:(NSString*)range withInfo:(NSString*)info with:(NSDictionary*)dic;
-(void)registerServer:(NSDictionary*)dic;
@end
@protocol webServerMethodsDelegate <NSObject>
//get
-(void)getServerListSuccess:(NSDictionary*)dic;
-(void)getServerListFial;
//show
-(void)showMyServerSuccess:(NSDictionary*)dic;
-(void)showMyServerFail;
//register
-(void)registerServerAccept;
-(void)registerServerFail;
//change
-(void)changeServerSuccess;
-(void)changeServerFail;
//good
-(void)getGoodServerSuccess:(NSDictionary*)dic;
-(void)getGoodServerFail;
@end