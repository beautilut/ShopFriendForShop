//
//  InfoManager.h
//  ShopFriendForShop
//
//  Created by Beautilut on 14-3-13.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InfoManager : NSObject
{
    ShopObject*myShop;
}
@property(nonatomic,retain) ShopObject*myShop;
+(InfoManager*)sharedInfo;
#pragma mark -setinfo-
-(void)getShopInfo;
#pragma mark -changeInfo-
#pragma mark -getShopLogo-
-(void)saveUserImage:(UIImage *)image;
-(UIImage*)getShopLogo;
@end
