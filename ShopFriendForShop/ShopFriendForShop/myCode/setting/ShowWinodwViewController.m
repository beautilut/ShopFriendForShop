//
//  ShowWinodwViewController.m
//  ShopFriendForShop
//
//  Created by Beautilut on 14-4-18.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import "ShowWinodwViewController.h"
#import "SFNaviBar.h"
#import "ShopWindowButton.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/MobileCoreServices.h>
@interface ShowWinodwViewController ()
{
    
    NSMutableArray*imageArray;
    UIPageControl*windowPage;
    
    ShopWindowButton*shopwindow1;
    ShopWindowButton*shopwindow2;
    ShopWindowButton*shopwindow3;
    ShopWindowButton*shopwindow4;
    ShopWindowButton*shopwindow5;

    NSNumber*pickNumber;
}
@end

@implementation ShowWinodwViewController
@synthesize imageScroll;
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
    SFNaviBar*navi=[[SFNaviBar alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [navi openNaviShadow:YES];
    [self.view addSubview:navi];
    
    UILabel*label=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    [label setCenter:CGPointMake(navi.frame.size.width/2, navi.frame.size.height-23)];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setText:@"橱窗"];
    [label setTextColor:[UIColor colorWithRed:25.0/255.0 green:173.0/255.0 blue:220.0/255.0 alpha:1.0f]];
    [label setFont:[UIFont systemFontOfSize:19.0f]];
    [navi addSubview:label];
    
    UIButton*leftButton=[[UIButton alloc] initWithFrame:CGRectMake(5, 24, 40, 40)];
    [leftButton addTarget:self action:@selector(backNavi:) forControlEvents:UIControlEventTouchDown];
    [leftButton.titleLabel setTextAlignment:NSTextAlignmentLeft];
    [leftButton setTitle:@"返回" forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor colorWithRed:25.0/255.0 green:173.0/255.0 blue:220.0/255.0 alpha:1.0f] forState:UIControlStateNormal];
    [navi addSubview:leftButton];
    
    UIView*backView=[[UIView alloc] initWithFrame:CGRectMake(0, naviHight, self.view.frame.size.width,screenBounds.size.height-naviHight)];
    [backView setBackgroundColor:[UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1.0]];
    [self.view addSubview:backView];
    
    imageScroll=[[UIScrollView alloc] initWithFrame:backView.frame];
    [imageScroll setContentSize:CGSizeMake(320*5, backView.frame.size.height)];
    [imageScroll setBackgroundColor:[UIColor clearColor]];
    [imageScroll setDelegate:self];
    [self.view addSubview:imageScroll];
    windowPage=[[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, 100, 18)];
    [windowPage setCenter:CGPointMake(imageScroll.frame.size.width/2, naviHight+20+420)];
    [windowPage setCurrentPageIndicatorTintColor:[UIColor redColor]];
    [windowPage setPageIndicatorTintColor:[UIColor blackColor]];
    windowPage.numberOfPages=5;
    windowPage.currentPage=0;
    [self.view addSubview:windowPage];
    
    shopwindow1=[[ShopWindowButton alloc] init:0 with:CGRectMake(10, 10, self.view.frame.size.width-20, 400)];
    [shopwindow1 addTarget:self action:@selector(shopWindowChange:) forControlEvents:UIControlEventTouchDown];
    [imageScroll addSubview:shopwindow1];
    shopwindow2=[[ShopWindowButton alloc] init:1 with:CGRectMake(10+self.view.frame.size.width*1, 10, self.view.frame.size.width-20, 400)];
    [shopwindow2 addTarget:self action:@selector(shopWindowChange:) forControlEvents:UIControlEventTouchDown];
    [imageScroll addSubview:shopwindow2];
    shopwindow3=[[ShopWindowButton alloc] init:2 with:CGRectMake(10+self.view.frame.size.width*2, 10, self.view.frame.size.width-20, 400)];
    [shopwindow3 addTarget:self action:@selector(shopWindowChange:) forControlEvents:UIControlEventTouchDown];
    [imageScroll addSubview:shopwindow3];
    shopwindow4=[[ShopWindowButton alloc] init:3 with:CGRectMake(10+self.view.frame.size.width*3, 10, self.view.frame.size.width-20, 400)];
    [shopwindow4 addTarget:self action:@selector(shopWindowChange:) forControlEvents:UIControlEventTouchDown];
    [imageScroll addSubview:shopwindow4];
    shopwindow5=[[ShopWindowButton alloc] init:4 with:CGRectMake(10+self.view.frame.size.width*4, 10, self.view.frame.size.width-20, 400)];
    [shopwindow5 addTarget:self action:@selector(shopWindowChange:) forControlEvents:UIControlEventTouchDown];
    [imageScroll addSubview:shopwindow5];
    [self.view bringSubviewToFront:navi];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.interactivePopGestureRecognizer.enabled=NO;
}
-(void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.interactivePopGestureRecognizer.enabled=YES;
}
-(void)backNavi:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(ShopWindowButton*)getNumberButton:(int)number
{
    switch (number) {
        case 0:
            return shopwindow1;
            break;
        case 1:
            return shopwindow2;
            case 2:
            return shopwindow3;
            case 3:
            return shopwindow4;
            case 4:
            return shopwindow5;
        default:
            break;
    }
    return nil;
}
- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    CGFloat pagewidth = imageScroll.frame.size.width;
    int page =imageScroll.contentOffset.x/pagewidth+1;
    float x=imageScroll.contentOffset.x-(page-1)*pagewidth;
    if (x>200) {
        windowPage.currentPage = page;
    }else
    {
        windowPage.currentPage =page-1;
    }
    
}
-(void)shopWindowChange:(id)sender
{
    ShopWindowButton*button=(ShopWindowButton*)sender;
    pickNumber=[button getNumber];
   UIActionSheet*imagePick=[[UIActionSheet alloc] initWithTitle:@"图像选取" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍摄",@"从相册中选取",@"删除",nil];
    [imagePick showInView:self.view];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
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
    }
    if (buttonIndex==1) {
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
    if (buttonIndex==2) {
        ShopWindowButton*button=[self getNumberButton:[pickNumber intValue]];
        [button deleteImage];
    }

}
#pragma mark - photo -
#pragma mark -
#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *portraitImg = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    portraitImg = [self imageByScalingToMaxSize:portraitImg];
    // 裁剪
    VPImageCropperViewController *imgEditorVC = [[VPImageCropperViewController alloc] initWithImage:portraitImg cropFrame:CGRectMake(0, 100.0f, self.view.frame.size.width,400) limitScaleRatio:3.0];
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
        // TO DO
        ShopWindowButton*button=[self getNumberButton:[pickNumber intValue]];
        [button changeImage:editedImage];
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
