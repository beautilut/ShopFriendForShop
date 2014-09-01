//
//  ServerDetailViewController.h
//  ShopFriendForShop
//
//  Created by Beautilut on 14-8-20.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ServerDetailViewController : UIViewController<UITextFieldDelegate,UITextViewDelegate,webServerMethodsDelegate,UITableViewDataSource,UITableViewDelegate>
{
    NSDictionary*detailInfo;
}
@property(nonatomic,retain) NSDictionary*detailInfo;
-(void)getServerDetailInfo:(NSDictionary*)dic;
@end
