//
//  WebShopMethods.m
//  ShopFriendForShop
//
//  Created by Beautilut on 14-8-7.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import "WebShopMethods.h"
#import "FMDatabase.h"
#import "FMResultSet.h"
static WebShopMethods*shareShop;
@implementation WebShopMethods
@synthesize delegate;
+(WebShopMethods*)share
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareShop=[[WebShopMethods alloc] init];
    });
    return shareShop;
}
-(void)enter:(NSDictionary*)dic
{
    //data
    NSString*shopID=[dic objectForKey:@"shopID"];
    NSString*password=[dic objectForKey:@"password"];
    //web
    NSURL*url=[NSURL URLWithString:enterURL];
    ASIFormDataRequest*request=[ASIFormDataRequest requestWithURL:url];
    [request setPostValue:shopID forKey:@"shopID"];
    [request setPostValue:password forKey:@"shopPassword"];
    [request setCompletionBlock:^{
        SBJsonParser*parser=[[SBJsonParser alloc] init];
        NSDictionary*dic=[parser objectWithString:request.responseString];
        if ([[dic objectForKey:@"back"] integerValue]==1) {
            //NSString*string=[NSString stringWithFormat:@"",shopID.textField.text];
            [[NSUserDefaults standardUserDefaults] setObject:shopID forKey:kXMPPmyJID];
            [[NSUserDefaults standardUserDefaults] setObject:password forKey:kXMPPmyPassword];
            [[SFXMPPManager sharedInstance] connect];
            [[InfoManager sharedInfo] getShopInfo];
            UIImage*image=[[InfoManager sharedInfo] getShopLogo];
            if (image==nil) {
                SDWebImageManager *manager = [SDWebImageManager sharedManager];
                NSURL*url=[NSURL URLWithString:SHOP_LOGO(shopID)];
                [manager downloadWithURL:url options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished)
                 {
                     //[[SDImageCache sharedImageCache] storeImage:image forKey:shopLogoKey toDisk:YES];
                     [[InfoManager sharedInfo] saveUserImage:image];
                     [[NSNotificationCenter defaultCenter] postNotificationName:@"logoGet" object:nil];
                 }];
            }
            if ([delegate respondsToSelector:@selector(enterSuccess)]) {
                [[InfoManager sharedInfo] registerToken];
                [delegate enterSuccess];
            }
        }else{
            if ([delegate respondsToSelector:@selector(enterPasswordError)]) {
                [delegate enterPasswordError];
            }
        }
        
    }];
    [request setFailedBlock:^{
        if ([delegate respondsToSelector:@selector(enterFail)]) {
            [delegate enterFail];
        }    
    }];
    [request startAsynchronous];
}
-(void)shopRegister:(NSDictionary *)postDic
{
    NSURL*url=[NSURL URLWithString:registerURL];
    ASIFormDataRequest*request=[[ASIFormDataRequest alloc] initWithURL:url];
    for (NSString*key in [postDic allKeys]) {
        if (![key isEqualToString:@"shopLogo"]) {
            [request setPostValue:[postDic objectForKey:key] forKey:key];
        }else
        {
            UIImage*image=[postDic objectForKey:key];
            NSData*imagedata=UIImageJPEGRepresentation(image, 0.1);
            [request setData:imagedata withFileName:@"shopLogo.jpg" andContentType:@"image/jpeg " forKey:@"shopLogo"];
        }
    }
    [request setCompletionBlock:^{
        SBJsonParser*parser=[[SBJsonParser alloc] init];
        NSDictionary*dic=[parser objectWithString:request.responseString];
        if ([[dic objectForKey:@"back"] integerValue]==1) {
            NSMutableDictionary*newDic=[[NSMutableDictionary alloc] init];
            [newDic setObject:[postDic objectForKey:@"shopID"] forKey:sfShopID];
            [newDic setObject:[postDic objectForKey:@"shopName"] forKey:sfShopName];
            [newDic setObject:[postDic objectForKey:@"shopCategoryWord"] forKey:sfShopCategoryWord];
            [newDic setObject:[postDic objectForKey:@"shopCategory"] forKey:sfShopCategory];
            [newDic setObject:[postDic objectForKey:@"shopCategoryDetail"] forKey:sfShopCategoryDetail];
            [newDic setObject:[postDic objectForKey:@"shopTel"] forKey:sfShopTel];
            [newDic setObject:[postDic objectForKey:@"shopAddress"] forKey:sfShopAddress];
            ShopObject*newShop=[ShopObject shopFromDictionary:newDic];
            [ShopObject saveNewShop:newShop];
            [[NSUserDefaults standardUserDefaults] setObject:[postDic objectForKey:@"shopID"] forKey:kXMPPmyJID];
            [[NSUserDefaults standardUserDefaults] setObject:[postDic objectForKey:@"shopPassword"] forKey:kXMPPmyPassword];
            [[InfoManager sharedInfo] getShopInfo];
            [[SFXMPPManager sharedInstance] connect];
            SDWebImageManager *manager = [SDWebImageManager sharedManager];
            NSURL*url=[NSURL URLWithString:SHOP_LOGO([postDic objectForKey:@"shopID"])];
            [manager downloadWithURL:url options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished)
             {
                 [[InfoManager sharedInfo] saveUserImage:image];
                 [[NSNotificationCenter defaultCenter] postNotificationName:@"logoGet" object:nil];
             }];
            if ([delegate respondsToSelector:@selector(registerSuccess)]) {
                [delegate registerSuccess];
            }
        }else
        {
            if ([delegate respondsToSelector:@selector(registerFail)]) {
                [delegate registerFail];
            }
        }
    }];
    [request setFailedBlock:^{
        if ([delegate respondsToSelector:@selector(registerFail)]) {
            [delegate registerFail];
        }
    }];
    [request startAsynchronous];
}
#pragma mark invitation
-(void)getInvitation:(NSString*)string
{
    NSURL*url=[NSURL URLWithString:webInvitationGet];
    ASIFormDataRequest*request=[ASIFormDataRequest requestWithURL:url];
    [request setPostValue:string forKey:@"phoneNumber"];
    [request setPostValue:@"shop" forKey:@"kind"];
    [request setCompletionBlock:^{
        NSData*data=[request responseData];
        NSError*error;
        NSArray*array=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        NSLog(@"%@",array);
    }];
    [request setFailedBlock:^{
        NSLog(@"fail");
    }];
    [request startAsynchronous];
}
-(void)inviation:(NSString *)phone withInvitation:(NSString *)number
{
    ASIFormDataRequest*request=[ASIFormDataRequest requestWithURL:[NSURL URLWithString:invitation]];
    [request setPostValue:number forKey:@"invitationNumber"];
    [request setPostValue:phone forKey:@"phoneNumber"];
    [request setPostValue:@"shop" forKey:@"kind"];
    [request setCompletionBlock:^{
        SBJsonParser*parser=[[SBJsonParser alloc] init];
        NSDictionary*dic=[parser objectWithString:request.responseString];
        if ([[dic objectForKey:@"result"] intValue]==1) {
            if ([delegate respondsToSelector:@selector(invitationSuccess)]) {
                [delegate invitationSuccess];
            }
        }else{
            if ([delegate respondsToSelector:@selector(invitationFail:)]) {
                [delegate invitationFail:[dic objectForKey:@"note"]];
            }
        }
    }];
    [request setFailedBlock:^{
        if ([delegate respondsToSelector:@selector(invitationFail:)]) {
            [delegate invitationFail:nil];
        }
    }];
    [request startAsynchronous];
}
@end
