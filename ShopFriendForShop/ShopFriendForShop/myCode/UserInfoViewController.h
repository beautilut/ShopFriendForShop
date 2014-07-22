//
//  UserInfoViewController.h
//  ShopFriendForShop
//
//  Created by Beautilut on 14-4-23.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserInfoViewController : UIViewController
@property(nonatomic,retain) NSDictionary*user;
-(void)getUserInfo:(NSDictionary*)info;
@end
