//
//  WebMenuMethods.h
//  ShopFriendForShop
//
//  Created by Beautilut on 14-7-12.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol WebMenuMethodsDelegate;
@interface WebMenuMethods : NSObject
{
    id<WebMenuMethodsDelegate> delegate;
}
@property(nonatomic,strong) id <WebMenuMethodsDelegate> delegate;
+(WebMenuMethods*)sharedMenu;
-(void)webMenuInsert:(NSDictionary*)dic;
-(void)webMenuChange:(NSDictionary*)dic;
@end
@protocol WebMenuMethodsDelegate <NSObject>
//webMenuInsert
-(void)webMenuInsertSuccess;
-(void)webMenuInsertFail;
//webMenuChange
-(void)webMenuChangeSuccess;
-(void)webMenuChangeFail;
@end