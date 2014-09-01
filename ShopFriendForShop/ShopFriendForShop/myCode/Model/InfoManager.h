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
    NSData*deviceToken;
    NSMutableDictionary*settingDic;
}
@property(nonatomic,retain) ShopObject*myShop;
@property(nonatomic,retain) NSData*deviceToken;
@property(nonatomic,retain) NSMutableDictionary*settingDic;
+(InfoManager*)sharedInfo;
-(void)writeInfoFile;
#pragma mark -setinfo-
-(void)getShopInfo;
#pragma mark -changeInfo-
#pragma mark -getShopLogo-
-(void)saveUserImage:(UIImage *)image;
-(UIImage*)getShopLogo;
#pragma mark updateToken
-(void)updateToken:(NSString*)token;
-(void)registerToken;

#pragma mark checkSetting
-(void)playAudio:(NSString*)string;
@end
