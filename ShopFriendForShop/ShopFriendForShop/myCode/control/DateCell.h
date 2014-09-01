//
//  DateCell.h
//  ShopFriendForShop
//
//  Created by Beautilut on 14-8-22.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DateCell : UITableViewCell
{
    IBOutlet UILabel*namelabel;
    IBOutlet UILabel*datelabel;
}
@property(nonatomic,retain) IBOutlet UILabel*namelabel;
@property(nonatomic,retain) IBOutlet UILabel*datelabel;
@end
