//
//  AddView.h
//  ShopFriendForShop
//
//  Created by Beautilut on 14-2-12.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface AddView : UIView<UITextFieldDelegate,UIActionSheetDelegate>
{
    UIControl*overView;
    UIImage*backImage;
    UITableView*categoryTable;
    UITableView*menuTable;
    NSString*shopID;
    UITextField*categoryName;
    
    NSString*categoryID;
    NSString*categoryText;
    NSNumber*change;
}
@property(nonatomic,retain) NSString*categoryID;
@property(nonatomic,retain) NSString*categoryText;
@property(nonatomic,retain) NSNumber*change;
- (id)initWithFrame:(CGRect)frame with:(NSString*)string;
- (id)initWithFrame:(CGRect)frame with:(NSString*)string withCategoryID:(NSString*)categoryIDText withCategoryName:(NSString*)categoryNameText;
-(void)show;
-(void)setBlurImage:(UIImage*)image;
-(void)selfsetBack:(UIImage*)image;
@end
