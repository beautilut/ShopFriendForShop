//
//  NewCouponViewController.h
//  ShopFriendForShop
//
//  Created by Beautilut on 14-7-1.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DatePickViewController.h"
#import "VPImageCropperViewController.h"
@protocol NewCouponViewControllerDelegate;
@interface NewCouponViewController : UIViewController<UITextFieldDelegate,UITextViewDelegate,UITableViewDataSource,UITableViewDelegate,DatePickDelegate,UIActionSheetDelegate,VPImageCropperDelegate,UINavigationControllerDelegate,WebCouponMethodsDelegate>
{
    id <NewCouponViewControllerDelegate> delegate;
}
@property(nonatomic,strong) id<NewCouponViewControllerDelegate>delegate;
-(void)getCoupon:(NSDictionary*)dic;
@end

@protocol NewCouponViewControllerDelegate <NSObject>

@end