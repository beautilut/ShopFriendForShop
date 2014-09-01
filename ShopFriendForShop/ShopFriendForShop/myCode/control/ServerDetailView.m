//
//  ServerDetailView.m
//  ShopFriendForShop
//
//  Created by Beautilut on 14-8-18.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import "ServerDetailView.h"

@implementation ServerDetailView
@synthesize delegate;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)setImage:(NSString*)imagePath with:(NSDictionary*)adic
{
    UIImageView*imageView=[[UIImageView alloc] initWithFrame:CGRectMake(5, 3, 60, 60)];
    [imageView setBackgroundColor:[UIColor clearColor]];
    NSString*string=[NSString stringWithFormat:@"%@%@/serverLogo60.png",imagePath,[adic objectForKey:@"server_ID"]];
    [imageView setImageWithURL:[NSURL URLWithString:string]];
    imageView.layer.masksToBounds = YES;
    imageView.layer.cornerRadius = 30.0;
    imageView.layer.borderWidth = 1.0;
    imageView.layer.borderColor = [[UIColor greenColor] CGColor];
    [self addSubview:imageView];
    UILabel*name=[[UILabel alloc] initWithFrame:CGRectMake(0, 66, 70, 14)];
    [name setTextAlignment:NSTextAlignmentCenter];
    [name setTextColor:[UIColor colorWithRed:0.1 green:0.68 blue:0.86 alpha:1.0]];
    [name setFont:[UIFont systemFontOfSize:14.0f]];
    [name  setText:[adic objectForKey:@"server_name"]];
    [self addSubview:name];
    [self addTarget:self action:@selector(serverViewTouch:) forControlEvents:UIControlEventTouchDown];
}
-(void)serverViewTouch:(id)sender
{
    if ([delegate respondsToSelector:@selector(serverDetailViewTouchDown:)]) {
        [delegate serverDetailViewTouchDown:self.tag];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
