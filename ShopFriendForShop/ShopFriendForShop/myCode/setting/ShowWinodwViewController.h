//
//  ShowWinodwViewController.h
//  ShopFriendForShop
//
//  Created by Beautilut on 14-4-18.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VPImageCropperViewController.h"
@interface ShowWinodwViewController : UIViewController<UIScrollViewDelegate,UIActionSheetDelegate,VPImageCropperDelegate,UINavigationBarDelegate,UIImagePickerControllerDelegate>
{
    UIScrollView*imageScroll;
}
@property(nonatomic,strong)UIScrollView*imageScroll;
@end
