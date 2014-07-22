//
//  ShopWindowButton.m
//  ShopFriendForShop
//
//  Created by Beautilut on 14-4-18.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import "ShopWindowButton.h"

@implementation ShopWindowButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(id)init:(int)number with:(CGRect)frame
{
    buttonNumber=[NSNumber numberWithInt:number];
    self=[super initWithFrame:frame];
    self.layer.borderColor=[UIColor orangeColor].CGColor;
    self.layer.borderWidth=2;
    if (self) {
        buttonImage=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        NSString*hostID=[[NSUserDefaults standardUserDefaults]objectForKey:kXMPPmyJID];
        [self addSubview:buttonImage];
        
        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:SHOP_WINDOW(hostID, number)] options:0 progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
            [buttonImage setImage:image];
        }];
    }
    return self;
}
-(NSNumber*)getNumber
{
    return buttonNumber;
}
-(void)deleteImage
{
    NSURL*url=[NSURL URLWithString:shopWindowImageChange];
    ASIFormDataRequest*request=[ASIFormDataRequest requestWithURL:url];
    NSString*hostID=[[NSUserDefaults standardUserDefaults]objectForKey:kXMPPmyJID];
    [request setPostValue:hostID forKey:@"shopID"];
    [request setPostValue:buttonNumber forKey:@"number"];
    [request setCompletionBlock:^{
        SBJsonParser*parser=[[SBJsonParser alloc] init];
        NSDictionary*dic=[parser objectWithString:request.responseString];
        if ([[dic objectForKey:@"back"] integerValue]==1) {
            [buttonImage setImage:nil];
        }
    }];
    [request setFailedBlock:^{
        
    }];
    [request startAsynchronous];
}
-(void)changeImage:(UIImage *)image
{
    NSURL*url=[NSURL URLWithString:shopWindowImageChange];
    ASIFormDataRequest*request=[ASIFormDataRequest requestWithURL:url];
    NSString*hostID=[[NSUserDefaults standardUserDefaults]objectForKey:kXMPPmyJID];
    [request setPostValue:hostID forKey:@"shopID"];
    [request setPostValue:buttonNumber forKey:@"number"];
    NSData*imageData=UIImageJPEGRepresentation(image, 0.4f);
    [request setData:imageData withFileName:@"shopwWindow" andContentType:@"image/jpeg" forKey:@"image"];
    [request setCompletionBlock:^{
        SBJsonParser*parser=[[SBJsonParser alloc] init];
        NSDictionary*dic=[parser objectWithString:request.responseString];
        if ([[dic objectForKey:@"back"] integerValue]==1) {
        [buttonImage setImage:image];
        }
    }];
    [request setFailedBlock:^{
        
    }];
    [request startAsynchronous];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
