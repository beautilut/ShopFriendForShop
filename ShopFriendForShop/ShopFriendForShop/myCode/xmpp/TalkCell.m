//
//  TalkCell.m
//  shopFriend
//
//  Created by Beautilut on 14-1-16.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import "TalkCell.h"

@implementation TalkCell
@synthesize data,talkView,name,content;
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

@end
