//
//  MenuCategoryCell.h
//  ShopFriendForShop
//
//  Created by Beautilut on 14-6-19.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuCategoryCell : UITableViewCell
{
    IBOutlet UILabel*nameLabel;
}
@property(nonatomic,retain) IBOutlet UILabel *nameLabel;
-(void)setName:(NSString*)name;
@end