//
//  DateCell.m
//  ShopFriendForShop
//
//  Created by Beautilut on 14-8-22.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import "DateCell.h"

@implementation DateCell
@synthesize datelabel,namelabel;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
