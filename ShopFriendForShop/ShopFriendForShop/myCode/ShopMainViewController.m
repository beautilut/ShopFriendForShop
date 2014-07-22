//
//  ShopMainViewController.m
//  ShopFriendForShop
//
//  Created by Beautilut on 14-3-5.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import "ShopMainViewController.h"
#import "PasswordCheckViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/MobileCoreServices.h>
#define imagesHeight 160
@interface ShopMainViewController ()
{
    UIScrollView*backScrollView;
    UIImageView*backImageView;
    float imagesScrollStart;
    float scrollingKoef;
    UIButton*headImageButton;
    UITableView*table;
}
@end

@implementation ShopMainViewController

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
    CGRect screenBounds=[[UIScreen mainScreen] bounds];
    [self.navigationController.navigationBar setHidden:YES];
    
    backScrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0,24, screenBounds.size.width,screenBounds.size.height-24)];
    [backScrollView setBackgroundColor:[UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:244.0/255.0 alpha:1]];
    [backScrollView setContentSize:CGSizeMake(screenBounds.size.width,700)];
    [backScrollView setDelegate:self];
    [self.view addSubview:backScrollView];
    
    [self designImage];
    backImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0,imagesScrollStart, backScrollView.frame.size.width,300)];
    [backImageView setImage:[UIImage imageNamed:@"1.jpg"]];
    [backScrollView addSubview:backImageView];
    
    headImageButton=[[UIButton alloc] initWithFrame:CGRectMake(0, 0,70,70)];
    [headImageButton setCenter:CGPointMake(70,120)];
    [headImageButton setBackgroundColor:[UIColor whiteColor]];
    headImageButton.layer.borderWidth=2;
    headImageButton.layer.borderColor=[UIColor whiteColor].CGColor;
    [headImageButton addTarget:self action:@selector(imagePick:) forControlEvents:UIControlEventTouchDown];
    [backScrollView addSubview:headImageButton];

    
    table=[[UITableView alloc] initWithFrame:CGRectMake(0, 170, screenBounds.size.width, backScrollView.contentSize.height-170) style:UITableViewStyleGrouped];
    [table setDelegate:self];
    [table setDataSource:self];
//    table.layer.borderWidth=2;
//    table.layer.borderColor=[UIColor whiteColor].CGColor;
    [backScrollView addSubview:table];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setHeadImage:) name:@"logoGet" object:nil];
	// Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    [self setHeadImage:nil];
}
-(void)setHeadImage:(id)sender
{
    UIImage*image=[[InfoManager sharedInfo] getShopLogo];//[[SDImageCache sharedImageCache] imageFromDiskCacheForKey:shopLogoKey];
    [headImageButton setImage:image forState:UIControlStateNormal];
}
-(void)designImage
{
    imagesScrollStart = -(backScrollView.frame.size.width - imagesHeight)/2 - 10;
    
    scrollingKoef = 0.2*imagesHeight/80.0;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - tableMethod
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.0f;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 3;
    }
    if (section==1) {
        return 3;
    }
    if (section==2) {
        return 1;
    }
    return 0;
}
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//
//}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"HeadImageCell"];
    if (!cell) {
        cell=[[UITableViewCell alloc] init];
    }
    if ([indexPath section]==0&&indexPath.row==0) {
        [cell.textLabel setText:@"我的店"];
    }
    if ([indexPath section]==0&&indexPath.row==1) {
        [cell.textLabel setText:@"顾客"];
    }
    if ([indexPath section]==0&&indexPath.row==2) {
        [cell.textLabel setText:@"店粉"];
    }
    if ([indexPath section]==1&&indexPath.row==0) {
        [cell.textLabel setText:@"我的活动"];
    }
    if ([indexPath section]==1&&indexPath.row==1) {
        [cell.textLabel setText:@"我的菜单"];
    }
    if ([indexPath section]==1&&indexPath.row==2) {
        [cell.textLabel setText:@"我的优惠券"];
    }
    if ([indexPath section]==2&&indexPath.row==0) {
        [cell.textLabel setText:@"设置"];
    }
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath section]==0&&indexPath.row==0) {
        ShopObject*aShop=[[ShopObject alloc] init];
        [aShop setShopID:[InfoManager sharedInfo].myShop.shopID];
        [aShop setShopName:[InfoManager sharedInfo].myShop.shopName];
        [[SFSliderViewController sharedSliderController] defaultSubViews:aShop withImage:[[InfoManager sharedInfo] getShopLogo]];
        [self.navigationController pushViewController:[SFSliderViewController sharedSliderController] animated:YES];
    }
    if ([indexPath section]==0&&indexPath.row==1) {
        [self performSegueWithIdentifier:@"TalkList" sender:nil];
    }
    if ([indexPath section]==0&&indexPath.row==2) {
        [self performSegueWithIdentifier:@"fansController" sender:nil];
    }
    if ([indexPath section]==1&&indexPath.row==0) {
        [self performSegueWithIdentifier:@"shopActivity" sender:nil];
    }
    if ([indexPath section]==1&&indexPath.row==1) {
        [self performSegueWithIdentifier:@"pushMenu" sender:nil];
    }
    if ([indexPath section]==1&&indexPath.row==2) {
        [self performSegueWithIdentifier:@"CouponView" sender:nil];
    }
    if ([indexPath section]==2&&indexPath.row==0) {
        //
        UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        PasswordCheckViewController*password=[mainStoryboard instantiateViewControllerWithIdentifier:@"SFPasswordCheck"];
        [password setDelegate:self];
        [self presentViewController:password animated:YES completion:nil];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark - scrollMethod-
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView==backScrollView) {
        backImageView.frame = CGRectMake(backImageView.frame.origin.x, imagesScrollStart + backScrollView.contentOffset.y*scrollingKoef, backImageView.frame.size.width, backImageView.frame.size.height);
        return;
    }
}
-(void)passwordCheckON:(id)sender
{
    [self  performSegueWithIdentifier:@"setting" sender:nil];
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
    
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
        [ProgressHUD show:@"正在修改"];
        NSURL*url=[NSURL URLWithString:shopLogoChangeURL];
        ASIFormDataRequest*request=[ASIFormDataRequest requestWithURL:url];
        NSString*hostID=[[NSUserDefaults standardUserDefaults]objectForKey:kXMPPmyJID];
        [request setPostValue:hostID forKey:@"shopID"];
        NSData*imagedata=UIImageJPEGRepresentation(editedImage, 0.1);
        [request setData:imagedata withFileName:@"shopLogo.jpg" andContentType:@"image/jpeg " forKey:@"shopLogo"];
        [request setCompletionBlock:^{
            SBJsonParser*parser=[[SBJsonParser alloc] init];
            NSDictionary*dic=[parser objectWithString:request.responseString];
            if ([[dic objectForKey:@"back"] integerValue]==1) {
                //[[SDImageCache sharedImageCache] storeImage:editedImage forKey:shopLogoKey toDisk:YES];
                [[InfoManager sharedInfo] saveUserImage:editedImage];
                [self setHeadImage:nil];
            }
            [ProgressHUD dismiss];
        }];
        [request setFailedBlock:^{
            
        }];
        [request startAsynchronous];
        
    }];
}

- (void)imageCropperDidCancel:(VPImageCropperViewController *)cropperViewController {
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
    }];
}

@end
