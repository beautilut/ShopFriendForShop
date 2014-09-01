//
//  OrderListViewController.h
//  ShopFriendForShop
//
//  Created by Beautilut on 14-8-6.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebOrderMethods.h"
#import "SWTableViewCell.h"
@interface OrderListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,WebOrderMethodsDelegate,SWTableViewCellDelegate>

@end
