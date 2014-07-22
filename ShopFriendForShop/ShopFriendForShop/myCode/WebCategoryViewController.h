//
//  WebCategoryViewController.h
//  ShopFriendForShop
//
//  Created by Beautilut on 14-3-15.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol WebCategoryViewControllerDelegate;
@interface WebCategoryViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    id <WebCategoryViewControllerDelegate> delegate;
}
@property(nonatomic,strong) id <WebCategoryViewControllerDelegate> delegate;
@end
@protocol WebCategoryViewControllerDelegate <NSObject>

-(void)choose:(NSArray*)array;
@end