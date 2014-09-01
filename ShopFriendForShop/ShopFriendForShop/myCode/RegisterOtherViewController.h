//
//  RegisterOtherViewController.h
//  ShopFriendForShop
//
//  Created by Beautilut on 14-1-23.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VPImageCropperViewController.h"
@interface RegisterOtherViewController : UIViewController<UIAlertViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,VPImageCropperDelegate,UINavigationControllerDelegate,WebShopMethodsDelegate>
{

}
-(IBAction)done:(id)sender;
-(void)getSendFromMain:(NSDictionary*)dic;
@end
