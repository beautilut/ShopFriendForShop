//
//  DatePickViewController.h
//  ShopFriendForShop
//
//  Created by Beautilut on 14-8-22.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DatePickDelegate;
@interface DatePickViewController : UIViewController
{
    id <DatePickDelegate> delegate;
    NSDate*oldDate;
}
@property(nonatomic,strong) id <DatePickDelegate> delegate;
@property(nonatomic,retain) NSDate*oldDate;
@end
@protocol DatePickDelegate <NSObject>

-(void)dateChange:(NSDate*)date;

@end