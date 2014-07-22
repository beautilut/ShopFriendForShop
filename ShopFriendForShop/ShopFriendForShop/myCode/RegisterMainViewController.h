//
//  RegisterMainViewController.h
//  ShopFriendForShop
//
//  Created by Beautilut on 14-1-23.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"
#import "WebCategoryViewController.h"
@interface RegisterMainViewController : UIViewController<UITextFieldDelegate,BMKSearchDelegate,UITableViewDelegate,UITableViewDataSource,WebCategoryViewControllerDelegate>
{

}
- (IBAction)allResignFirstresponse:(id)sender;
-(void)setPhoneNumber:(NSString*)number;
@end
