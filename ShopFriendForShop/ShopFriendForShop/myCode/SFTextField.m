//
//  SFTextField.m
//  ShopFriendForShop
//
//  Created by Beautilut on 14-7-3.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import "SFTextField.h"

@implementation SFTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)drawPlaceholderInRect:(CGRect)rect
{
    CGRect placeRect=CGRectMake(rect.origin.x, (rect.size.height- self.font.pointSize)/2-2, rect.size.width, self.font.pointSize+2);
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineBreakMode = NSLineBreakByTruncatingTail;
    style.alignment = self.textAlignment;
    NSDictionary *attr = [NSDictionary dictionaryWithObjectsAndKeys:style,NSParagraphStyleAttributeName, self.font, NSFontAttributeName,[UIColor grayColor], NSForegroundColorAttributeName, nil];
    
    [self.placeholder drawInRect:placeRect withAttributes:attr];
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
