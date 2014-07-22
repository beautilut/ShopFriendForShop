//
//  SFTalkViewController.h
//  shopFriend
//
//  Created by Beautilut on 14-2-25.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TalkInputView.h"
#import "MessageInputView.h"
@interface SFTalkViewController : UIViewController<UITextViewDelegate,TalkInputViewDelegate,UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,MessageInputViewDelegate>
{
    //UserObject*chatPerson;
    TalkInputView*inputView;
    float previousTextViewContentHeight;
}
@property(nonatomic,retain) UserObject*chatPerson;
@property(assign,nonatomic) float previousTextViewContentHeight;
@end
