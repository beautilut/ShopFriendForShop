//
//  AddMenuViewController.m
//  ShopFriendForShop
//
//  Created by Beautilut on 14-2-13.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import "AddMenuViewController.h"
#import "TextFieldCell.h"
#import "NSObject_URLHeader.h"
#import "SFNaviBar.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "TSCurrencyTextField.h"
#import "MenuInfoCell.h"
@interface AddMenuViewController ()
{
    BOOL change;
    UITableView*menuTable;
    UIScrollView*menuBackScrol;
    UIScrollView*imageScroll;
    NSMutableArray*imageArray;
    UITextView*postInfo;
    
    UIActionSheet*imagePick;
    UIActionSheet*imageChange;
    NSString*categoryID;
    NSString*shopID;
    MenuObject*infoMenu;
    TextFieldCell*nameCell;
    TSCurrencyTextField*priceField;
    
    //UIImage*logoImage;
    UIButton*menuLogo;
    UIButton*moveAdd;
    NSMutableArray*imageButtonArray;
    int imagePickTag;
    BOOL logoChange;
    BOOL imageAdd;
}
@end

@implementation AddMenuViewController

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
    UIButton *button=[[UIButton alloc] initWithFrame:CGRectMake(5, 24, 40, 40)];
    [button addTarget:self action:@selector(popViewController:) forControlEvents:UIControlEventTouchDown];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:25.0/255.0 green:173.0/255.0 blue:220.0/255.0 alpha:1.0f] forState:UIControlStateNormal];
    [navi addSubview:button];
    [self.view bringSubviewToFront:navi];
    UIButton*buttonRight=[[UIButton alloc] initWithFrame:CGRectMake(navi.frame.size.width-45,24,40,40)];
    [buttonRight addTarget:self action:@selector(menuFinish:) forControlEvents:UIControlEventTouchDown];
    [buttonRight setTitle:@"完成" forState:UIControlStateNormal];
    [buttonRight setTitleColor:[UIColor colorWithRed:25.0/255.0 green:173.0/255.0 blue:220.0/255.0 alpha:1.0f] forState:UIControlStateNormal];
    [navi addSubview:buttonRight];

    menuBackScrol=[[UIScrollView alloc] initWithFrame:CGRectMake(0, navi.frame.size.height,screenBounds.size.width, screenBounds.size.height-navi.frame.size.height)];
    [menuBackScrol setBackgroundColor:[UIColor clearColor]];
    [menuBackScrol setContentSize:CGSizeMake(screenBounds.size.width, screenBounds.size.height)];
    [self.view addSubview:menuBackScrol];
    
    int naviHeight=self.navigationController.navigationBar.frame.size.height+20;
    menuTable=[[UITableView alloc] initWithFrame:CGRectMake(0,0,menuBackScrol.frame.size.width,250) style:UITableViewStyleGrouped];
    [menuTable setDelegate:self];
    [menuTable setDataSource:self];
    [menuTable setScrollEnabled:NO];
    [menuBackScrol addSubview:menuTable];
    [self.view setBackgroundColor:[menuTable backgroundColor]];
    
    UIView *backView=[[UIView alloc] initWithFrame:CGRectMake(0,menuTable.frame.size.height+5, self.view.frame.size.width, 75)];
    [backView setBackgroundColor:[UIColor blackColor]];
    [backView setAlpha:0.3f];
    [menuBackScrol addSubview:backView];
    imageScroll=[[UIScrollView alloc] initWithFrame:backView.frame];
    [imageScroll setBackgroundColor:[UIColor clearColor]];
    [menuBackScrol addSubview:imageScroll];
    imageButtonArray =[[NSMutableArray alloc] initWithCapacity:5];
    [self ImageButtonInit];
