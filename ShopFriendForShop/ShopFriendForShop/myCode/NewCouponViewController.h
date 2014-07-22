//
//  NewCouponViewController.h
//  ShopFriendForShop
//
//  Created by Beautilut on 14-7-1.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol NewCouponViewControllerDelegate;
@interface NewCouponViewController : UIViewController<UITextFieldDelegate,UITextViewDelegate>
{
    id <NewCouponViewControllerDelegate> delegate;
}
@property(nonatomic,strong) id<NewCouponViewControllerDelegate>delegate;
@end

@protocol NewCouponViewControllerDelegate <NSObject>

@end