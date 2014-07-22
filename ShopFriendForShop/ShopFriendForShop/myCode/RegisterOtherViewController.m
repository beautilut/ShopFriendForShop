//
//  RegisterOtherViewController.m
//  ShopFriendForShop
//
//  Created by Beautilut on 14-1-23.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import "RegisterOtherViewController.h"
#import "TextFieldCell.h"
#import "SFNaviBar.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/MobileCoreServices.h>
@interface RegisterOtherViewController ()
{
    
    CGFloat moveHeight;
    NSMutableDictionary*postDic;
    
    UIButton*imageButton;
    UITableView*tableView;
    TextFieldCell*cell;
    UIImageView*checkImage;
    UIButton*buttonRight;
}
@end

@implementation RegisterOtherViewController
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
    CGRect screenRect=[[UIScreen mainScreen] bounds];
    SFNaviBar*navi=[[SFNaviBar alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [navi openNaviShadow:YES];
    [self.view addSubview:navi];
//    UIBarButtonItem*leftButton=[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:self action:@selector(backNavi:)];
//    self.navigationItem.leftBarButtonItem=leftButton;
//    UIBarButtonItem*rightButton=[[UIBarButtonItem alloc] initWithTitle:@"下一步" style:UIBarButtonItemStyleBordered target:self action:@selector(next:)];
//    self.navigationItem.rightBarButtonItem=rightButton;
    
    imageButton=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 120,120)];
    [imageButton setCenter:CGPointMake(screenRect.size.width/2, 145)];
    imageButton.layer.borderWidth=2;
    imageButton.layer.borderColor=[UIColor whiteColor].CGColor;
    //imageButton.layer.cornerRadius=CGRectGetHeight(imageButton.bounds)/2;
    imageButton.clipsToBounds=YES;
    [imageButton addTarget:self action:@selector(imagePick:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:imageButton];
    
    tableView=[[UITableView alloc] initWithFrame:CGRectMake(0,imageButton.frame.origin.y+imageButton.frame.size.height+10, screenRect.size.width,80) style:UITableViewStyleGrouped];
    //[tableView setCenter:CGPointMake(screenRect.size.width/2, screenRect.size.height/2-100)];
    [tableView setDelegate:self];
    [tableView setDataSource:self];
    [tableView setScrollEnabled:NO];
    [self.view addSubview:tableView];
    [self.view setBackgroundColor:tableView.backgroundColor];
    
    UIButton *button=[[UIButton alloc] initWithFrame:CGRectMake(5, 24, 40, 40)];
    [button addTarget:self action:@selector(backNavi:) forControlEvents:UIControlEventTouchDown];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:25.0/255.0 green:173.0/255.0 blue:220.0/255.0 alpha:1.0f] forState:UIControlStateNormal];
    [navi addSubview:button];
    buttonRight=[[UIButton alloc] initWithFrame:CGRectMake(navi.frame.size.width-45,24,40,40)];
    [buttonRight addTarget:self action:@selector(registerShop:) forControlEvents:UIControlEventTouchDown];
    [button.titleLabel setTextAlignment:NSTextAlignmentRight];
    [buttonRight setTitle:@"注册" forState:UIControlStateNormal];
    [buttonRight setTitleColor:[UIColor colorWithRed:25.0/255.0 green:173.0/255.0 blue:220.0/255.0 alpha:1.0f] forState:UIControlStateNormal];
    [navi addSubview:buttonRight];
    [self.view bringSubviewToFront:navi];
    
    UIView *checkView=[[UIView alloc] initWithFrame:CGRectMake(50, tableView.frame.origin.y+tableView.frame.size.height+5,20, 20)];
    [checkView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:checkView];
    checkImage=[[UIImageView alloc] initWithFrame:CGRectMake(2, 2, checkView.frame.size.width-4, checkView.frame.size.height-4)];
    [checkImage setImage:[UIImage imageNamed:@"check"]];
    [checkView addSubview:checkImage];
    UIButton*checkButton=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, checkView.frame.size.width, checkView.frame.size.height)];
    [checkButton setBackgroundColor:[UIColor clearColor]];
    [checkButton addTarget:self action:@selector(check:) forControlEvents:UIControlEventTouchDown];
    [checkView addSubview:checkButton];
    
    UILabel*label1=[[UILabel alloc] initWithFrame:CGRectMake(80,tableView.frame.origin.y+tableView.frame.size.height, 100, 30)];
    [label1 setText:@"我已阅读并同意"];
    [label1 setFont:[UIFont systemFontOfSize:13.0f]];
    [self.view addSubview:label1];
    
    UIButton*labelButton=[[UIButton alloc] initWithFrame:CGRectMake(170, tableView.frame.origin.y+tableView.frame.size.height, 100, 30)];
    [labelButton setTitle:@"店友用户协议" forState:UIControlStateNormal];
    [labelButton.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
    [labelButton setTitleColor:[UIColor colorWithRed:25.0/255.0 green:173.0/255.0 blue:220.0/255.0 alpha:1.0f] forState:UIControlStateNormal];
    [labelButton addTarget:self action:@selector(checkLabel:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:labelButton];
	// Do any additional setup after loading the view.
}
-(IBAction)done:(id)sender
{
    [cell.textField resignFirstResponder];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)backNavi:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)check:(id)sender
{
    [checkImage setHidden:!checkImage.hidden];
}
-(void)checkLabel:(id)sender
{
    [self performSegueWithIdentifier:@"userAgreement" sender:nil];
}
-(void)registerShop:(id)sender
{
    if (checkImage.hidden==YES) {
        UIAlertView*alter=[[UIAlertView alloc] initWithTitle:nil message:@"您必须同意店友用户协议才能进行下一步操作" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
        return;
    }
    if ([cell.textField.text isEqualToString:@""]) {
        UIAlertView*alter=[[UIAlertView alloc] initWithTitle:@"提示" message:@"请设置密码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
        return;
    }else
    {
        [postDic setObject:cell.textField.text forKey:@"shopPassword"];
    }
    [self post:nil];
}
-(void)post:(id)sender
{
    [ProgressHUD show:@"正在创建用户"];
    [buttonRight setEnabled:NO];
    NSURL*url=[NSURL URLWithString:registerURL];
    ASIFormDataRequest*request=[ASIFormDataRequest requestWithURL:url];
    for (NSString*key in [postDic allKeys]) {
        if (![key isEqualToString:@"shopLogo"]) {
            [request setPostValue:[postDic objectForKey:key] forKey:key];
        }else
        {
            UIImage*image=[postDic objectForKey:key];
            NSData*imagedata=UIImageJPEGRepresentation(image, 0.1);
            [request setData:imagedata withFileName:@"shopLogo.jpg" andContentType:@"image/jpeg " forKey:@"shopLogo"];
        }
    }
    [request setCompletionBlock:^{
        SBJsonParser*parser=[[SBJsonParser alloc] init];
        NSDictionary*dic=[parser objectWithString:request.responseString];
        if ([[dic objectForKey:@"back"] integerValue]==1) {
            NSMutableDictionary*newDic=[[NSMutableDictionary alloc] init];
            [newDic setObject:[postDic objectForKey:@"shopID"] forKey:sfShopID];
            [newDic setObject:[postDic objectForKey:@"shopName"] forKey:sfShopName];
            [newDic setObject:[postDic objectForKey:@"shopCategoryWord"] forKey:sfShopCategoryWord];
            [newDic setObject:[postDic objectForKey:@"shopCategory"] forKey:sfShopCategory];
            [newDic setObject:[postDic objectForKey:@"shopCategoryDetail"] forKey:sfShopCategoryDetail];
            [newDic setObject:[postDic objectForKey:@"shopTel"] forKey:sfShopTel];
            [newDic setObject:[postDic objectForKey:@"shopAddress"] forKey:sfShopAddress];
            ShopObject*newShop=[ShopObject shopFromDictionary:newDic];
            [ShopObject saveNewShop:newShop];
            [[NSUserDefaults standardUserDefaults] setObject:[postDic objectForKey:@"shopID"] forKey:kXMPPmyJID];
            [[NSUserDefaults standardUserDefaults] setObject:[postDic objectForKey:@"shopPassword"] forKey:kXMPPmyPassword];
            [[InfoManager sharedInfo] getShopInfo];
            [[SFXMPPManager sharedInstance] connect];
            SDWebImageManager *manager = [SDWebImageManager sharedManager];
            NSURL*url=[NSURL URLWithString:SHOP_LOGO([postDic objectForKey:@"shopID"])];
            [manager downloadWithURL:url options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished)
             {
                 //[[SDImageCache sharedImageCache] storeImage:image forKey:shopLogoKey toDisk:YES];
                 [[InfoManager sharedInfo] saveUserImage:image];
                 [ProgressHUD dismiss];
                 [[NSNotificationCenter defaultCenter] postNotificationName:@"logoGet" object:nil];
             }];
            //[[NSNotificationCenter defaultCenter] postNotificationName:@"registerSuccess" object:nil]
            [buttonRight setEnabled:YES];
            [self dismissViewControllerAnimated:YES completion:Nil];
        }
    }];
    [request setFailedBlock:^{
        [buttonRight setEnabled:YES];
        [ProgressHUD dismiss];
        NSLog(@"fail");
    }];
    [request startAsynchronous];
}
#pragma mark - alterview delegate
-(void)getSendFromMain:(NSMutableDictionary*)dic
{
    postDic=dic;
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
   
}
#pragma mark - tableview 
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5.0f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //static NSString *CellIdentifier = @"Cell";
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    //UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"ShopCell"];
    // Configure the cell...
    cell=[tableView dequeueReusableCellWithIdentifier:@"TextFieldCell"];
    if (cell==nil) {
        NSArray*nib=[[NSBundle mainBundle] loadNibNamed:@"TextFieldCell" owner:self options:nil];
        for (id oneObject in nib) {
            if ([oneObject isKindOfClass:[TextFieldCell class]]) {
                cell=(TextFieldCell*)oneObject;
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
            }
        }
            [cell.titleLabel setText:@"设置密码"];
            [cell.textField setSecureTextEntry:YES];
            [cell.textField setPlaceholder:@"******"];
            [cell.textField setDelegate:self];
            [cell.textField setReturnKeyType:UIReturnKeyDone];
    }
    return cell;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
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
                controller.cameraDevice = UIImagePickerControllerCameraDeviceRear;
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
    [postDic setObject:editedImage forKey:@"shopLogo"];
    [imageButton setBackgroundImage:editedImage forState:UIControlStateNormal];
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
        // TO DO
    }];
}

- (void)imageCropperDidCancel:(VPImageCropperViewController *)cropperViewController {
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
    }];
}
@end
