//
//  InfoChangeViewController.h
//  ShopFriendForShop
//
//  Created by Beautilut on 14-4-16.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebCategoryViewController.h"
#import "BMapKit.h"
@interface InfoChangeViewController : UIViewController<BMKSearchDelegate,UITextFieldDelegate,UITextViewDelegate,UITableViewDataSource,UITableViewDelegate,WebCategoryViewControllerDelegate>
-(void)getInfoKind:(NSString*)kind;
@end
