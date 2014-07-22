//
//  MenuMainViewController.h
//  ShopFriendForShop
//
//  Created by Beautilut on 14-2-12.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWTableViewCell.h"
@interface MenuMainViewController : UIViewController<SWTableViewCellDelegate,UITableViewDataSource,UITableViewDelegate>
-(void)postInfo:(CategoryModel*)model;
@end
