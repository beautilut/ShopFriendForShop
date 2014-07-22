//
//  ShopWindowButton.h
//  ShopFriendForShop
//
//  Created by Beautilut on 14-4-18.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopWindowButton : UIButton
{
    NSNumber*buttonNumber;
    UIImageView*buttonImage;
}
-(id)init:(int)number with:(CGRect)frame;
-(NSNumber*)getNumber;
-(void)deleteImage;
-(void)changeImage:(UIImage*)image;
@end
