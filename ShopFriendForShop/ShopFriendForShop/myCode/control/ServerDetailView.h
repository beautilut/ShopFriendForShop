//
//  ServerDetailView.h
//  ShopFriendForShop
//
//  Created by Beautilut on 14-8-18.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ServerDetailViewDelegate;
@interface ServerDetailView : UIControl
{
    id <ServerDetailViewDelegate> delegate;
}
@property(nonatomic,strong) id <ServerDetailViewDelegate> delegate;
-(void)setImage:(NSString*)imagePath with:(NSDictionary*)adic;
@end
@protocol ServerDetailViewDelegate <NSObject>
//touch
-(void)serverDetailViewTouchDown:(int)number;
@end