//
//  WebMenuMethods.m
//  ShopFriendForShop
//
//  Created by Beautilut on 14-7-12.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import "WebMenuMethods.h"
static WebMenuMethods*shareMenu;
@implementation WebMenuMethods
@synthesize delegate;
+(WebMenuMethods*)sharedMenu
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareMenu=[[WebMenuMethods alloc] init];
    });
    return shareMenu;
}
-(void)webMenuInsert:(NSDictionary*)dic
{
    //data
    NSString*name=[dic objectForKey:@"goodName"];
    NSNumber*price=[dic objectForKey:@"goodPrice"];
    NSString*categoryID=[dic objectForKey:@"goodCategory"];
    NSArray*photoArray=[dic objectForKey:@"goodPhoto"];
    NSString*info=[dic objectForKey:@"goodInfo"];
    NSString*shopID=[dic objectForKey:@"shopID"];
    NSNumber*count=[NSNumber numberWithInt:photoArray.count];
    //
    NSURL*url=[NSURL URLWithString:menuInsertURL];
    ASIFormDataRequest*request=[ASIFormDataRequest requestWithURL:url];
    [request setPostValue:shopID forKey:@"shopID"];
    [request setPostValue:name forKey:@"goodName"];
    [request setPostValue:price forKey:@"goodPrice"];
    [request setPostValue:categoryID forKey:@"goodCategory"];
    [request setPostValue:count forKey:@"photoCount"];
    [request setPostValue:info forKey:@"goodInfo"];
    for (int i=0; i<[count intValue]; i++) {
        UIImage*image=[photoArray objectAtIndex:i];
        NSData*imagedata=UIImageJPEGRepresentation(image,0.4f);
        NSString*key=[NSString stringWithFormat:@"photo%d",i];
        [request setData:imagedata withFileName:@"menuPhoto.jpg" andContentType:@"image/jpeg " forKey:key];
    }
    [request setCompletionBlock:^{
        SBJsonParser*parser=[[SBJsonParser alloc] init];
        NSDictionary*dic=[parser objectWithString:request.responseString];
        if ([[dic objectForKey:@"back"] integerValue]==1) {
            MenuObject*menu=[[MenuObject alloc] init];
            [menu setGoodID:[dic objectForKey:@"goodID"]];
            [menu setCategoryID:categoryID];
            [menu setGoodName:name];
            [menu setGoodPrice:price];
            [menu setGoodPhotoCount:count];
            [menu setGoodInfo:info];
            [menu setGoodOnSale:[NSNumber numberWithInt:1]];
            [MenuObject saveNewGood:menu];
            if ([delegate respondsToSelector:@selector(webMenuInsertSuccess:)]) {
                [delegate webMenuInsertSuccess];
            }
            [delegate webMenuInsertSuccess];
        }
    }];
    [request setFailedBlock:^{
        if ([delegate respondsToSelector:@selector(webMenuInsertFail)]) {
            [delegate webMenuInsertFail];
        }
    }];
    [request startAsynchronous];
}
-(void)webMenuChange:(NSDictionary*)dic
{
    //data
    NSString*goodID=[dic objectForKey:@"goodID"];
    NSNumber*oldNumber=[dic objectForKey:@"oldCount"];
    NSString*shopID=[dic objectForKey:@"shopID"];
    NSString*name=[dic objectForKey:@"goodName"];
    NSNumber*price=[dic objectForKey:@"goodPrice"];
    NSString*info=[dic objectForKey:@"goodInfo"];
    NSString*category=[dic objectForKey:@"goodCategory"];
    NSArray*photoArray=[dic objectForKey:@"goodPhoto"];
    NSNumber*count=[NSNumber numberWithInt:photoArray.count];
    NSURL*url=[NSURL URLWithString:menuChangeURL];
    ASIFormDataRequest*request=[ASIFormDataRequest requestWithURL:url];
    [request setPostValue:goodID forKey:@"goodID"];
    [request setPostValue:oldNumber forKey:@"oldCount"];
    [request setPostValue:shopID forKey:@"shopID"];
    [request setPostValue:name forKey:@"goodName"];
    [request setPostValue:price forKey:@"goodPrice"];
    [request setPostValue:category forKey:@"goodCategory"];
    [request setPostValue:count forKey:@"photoCount"];
    [request setPostValue:info forKey:@"goodInfo"];
    for (int i=0; i<[count intValue]; i++) {
        UIImage*image=[photoArray objectAtIndex:i];
        NSData*imagedata=UIImageJPEGRepresentation(image,0.4f);
        NSString*key=[NSString stringWithFormat:@"photo%d",i];
        [request setData:imagedata withFileName:@"menuPhoto.jpg" andContentType:@"image/jpeg " forKey:key];
    }
    [request setCompletionBlock:^{
        SBJsonParser*parser=[[SBJsonParser alloc] init];
        NSDictionary*dic=[parser objectWithString:request.responseString];
        if ([[dic objectForKey:@"back"] integerValue]==1) {
            MenuObject*menu=[[MenuObject alloc] init];
            [menu setGoodID:goodID];
            [menu setGoodName:name];
            [menu setGoodPrice:price];
            [menu setGoodPhotoCount:count];
            [menu setGoodInfo:info];
            [MenuObject updateGood:menu];
            if ([delegate respondsToSelector:@selector(webMenuChangeSuccess)]) {
                [delegate webMenuChangeSuccess];
            }
        }
    }];
    [request setFailedBlock:^{
        if ([delegate respondsToSelector:@selector(webMenuChangeFail)]) {
            [delegate webMenuChangeFail];
        }
    }];
    [request startAsynchronous];
}
@end
