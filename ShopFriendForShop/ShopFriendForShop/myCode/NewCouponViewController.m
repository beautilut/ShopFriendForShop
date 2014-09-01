//
//  NewCouponViewController.m
//  ShopFriendForShop
//
//  Created by Beautilut on 14-7-1.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import "NewCouponViewController.h"
#import "SFNaviBar.h"
//#import "SFTextField.h"
#import "TextFieldCell.h"
#import "MenuInfoCell.h"
#import "DateCell.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/MobileCoreServices.h>
@interface NewCouponViewController ()
{
    //table
    UITableView*couponInfoTable;
    UITextField*nameField;
    UITextView*infoView;
    UILabel*beginDate;
    UILabel*endDate;
    UITextView*userInfoView;
    UIButton*buttonRight;
    UIImageView*couponImageView;
    BOOL edit;
    NSDictionary*couponDic;
    BOOL dateKind;
}
@end

@implementation NewCouponViewController
@synthesize delegate;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setHidden:YES];
    CGRect screenBounds=[[UIScreen mainScreen] bounds];
    SFNaviBar*navi=[[SFNaviBar alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [navi openNaviShadow:YES];
    [self.view addSubview:navi];
    
    //[self.view setBackgroundColor:[UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:244.0/255.0 alpha:1]];
    
    UILabel*label=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    [label setCenter:CGPointMake(navi.frame.size.width/2, navi.frame.size.height-23)];
    [label setTextAlignment:NSTextAlignmentCenter];
    if (edit) {
        [label setText:@""];
    }else{
    [label setText:@"新的优惠券"];
    }
    [label setTextColor:[UIColor colorWithRed:25.0/255.0 green:173.0/255.0 blue:220.0/255.0 alpha:1.0f]];
    [label setFont:[UIFont systemFontOfSize:19.0f]];
    [navi addSubview:label];
    
    UIButton*leftButton=[[UIButton alloc] initWithFrame:CGRectMake(5, 24, 40, 40)];
    [leftButton addTarget:self action:@selector(backNavi:) forControlEvents:UIControlEventTouchDown];
    [leftButton.titleLabel setTextAlignment:NSTextAlignmentLeft];
    [leftButton setTitle:@"返回" forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor colorWithRed:25.0/255.0 green:173.0/255.0 blue:220.0/255.0 alpha:1.0f] forState:UIControlStateNormal];
    [navi addSubview:leftButton];
    
    if (!edit) {
        buttonRight=[[UIButton alloc] initWithFrame:CGRectMake(navi.frame.size.width-45,24,40,40)];
        [buttonRight addTarget:self action:@selector(addCoupon:) forControlEvents:UIControlEventTouchDown];
        
        [buttonRight setTitle:@"确定" forState:UIControlStateNormal];
        [buttonRight setTitleColor:[UIColor colorWithRed:25.0/255.0 green:173.0/255.0 blue:220.0/255.0 alpha:1.0f] forState:UIControlStateNormal];
        
        [navi addSubview:buttonRight];
    }
    [self setCouponInList];
//    couponModelBackScroller=[[UIScrollView alloc] initWithFrame:CGRectMake(0, navi.frame.size.height, screenBounds.size.width,screenBounds.size.height-navi.frame.size.height)];
//    //[couponModelBackScroller setBackgroundColor:[UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:244.0/255.0 alpha:1]];
//    [self.view addSubview:couponModelBackScroller];
//    [self setCouponView];
   

    
    [self.view bringSubviewToFront:navi];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)backNavi:(id)sender
{
    couponInfoTable.frame = CGRectOffset(couponInfoTable.frame, 0,0);
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
-(void)addCoupon:(id)sender
{
    if (edit) {
        
    }else{
        if ([nameField.text isEqualToString:@""]||[infoView.text isEqualToString:@""]||[userInfoView.text isEqualToString:@""]||[endDate.text isEqualToString:@""]) {
            UIAlertView*alter=[[UIAlertView alloc] initWithTitle:nil message:@"请完善优惠券信息" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alter show ];
            return;
        }else{
            NSMutableDictionary*dic=[[NSMutableDictionary alloc] init];
            [dic setObject:[InfoManager sharedInfo].myShop.shopID forKey:sfShopID];
            [dic setObject:nameField.text forKey:sfCouponModelName];
            [dic setObject:infoView.text forKey:sfCouponModelInfo];
            [dic setObject:userInfoView.text forKey:sfCouponModelUserInfo];
            if (![beginDate.text isEqualToString:@""]) {
                [dic setObject:beginDate.text forKey:sfCouponModelBeginTime];
            }
            [dic setObject:endDate.text forKey:sfCouponModelEndTime];
            if (couponImageView.image) {
                [dic setObject:couponImageView.image forKey:sfCouponModelImage];
            }
            [[WebCouponMethods sharedCoupon] setDelegate:self];
            [[WebCouponMethods sharedCoupon] webCouponInsert:dic];
            [buttonRight setEnabled:NO];
            [ProgressHUD show:@"正在生成优惠券"];
        }
    }
}
-(void)getCoupon:(NSDictionary *)dic
{
    edit=YES;
    couponDic=dic;
}
#pragma mark webCouponDelegate
-(void)webCouponInsertSuccess
{
    [ProgressHUD dismiss];
    [buttonRight setEnabled:YES];
    [self backNavi:nil];
}
-(void)webCouponInsertFail
{
    [ProgressHUD dismiss];
    UIAlertView*alter=[[UIAlertView alloc] initWithTitle:nil message:@"注册失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alter show];
    [buttonRight setEnabled:YES];
}
#pragma mark text delegate
//-(void)textFieldDidBeginEditing:(UITextField *)textField
//{
//    textField.layer.borderColor=[UIColor orangeColor].CGColor;
//    textField.layer.borderWidth=1.0f;
//    textField.layer.masksToBounds=YES;
//    textField.layer.cornerRadius=5.0f;
//}
//-(void)textFieldDidEndEditing:(UITextField *)textField
//{
//    textField.layer.borderWidth=0.0f;
//    textField.layer.borderColor=[UIColor whiteColor].CGColor;
//    textField.layer.masksToBounds=NO;
//    textField.layer.cornerRadius=0.0f;
//}
//-(void)textViewDidBeginEditing:(UITextView *)textView
//{
//    textView.layer.borderColor=[UIColor orangeColor].CGColor;
//    textView.layer.borderWidth=1.0f;
//    textView.layer.masksToBounds=YES;
//    textView.layer.cornerRadius=5.0f;
//}
//-(void)textViewDidEndEditing:(UITextView *)textView
//{
//    textView.layer.borderColor=[UIColor whiteColor].CGColor;
//    textView.layer.borderWidth=0.0f;
//    textView.layer.masksToBounds=NO;
//    textView.layer.cornerRadius=0.0f;
//}
//-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
//{
//    if (textView==couponModel_Info) {
//        if (couponModel_Info.text.length==0) {
//            if ([text isEqualToString:@""]) {
//                [couponModel_InfoLabel setHidden:NO];
//            }else
//            {
//                [couponModel_InfoLabel setHidden:YES];
//            }
//        }else
//        {
//            if (couponModel_Info.text.length==1) {
//                if ([text isEqualToString:@""]) {
//                    [couponModel_InfoLabel setHidden:NO];
//                }else
//                {
//                    [couponModel_InfoLabel setHidden:YES];
//                }
//            }else{
//                [couponModel_InfoLabel  setHidden:YES];
//            }
//        }
//    }
//    if (textView==couponModel_UseInfo) {
//        if (couponModel_UseInfo.text.length==0) {
//            if ([text isEqualToString:@""]) {
//                [couponModel_UseInfo setHidden:NO];
//            }else
//            {
//                [couponModel_UseInfo setHidden:YES];
//            }
//        }else
//        {
//            if (couponModel_UseInfo.text.length==1) {
//                if ([text isEqualToString:@""]) {
//                    [couponModel_UseInfoLabel setHidden:NO];
//                }else
//                {
//                    [couponModel_UseInfoLabel setHidden:YES];
//                }
//            }else
//            {
//                [couponModel_UseInfoLabel setHidden:YES];
//            }
//        }
//    }
//    return YES;
//}
-(void)setCouponView
{
//    couponModel_Name=[[SFTextField alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
//    [couponModel_Name setDelegate:self];
//    [couponModel_Name setCenter:CGPointMake(couponModelBackScroller.frame.size.width/2, 40)];
//    [couponModel_Name setBackgroundColor:[UIColor whiteColor]];
//    [couponModel_Name setPlaceholder:@"优惠券名称"];
//    [couponModelBackScroller addSubview:couponModel_Name];
//    UIView*leftView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
//    [leftView setUserInteractionEnabled:NO];
//    couponModel_Name.leftView=leftView;
//    couponModel_Name.leftViewMode=UITextFieldViewModeAlways;
//    
//    couponModel_Info=[[UITextView alloc] initWithFrame:CGRectMake(0, 0, 300, 100)];
//    [couponModel_Info setCenter:CGPointMake(couponModelBackScroller.frame.size.width/2,130)];
//    [couponModel_Info setDelegate:self];
//    [couponModel_Info setFont:[UIFont systemFontOfSize:17.0f]];
//    [couponModelBackScroller addSubview:couponModel_Info];
//    couponModel_InfoLabel=[[UILabel alloc] initWithFrame:CGRectMake(couponModel_Info.frame.origin.x+5, couponModel_Info.frame.origin.y, couponModel_Info.frame.size.width-3,40)];
//    [couponModel_InfoLabel setText:@"优惠券详情"];
//    [couponModel_InfoLabel setTextColor:[UIColor grayColor]];
//    [couponModel_InfoLabel setFont:[UIFont systemFontOfSize:17.0f]];
//    [couponModelBackScroller addSubview:couponModel_InfoLabel];
//    
//    UILabel*beginLabel=[[UILabel alloc] initWithFrame:CGRectMake(couponModel_Info.frame.origin.x+5,200, 100, 40)];
//    [beginLabel  setText:@"起始时间"];
//    [beginLabel setTextColor:[UIColor grayColor]];
//    [couponModelBackScroller addSubview:beginLabel];
//    
//    UILabel*endLabel=[[UILabel alloc] initWithFrame:CGRectMake(beginLabel.frame.origin.x, 250, 100, 40)];
//    [endLabel setTextColor:[UIColor grayColor]];
//    [endLabel setText:@"结束时间"];
//    [couponModelBackScroller addSubview:endLabel];
}
-(void)setCouponInList
{
    CGRect screenBounds=[[UIScreen mainScreen] bounds];
    couponInfoTable=[[UITableView alloc] initWithFrame:CGRectMake(0, naviHight, screenBounds.size.width, screenBounds.size.height-naviHight) style:UITableViewStyleGrouped];
    [couponInfoTable setDelegate:self];
    [couponInfoTable setDataSource:self];
    [self.view addSubview:couponInfoTable];
}
#pragma mark tableDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        NSArray*nib=[[NSBundle mainBundle] loadNibNamed:@"TextFieldCell" owner:self options:nil];
        TextFieldCell*cell;
        for (id oneObject in nib) {
            if ([oneObject isKindOfClass:[TextFieldCell class]]) {
                cell=(TextFieldCell*)oneObject;
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
            }
        }
        [cell.titleLabel setText:@"优惠券名"];
        [cell.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
        [cell.textField setDelegate:self];
        if (edit) {
            [cell.textField setText:[couponDic objectForKey:sfCouponModelName]];
            [cell.textField setEnabled:NO];
        }
        nameField=cell.textField;
        return cell;
    }
    if (indexPath.row==1) {
        MenuInfoCell*cell;
        NSArray*nib=[[NSBundle mainBundle] loadNibNamed:@"MenuInfoCell" owner:self options:nil];
        for (id oneObject in nib) {
            if ([oneObject isKindOfClass:[MenuInfoCell class]]) {
                cell=(MenuInfoCell*)oneObject;
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
            }
        }
        [cell.namelabel setText:@"详情"];
        [cell.namelabel setFont:[UIFont systemFontOfSize:15.0f]];
        [cell.menuInfo setDelegate:self];
        if (edit) {
            [cell.menuInfo setText:[couponDic objectForKey:sfCouponModelInfo]];
            [cell.menuInfo setEditable:NO];
        }
        [cell.menuInfo setReturnKeyType:UIReturnKeyDone];
        infoView=cell.menuInfo;
        return cell;
    }
    if (indexPath.row==2) {
        DateCell*cell;
        NSArray*nib=[[NSBundle mainBundle] loadNibNamed:@"DateCell" owner:self options:nil];
        for (id oneObject in nib) {
            if ([oneObject isKindOfClass:[DateCell class]]) {
                cell=(DateCell*)oneObject;
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
            }
        }
        [cell.namelabel setText:@"起始日期"];
        [cell.namelabel setFont:[UIFont systemFontOfSize:15.0f]];
        if (edit) {
            if ([couponDic objectForKey:sfCouponModelBeginTime]!=[NSNull null]) {
                NSString*date=[[couponDic objectForKey:sfCouponModelBeginTime] substringToIndex:10];
                [cell.datelabel setText:date];
            }else{
                [cell.datelabel setText:@""];
            }
        }else{
        [cell.datelabel setText:@""];
        }
        beginDate=cell.datelabel;
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        return cell;
    }
    if (indexPath.row==3) {
        DateCell*cell;
        NSArray*nib=[[NSBundle mainBundle] loadNibNamed:@"DateCell" owner:self options:nil];
        for (id oneObject in nib) {
            if ([oneObject isKindOfClass:[DateCell class]]) {
                cell=(DateCell*)oneObject;
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
            }
        }
        [cell.namelabel setText:@"结束日期"];
        [cell.namelabel setFont:[UIFont systemFontOfSize:15.0f]];
        if (edit) {
             NSString*date=[[couponDic objectForKey:sfCouponModelEndTime] substringToIndex:10];
            [cell.datelabel setText:date];
        }else{
            [cell.datelabel setText:@""];
        }
        endDate=cell.datelabel;
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        return cell;
    }
    if (indexPath.row==4) {
        MenuInfoCell*cell;
        NSArray*nib=[[NSBundle mainBundle] loadNibNamed:@"MenuInfoCell" owner:self options:nil];
        for (id oneObject in nib) {
            if ([oneObject isKindOfClass:[MenuInfoCell class]]) {
                cell=(MenuInfoCell*)oneObject;
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
            }
        }
        [cell.namelabel setText:@"使用详情"];
        [cell.namelabel setFont:[UIFont systemFontOfSize:15.0f]];
        [cell.menuInfo setDelegate:self];
        if (edit) {
            [cell.menuInfo setText:[couponDic objectForKey:sfCouponModelUserInfo]];
            [cell.menuInfo setEditable:NO];
        }
        [cell.menuInfo setReturnKeyType:UIReturnKeyNext];
        userInfoView=cell.menuInfo;
        return cell;
    }
    if (indexPath.row==5) {
        UITableViewCell*cell;
        if (cell==nil) {
            cell=[[UITableViewCell alloc] init];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        UILabel*nameLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 90, 70)];
        [nameLabel setTextAlignment:NSTextAlignmentCenter];
        [nameLabel setFont:[UIFont systemFontOfSize:15.0f]];
        [nameLabel setText:@"选用图片"];
        [cell addSubview:nameLabel];
        couponImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
        [couponImageView setCenter:CGPointMake(cell.frame.size.width-60,35)];
        [couponImageView setImageWithURL:[NSURL URLWithString:[couponDic objectForKey:sfCouponModelImage]]];
        [cell addSubview:couponImageView];
        return cell;
    }
    UITableViewCell*cell;
    if (cell==nil) {
        cell=[[UITableViewCell alloc] init];
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==1) {
        return 110.0f;
    }
    if (indexPath.row==4) {
        return 110.0f;
    }
    if (indexPath.row==5) {
        return 70.f;
    }
    return 44.0f;
}
#pragma mark textFieldDelegate
- (void)moveView:(UITextView *)textVew leaveView:(BOOL)leave
{
    if (leave==YES) {
        const float movementDuration = 0.2f;
        [UIView beginAnimations: @"textViewBack" context: nil];
        [UIView setAnimationBeginsFromCurrentState: YES];
        [UIView setAnimationDuration: movementDuration];
        //couponInfoTable.frame = CGRectOffset(couponInfoTable.frame, 0,1);
        [couponInfoTable setContentOffset:CGPointMake(0, 0)];
        //[backScroll setContentOffset:CGPointMake(0, 0)];
        [UIView commitAnimations];
    }else
    {
            const float movementDuration = 0.2f;
            [UIView beginAnimations: @"textViewDown" context: nil];
            [UIView setAnimationBeginsFromCurrentState: YES];
            [UIView setAnimationDuration: movementDuration];
            //couponInfoTable.frame = CGRectOffset(couponInfoTable.frame, 0,-200);
            [couponInfoTable setContentOffset:CGPointMake(0, 200)];
            //[backScroll setContentOffset:CGPointMake(0, 400)];
            [UIView commitAnimations];
    }
}
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    if (textView==userInfoView) {
        [self moveView:textView leaveView:NO];
    }
}
-(void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView==userInfoView) {
         [self moveView:textView leaveView:YES];
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==2) {
        if (!edit) {
        UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
         DatePickViewController*datePick=[mainStoryboard instantiateViewControllerWithIdentifier:@"datePicker"];
            datePick.oldDate = [couponDic objectForKey:sfCouponModelBeginTime];
        [datePick setDelegate:self];
         [self allResignFirstresponse:nil];
            dateKind=YES;
        [self.navigationController pushViewController:datePick animated:YES];
        }
    }
    if (indexPath.row==3) {
        if (!edit) {
            UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            DatePickViewController*datePick=[mainStoryboard instantiateViewControllerWithIdentifier:@"datePicker"];
            [datePick setDelegate:self];
                datePick.oldDate = [couponDic objectForKey:sfCouponModelEndTime];
            dateKind=NO;
            [self.navigationController pushViewController:datePick animated:YES];
        }
        
    }
    if (indexPath.row==5) {
        if (!edit) {
            UIActionSheet*imageSheet=[[UIActionSheet alloc] initWithTitle:@"选择图片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍摄",@"从照片中选取", nil];
            [imageSheet showInView:self.view];
            return;
        }
    }
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if(scrollView!=infoView||scrollView!=userInfoView)
    {
    [self allResignFirstresponse:nil];
    }
}
-(void)allResignFirstresponse:(id)sender
{
    [nameField resignFirstResponder];
    [infoView resignFirstResponder];
    [userInfoView resignFirstResponder];
}
#pragma mark datechange
-(void)dateChange:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    if (dateKind) {
        [beginDate setText:[dateFormatter stringFromDate:date]];
    }else{
        [endDate setText:[dateFormatter stringFromDate:date]];
    }
}
#pragma mark - image methods
-(void)imagePick:(id)sender
{
    UIActionSheet*imageSheet=[[UIActionSheet alloc] initWithTitle:@"图像选取" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍摄",@"从相册中选取",nil];
    [imageSheet showInView:self.view];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        // 拍照
        if ([self isCameraAvailable] && [self doesCameraSupportTakingPhotos]) {
            UIImagePickerController *controller = [[UIImagePickerController alloc] init];
            controller.sourceType = UIImagePickerControllerSourceTypeCamera;
            if ([self isFrontCameraAvailable]) {
                controller.cameraDevice = UIImagePickerControllerCameraDeviceFront;
            }
            NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
            [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
            controller.mediaTypes = mediaTypes;
            controller.delegate = self;
            [self presentViewController:controller
                               animated:YES
                             completion:^(void){
                                 NSLog(@"Picker View Controller is presented");
                             }];
        }
        
    } else if (buttonIndex == 1) {
        // 从相册中选取
        if ([self isPhotoLibraryAvailable]) {
            UIImagePickerController *controller = [[UIImagePickerController alloc] init];
            controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
            [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
            controller.mediaTypes = mediaTypes;
            controller.delegate = self;
            [self presentViewController:controller
                               animated:YES
                             completion:^(void){
                                 NSLog(@"Picker View Controller is presented");
                             }];
        }
    }
}
#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *portraitImg = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    portraitImg = [self imageByScalingToMaxSize:portraitImg];
    // 裁剪
    VPImageCropperViewController *imgEditorVC = [[VPImageCropperViewController alloc] initWithImage:portraitImg cropFrame:CGRectMake(0, 100.0f, self.view.frame.size.width, self.view.frame.size.width) limitScaleRatio:3.0];
    imgEditorVC.delegate = self;
    [picker pushViewController:imgEditorVC animated:NO];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^(){
    }];
}
#pragma mark -
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
}
#pragma mark camera utility
- (BOOL) isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isRearCameraAvailable{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

- (BOOL) isFrontCameraAvailable {
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}

- (BOOL) doesCameraSupportTakingPhotos {
    return [self cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isPhotoLibraryAvailable{
    return [UIImagePickerController isSourceTypeAvailable:
            UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickVideosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeMovie sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickPhotosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (BOOL) cameraSupportsMedia:(NSString *)paramMediaType sourceType:(UIImagePickerControllerSourceType)paramSourceType{
    __block BOOL result = NO;
    if ([paramMediaType length] == 0) {
        return NO;
    }
    NSArray *availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:paramSourceType];
    [availableMediaTypes enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *mediaType = (NSString *)obj;
        if ([mediaType isEqualToString:paramMediaType]){
            result = YES;
            *stop= YES;
        }
    }];
    return result;
}

#pragma mark image scale utility
- (UIImage *)imageByScalingToMaxSize:(UIImage *)sourceImage {
    if (sourceImage.size.width < ORIGINAL_MAX_WIDTH) return sourceImage;
    CGFloat btWidth = 0.0f;
    CGFloat btHeight = 0.0f;
    if (sourceImage.size.width > sourceImage.size.height) {
        btHeight = ORIGINAL_MAX_WIDTH;
        btWidth = sourceImage.size.width * (ORIGINAL_MAX_WIDTH / sourceImage.size.height);
    } else {
        btWidth = ORIGINAL_MAX_WIDTH;
        btHeight = sourceImage.size.height * (ORIGINAL_MAX_WIDTH / sourceImage.size.width);
    }
    CGSize targetSize = CGSizeMake(btWidth, btHeight);
    return [self imageByScalingAndCroppingForSourceImage:sourceImage targetSize:targetSize];
}

- (UIImage *)imageByScalingAndCroppingForSourceImage:(UIImage *)sourceImage targetSize:(CGSize)targetSize {
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
    }
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil) NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}
#pragma mark VPImageCropperDelegate
- (void)imageCropper:(VPImageCropperViewController *)cropperViewController didFinished:(UIImage *)editedImage {
    [couponImageView setImage:editedImage];
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
        // TO DO
    }];
}

- (void)imageCropperDidCancel:(VPImageCropperViewController *)cropperViewController {
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
