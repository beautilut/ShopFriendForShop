//
//  ServerScrollerView.h
//  ShopFriendForShop
//
//  Created by Beautilut on 14-8-18.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServerDetailView.h"
@protocol ServerScrollViewDelegate;
@interface ServerScrollerView : UIView<UIScrollViewDelegate,ServerDetailViewDelegate>
{
    id <ServerScrollViewDelegate> delegate;
    UIScrollView*backScroller;
    UIPageControl*pageController;
    NSArray*serverArray;
}
@property(nonatomic,strong) id <ServerScrollViewDelegate> delegate;
@property(nonatomic,retain) UIScrollView*backScroller;
@property(nonatomic,retain) UIPageControl*pageController;
@property(nonatomic,retain) NSArray*serverArray;
-(void)detailTheScroller:(NSArray*)array withImagePath:(NSString*)path;
-(void)serverScrollViewReloadData:(NSArray*)array withImagePath:(NSString*)path;
@end
@protocol ServerScrollViewDelegate <NSObject>

-(void)serverInfo:(NSDictionary*)dic;

@end