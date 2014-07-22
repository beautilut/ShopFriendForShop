//
//  PasswordCheckViewController.h
//  ShopFriendForShop
//
//  Created by Beautilut on 14-4-16.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PasswordCheckViewControllerDelegate;
@interface PasswordCheckViewController : UIViewController<UITextFieldDelegate>
{
    id <PasswordCheckViewControllerDelegate> delegate;
}
@property(nonatomic,strong) id<PasswordCheckViewControllerDelegate>delegate;
@end
@protocol PasswordCheckViewControllerDelegate <NSObject>
-(void)passwordCheckON:(id)sender;
@end
