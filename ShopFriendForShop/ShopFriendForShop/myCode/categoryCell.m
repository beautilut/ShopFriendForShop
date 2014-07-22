//
//  categoryCell.m
//  ShopFriendForShop
//
//  Created by Beautilut on 14-2-24.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import "categoryCell.h"

@implementation categoryCell
@synthesize detailLabel;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setCategory:(NSString*)string
{
    [detailLabel setText:string];
}
@end
