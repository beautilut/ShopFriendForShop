//
//  categoryCell.h
//  ShopFriendForShop
//
//  Created by Beautilut on 14-2-24.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface categoryCell : UITableViewCell
{
    IBOutlet UILabel*detailLabel;
}
@property(nonatomic,retain)IBOutlet UILabel*detailLabel;
-(void)setCategory:(NSString*)string;
@end
