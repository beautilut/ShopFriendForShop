//
//  AddMenuViewController.h
//  ShopFriendForShop
//
//  Created by Beautilut on 14-2-13.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebMenuMethods.h"
#import "VPImageCropperViewController.h"
@interface AddMenuViewController : UIViewController<VPImageCropperDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UINavigationControllerDelegate,UITextViewDelegate,WebMenuMethodsDelegate,webServerMethodsDelegate>
{
    
}
-(void)getInfo:(id)sender;
@end