//    UIButton*finishButton=[[UIButton alloc] initWithFrame:CGRectMake(10,300, self.view.frame.size.width-20, 40)];
//    [finishButton setBackgroundColor:[UIColor orangeColor]];
//    [finishButton setTitle:@"完成" forState:UIControlStateNormal];
//    [finishButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [finishButton addTarget:self action:@selector(menuFinish:) forControlEvents:UIControlEventTouchDown];
//    [self.view addSubview:finishButton];
    
    
    
    [self.view bringSubviewToFront:navi];
	// Do any additional setup after loading the view.
}
-(void)getInfo:(NSDictionary*)dic
{
    infoMenu=[dic objectForKey:@"menuDetail"];
    categoryID=[dic objectForKey:@"categoryID"];
    shopID=[dic objectForKey:@"shopID"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)popViewController:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - photo
-(void)ImageButtonInit
{
    imageArray=[[NSMutableArray alloc] init];
    SDWebImageManager*manager=[[SDWebImageManager alloc] init];
//    menuLogo=[[UIButton alloc] initWithFrame:CGRectMake(10, 5, 52, 52)];
//    [menuLogo addTarget:self action:@selector(logoChange:) forControlEvents:UIControlEventTouchDown];
//    menuLogo.layer.borderWidth=2;
//    menuLogo.layer.borderColor=[UIColor yellowColor].CGColor;
//    [imageScroll addSubview:menuLogo];
    
    moveAdd=[[UIButton alloc] initWithFrame:CGRectMake(20, 5, 52, 52)];
    [moveAdd addTarget:self action:@selector(imagePick:) forControlEvents:UIControlEventTouchDown];
    moveAdd.layer.borderColor=[UIColor whiteColor].CGColor;
    moveAdd.layer.borderWidth=2;
    [imageScroll addSubview:moveAdd];
    
    for (int i=0; i<[infoMenu.goodPhotoCount intValue]; i++) {
        NSString*localImage=[NSString stringWithFormat:@"%@%@/menu/%@/%@.jpg",menuImageURL,shopID,categoryID,infoMenu.goodID];
        [manager downloadWithURL:[NSURL URLWithString:localImage] options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished)
         {
                if (image!=nil) {
                     [imageArray addObject:image];
                 }
                 [self imageButtonGetImage];
         }];
    }
}
-(void)imageButtonGetImage
{
    for (UIButton * button in imageButtonArray) {
        [button removeFromSuperview];
    }
    [imageButtonArray removeAllObjects];
    for (int i=0; i<[imageArray count]; i++) {
        UIButton*imageButton=[[UIButton alloc] initWithFrame:CGRectMake(20+62*i, 5, 52, 52)];
        [imageButton setImage:[imageArray objectAtIndex:i] forState:UIControlStateNormal];
        [imageButton addTarget:self action:@selector(changeImage:) forControlEvents:UIControlEventTouchDown];
        [imageButton setTag:i];
        [imageScroll addSubview:imageButton];
        [imageButtonArray addObject:imageButton];
    }
    [UIView beginAnimations:@"animation" context:nil];
    [UIView setAnimationDuration:0.2f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [moveAdd setFrame:CGRectMake(20+62*imageArray.count, 5, 52, 52)];
    [UIView commitAnimations];
}
-(void)changeImage:(id)sender
{
    [self allResign];
    imagePickTag=((UIButton*)sender).tag;
    imageChange=[[UIActionSheet alloc] initWithTitle:@"图像选取" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍摄",@"从相册中选取",@"删除",nil];
    [imageChange showInView:self.view];
}
-(void)imagePick:(id)sender
{
    [self allResign];
    imagePick=[[UIActionSheet alloc] initWithTitle:@"图像选取" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍摄",@"从相册中选取",nil];
    [imagePick showInView:self.view];
    imageAdd=YES;
}
-(void)logoChange:(id)sender
{
    [self allResign];
    imagePick=[[UIActionSheet alloc] initWithTitle:@"图像选取" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍摄",@"从相册中选取",nil];
    [imagePick showInView:self.view];
    logoChange=YES;
}
#pragma mark - asi
-(void)menuFinish:(id)sender
{
    UIButton*button=sender;
    [button setEnabled:NO];
    [[WebMenuMethods sharedMenu] setDelegate:self];
    NSMutableDictionary*menuDic=[[NSMutableDictionary alloc] init];
    [menuDic setObject:nameCell.textField.text forKey:@"goodName"];
    [menuDic setObject:priceField.amount forKey:@"goodPrice"];
    [menuDic setObject:categoryID forKey:@"goodCategory"];
    [menuDic setObject:postInfo.text forKey:@"goodInfo"];
    [menuDic setObject:shopID forKey:@"shopID"];
    if ([nameCell.textField.text isEqualToString:@""]||[priceField.amount floatValue]<0.5) {
        UIAlertView*alter=[[UIAlertView alloc] initWithTitle:@"错误" message:@"请填写完整,价格大于0.5" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
        [button setEnabled:YES];
        return;
    }
    NSMutableArray*postImageArray=[[NSMutableArray alloc] initWithCapacity:5];
    [postImageArray addObjectsFromArray:imageArray];
    [menuDic setObject:postImageArray forKey:@"goodPhoto"];
    if (infoMenu.goodID==nil) {
        [[WebMenuMethods sharedMenu] webMenuInsert:menuDic];
    }else
    {
        [menuDic setObject:infoMenu.goodID forKey:@"goodID"];
        [[WebMenuMethods  sharedMenu] webMenuChange:menuDic];
    }
}
//webMenu Delegate
-(void)webMenuInsertSuccess
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"menuFinish" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)webMenuInsertFail
{
    UIAlertView*alter=[[UIAlertView alloc] initWithTitle:nil message:@"菜单插入失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alter show ];
}
-(void)webMenuChangeSuccess
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"menuFinish" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)webMenuChangeFail
{
    UIAlertView*alter=[[UIAlertView alloc] initWithTitle:nil message:@"菜单修改失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alter show];
}
//textfield delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField==nameCell.textField) {
        [priceField becomeFirstResponder];
    }else
    {
    [textField resignFirstResponder];
    }
    return YES;
}
-(void)allResign
{
    [nameCell.textField resignFirstResponder];
    [priceField resignFirstResponder];
}
#pragma mark - table
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==2) {
        return 110.0f;
    }else{
        return 44.0f;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TextFieldCell*cell=[tableView dequeueReusableCellWithIdentifier:@"TextFieldCell"];
    
    if (cell==nil) {
        NSArray*nib=[[NSBundle mainBundle] loadNibNamed:@"TextFieldCell" owner:self options:nil];
        for (id oneObject in nib) {
            if ([oneObject isKindOfClass:[TextFieldCell class]]) {
                cell=(TextFieldCell*)oneObject;
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
            }
        }
    }
    if ([indexPath row]==0) {
        [cell.titleLabel setText:@"名称"];
        [cell.textField setPlaceholder:@""];
        [cell.textField setDelegate:self];
        [cell.textField setReturnKeyType:UIReturnKeyNext];
        if (infoMenu!=nil) {
           [cell.textField setText:infoMenu.goodName];
        }
        nameCell=cell;
    }
    if ([indexPath row]==1) {
        [cell.titleLabel setText:@"价格"];
        priceField=[[TSCurrencyTextField alloc] initWithFrame:cell.textField.frame];
        [priceField setKeyboardType:UIKeyboardTypeNumberPad];
        [cell.textField setHidden:YES];
        [cell addSubview:priceField];
        if (infoMenu.goodPrice!=nil) {
            priceField.amount=infoMenu.goodPrice;
        }

        return cell;
    }
    if ([indexPath row]==2) {
        MenuInfoCell*cell;
        NSArray*nib=[[NSBundle mainBundle] loadNibNamed:@"MenuInfoCell" owner:self options:nil];
        for (id oneObject in nib) {
            if ([oneObject isKindOfClass:[MenuInfoCell class]]) {
                cell=(MenuInfoCell*)oneObject;
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
            }
        }
        [cell.namelabel setText:@"详情"];
        [cell.menuInfo setDelegate:self];
        [cell.menuInfo setReturnKeyType:UIReturnKeyDone];
        postInfo=cell.menuInfo;
        if ((infoMenu.goodInfo!=nil)&&(infoMenu.goodInfo!=[NSNull null])) {
            [cell.menuInfo setText:infoMenu.goodInfo];
        }
        return cell;
    }
    return cell;
}
#pragma mark -
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet==imagePick) {
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

    }
    if (actionSheet==imageChange) {
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
            [imageArray removeObjectAtIndex:imagePickTag];
            [self imageButtonGetImage];
        }
    }
}
#pragma mark -
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
    
    if(imageAdd==YES) {
        [imageArray addObject:editedImage];
        [self imageButtonGetImage];
        imageAdd=NO;
    }else
    {
        [imageArray replaceObjectAtIndex:imagePickTag withObject:editedImage];
        [self imageButtonGetImage];
    }
    
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
        // TO DO
    }];
}

- (void)imageCropperDidCancel:(VPImageCropperViewController *)cropperViewController {
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
    }];
}

@end
