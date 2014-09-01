//
//  InfoManager.m
//  ShopFriendForShop
//
//  Created by Beautilut on 14-3-13.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import "InfoManager.h"
#import <AudioToolbox/AudioToolbox.h>
static InfoManager*sharedManager;
@implementation InfoManager
@synthesize myShop,deviceToken,settingDic;
+(InfoManager*)sharedInfo
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager=[[InfoManager alloc] init];
        sharedManager.myShop=[[ShopObject alloc] init];
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Setting" ofType:@"plist"];
        sharedManager.settingDic=[[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    });
    return sharedManager;
}
-(void)getShopInfo
{
    NSString*hostID=[[NSUserDefaults standardUserDefaults] objectForKey:kXMPPmyJID];
    BOOL  worked = [ShopObject haveSaveShopByID:hostID];
    if (worked) {
        myShop=[ShopObject fetchShopInfo];
    }else
    {
        ASIFormDataRequest*request=[ASIFormDataRequest requestWithURL:[NSURL URLWithString:getMyShopInfo]];
        [request setPostValue:hostID forKey:@"shopID"];
        [request setCompletionBlock:^{
            SBJsonParser*paser=[[SBJsonParser alloc] init];
            NSDictionary*rootDic=[paser objectWithString:request.responseString];
            NSDictionary*webDic=[[rootDic objectForKey:@"data"] objectAtIndex:0];
            myShop=[self webDicIntoDiskDic:webDic];
            [ShopObject saveNewShop:myShop];
            [self getMenuInfo:hostID];
        }];
        [request setFailedBlock:^{
            
        }];
        [request startAsynchronous];
        
    }
}

