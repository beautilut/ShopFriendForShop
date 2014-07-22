//
//  MenuInfoCell.h
//  ShopFriendForShop
//
//  Created by Beautilut on 14-5-28.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuInfoCell : UITableViewCell
{
    IBOutlet UILabel*namelabel;
    IBOutlet UITextView*menuInfo;
}
@property(nonatomic,retain) IBOutlet UILabel*namelabel;
@property(nonatomic,retain) IBOutlet UITextView*menuInfo;
@end