-(void)updateInfo
{
    NSString*hostID=[[NSUserDefaults standardUserDefaults] objectForKey:kXMPPmyJID];
    ASIFormDataRequest*request=[ASIFormDataRequest requestWithURL:[NSURL URLWithString:getMyShopInfo]];
    [request setPostValue:hostID forKey:@"shopID"];
    [request setCompletionBlock:^{
        SBJsonParser*paser=[[SBJsonParser alloc] init];
        NSDictionary*rootDic=[paser objectWithString:request.responseString];
        NSDictionary*webDic=[[rootDic objectForKey:@"data"] objectAtIndex:0];
        myShop=[self webDicIntoDiskDic:webDic];
    }];
    [request setFailedBlock:^{
        
    }];
    [request startAsynchronous];
}
-(ShopObject*)webDicIntoDiskDic:(NSDictionary*)dic
{
    ShopObject *newShop=[[ShopObject alloc] init];
    [newShop setShopID:[dic objectForKey:@"shop_ID"]];
    [newShop setShopCategory:[dic objectForKey:@"shop_category"]];
    [newShop setShopName:[dic objectForKey:@"shop_name"]];
    [newShop setShopAddress:[dic objectForKey:@"shop_address"]];
    [newShop setShopTel:[dic objectForKey:@"shop_tel"]];
    [newShop setShopCategoryWord:[dic objectForKey:@"shop_category_word"]];
    [newShop setShopOpenTime:[dic objectForKey:@"shop_opening_time"]];
    [newShop setShopCategoryDetail:[dic objectForKey:@"shop_category_detail"]];
    return newShop;
}
-(CategoryModel*)webCategoryIntoDiskDic:(NSDictionary*)dic
{
    CategoryModel*newCategory=[[CategoryModel alloc] init];
    [newCategory setCategoryID:[dic objectForKey:@"menu_categoryID"]];
    [newCategory setCategoryName:[dic objectForKey:@"menu_category"]];
    [newCategory setCategoryRank:[dic objectForKey:@"menu_rank"]];
    return newCategory;
}
-(MenuObject*)webMenuIntoDiskDic:(NSDictionary*)dic withCategoryID:(NSString*)categoryID
{
    MenuObject*newMenu=[[MenuObject alloc] init];
    [newMenu setCategoryID:categoryID];
    [newMenu setGoodName:[dic objectForKey:@"good_name"]];
    [newMenu setGoodPhotoCount:[dic objectForKey:@"good_photo_count"]];
    //[newMenu setGoodMD5:[MenuObject md5:[dic objectForKey:@"good_name"]]];
    [newMenu setGoodID:[dic objectForKey:@"good_ID"]];
    [newMenu setGoodPrice:[dic objectForKey:@"good_price"]];
    [newMenu setGoodInfo:[dic objectForKey:@"good_info"]];
    [newMenu setGoodOnSale:[dic objectForKey:@"good_onsale"]];
    [newMenu setGoodRank:[dic objectForKey:@"good_rank"]];
    return  newMenu;
}
-(void)getMenuInfo:(NSString*)shopID
{
    ASIFormDataRequest*request=[ASIFormDataRequest requestWithURL:[NSURL URLWithString:menuGetURL]];
    [request setPostValue:shopID forKey:@"shopID"];
    [request setCompletionBlock:^{
        SBJsonParser*paser=[[SBJsonParser alloc] init];
        NSDictionary*rootDic=[paser objectWithString:request.responseString];
        NSArray*array=[rootDic objectForKey:@"category"];
        for (NSDictionary* categoryDic in array) {
            BOOL worked=[CategoryModel haveSaveCategoryByID:[categoryDic objectForKey:@"menu_categoryID"]];
            CategoryModel*newCategory=[self webCategoryIntoDiskDic:categoryDic];
            newCategory.shopID=shopID;
            if (worked) {
                [CategoryModel updateCategory:newCategory];
            }else
            {
                [CategoryModel saveNewCategory:newCategory];
            }
            NSString*categoryID=[categoryDic objectForKey:@"menu_categoryID"];
            NSArray*menuArray=[rootDic objectForKey:categoryID];
            for (NSDictionary*menuDic in menuArray) {
                BOOL worked=[MenuObject haveSaveGoodById:[menuDic objectForKey:@"good_ID"]];
                MenuObject*newMenu=[self webMenuIntoDiskDic:menuDic withCategoryID:categoryID];
                if (worked) {
                    [MenuObject updateGood:newMenu];
                }else
                {
                    [MenuObject saveNewGood:newMenu];
                }
            }
        }
    }];
    [request setFailedBlock:^{
        
    }];
    [request startAsynchronous];
}
#pragma mark -getShopLogo-
-(void)saveUserImage:(UIImage *)image
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    /*写入图片*/
    //帮文件起个名
    NSString*hostID=[[NSUserDefaults standardUserDefaults] objectForKey:kXMPPmyJID];
    NSString*name=[NSString stringWithFormat:@"shopLogo%@.png",hostID];
    NSString *uniquePath=[[paths objectAtIndex:0] stringByAppendingPathComponent:name];
    //将图片写到Documents文件中
    [UIImagePNGRepresentation(image)writeToFile: uniquePath    atomically:YES];
    
}
-(UIImage*)getShopLogo
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    /*写入图片*/
    //帮文件起个名
    NSString*hostID=[[NSUserDefaults standardUserDefaults] objectForKey:kXMPPmyJID];
    NSString*name=[NSString stringWithFormat:@"shopLogo%@.png",hostID];
    NSString *uniquePath=[[paths objectAtIndex:0] stringByAppendingPathComponent:name];
    NSData *data=[NSData dataWithContentsOfFile:uniquePath];
    //直接把该图片读出来
    UIImage*image=[UIImage imageWithData:data];
    return image;
}
#pragma mark Token
-(void)updateToken:(NSString*)token
{
    NSURL*url=[NSURL URLWithString:tokenUp];
    ASIFormDataRequest*request=[[ASIFormDataRequest alloc] initWithURL:url];
    [request setPostValue:token forKey:@"deviceToken"];
    [request setCompletionBlock:^{
        SBJsonParser*parser=[[SBJsonParser alloc] init];
        NSDictionary *dic=[parser objectWithString:request.responseString];
        if ([[dic objectForKey:@"back"] integerValue]==1) {
            
        }
    }];
    [request setFailedBlock:^{
        
    }];
    [request startAsynchronous];
}
-(void)registerToken
{
    NSString*deviceToken=[[NSUserDefaults standardUserDefaults]objectForKey:@"deviceToken"];
    NSString*hostID=[[NSUserDefaults standardUserDefaults] objectForKey:kXMPPmyJID];
    NSURL*url=[NSURL URLWithString:tokenRegister];
    ASIFormDataRequest*request=[[ASIFormDataRequest alloc] initWithURL:url];
    [request setPostValue:deviceToken forKey:@"deviceToken"];
    [request setPostValue:hostID forKey:@"id"];
    [request setPostValue:@"shop" forKey:@"kind"];
    [request setCompletionBlock:^{
        SBJsonParser*parser=[[SBJsonParser alloc] init];
        NSDictionary *dic=[parser objectWithString:request.responseString];
        if ([[dic objectForKey:@"back"] integerValue]==1) {
            
        }
    }];
    [request setFailedBlock:^{
        
    }];
    [request startAsynchronous];
}
#pragma mark plistController
-(void)writeInfoFile
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"setting" ofType:@"plist"];
    [settingDic writeToFile:plistPath atomically:YES];
}
-(BOOL)checkSetting:(NSString *)NSString
{
    return [[settingDic objectForKey:NSString] boolValue];
}
-(void)playAudio:(NSString*)string
{
    SystemSoundID sound;
    if ([string isEqualToString:@"message"]) {
        if ([[settingDic objectForKey:@"messageSound"] boolValue]) {
            NSString *path = [NSString stringWithFormat:@"/System/Library/Audio/UISounds/sms-received1.caf"];
            CFURLRef thesoundURL = (__bridge CFURLRef)[NSURL fileURLWithPath:path];
            OSStatus error = AudioServicesCreateSystemSoundID((CFURLRef)thesoundURL,&sound);
            AudioServicesPlaySystemSound(sound);
        }
        if ([[settingDic objectForKey:@"messageShack"] boolValue]) {
            sound = kSystemSoundID_Vibrate;
            AudioServicesPlaySystemSound(sound);
        }
    }
    if ([string isEqualToString:@"order"]) {
        if ([[settingDic objectForKey:@"orderSound"] boolValue]) {
            NSString *path = [NSString stringWithFormat:@"/System/Library/Audio/UISounds/sms-received1.caf"];
            CFURLRef thesoundURL = (__bridge CFURLRef)[NSURL fileURLWithPath:path];
            OSStatus error = AudioServicesCreateSystemSoundID((CFURLRef)thesoundURL,&sound);
            AudioServicesPlaySystemSound(sound);
        }
        if ([[settingDic objectForKey:@"orderShack"] boolValue]) {
            sound = kSystemSoundID_Vibrate;
            AudioServicesPlaySystemSound(sound);
        }

    }
    
}

@end
