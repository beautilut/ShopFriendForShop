//
//  AddView.m
//  ShopFriendForShop
//
//  Created by Beautilut on 14-2-12.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import "AddView.h"
#import <Accelerate/Accelerate.h>
#import "NSObject_URLHeader.h"

@implementation AddView
@synthesize change,categoryID,categoryText;
- (id)initWithFrame:(CGRect)frame with:(NSString*)string
{
    self = [super initWithFrame:frame];
    shopID=string;
    if (self) {
        // Initialization code
        [self categoryDefault];
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame with:(NSString*)string withCategoryID:(NSString*)categoryIDText withCategoryName:(NSString*)categoryNameText
{
    self = [super initWithFrame:frame];
    change=[NSNumber numberWithInt:0];
    categoryText=categoryNameText;
    categoryID=categoryIDText;
    shopID=string;
    if (self) {
        // Initialization code
        [self categoryDefault];
    }
    return self;
}
-(void)categoryDefault
{
    self.clipsToBounds=TRUE;
    UIView*backView=[[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [backView setBackgroundColor:[UIColor grayColor]];
    [self addSubview:backView];
    overView= [[UIControl alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    //overView.layer.contents=(id)backImage.CGImage;
    //overView.backgroundColor = [UIColor colorWithRed:.16 green:.17 blue:.21 alpha:.5];
    [overView addTarget:self
                 action:@selector(dismiss)
       forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:overView];
    
    UIView*deepView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 80)];
    [deepView setCenter:CGPointMake(self.center.x, self.frame.size.height/4)];
    [deepView setBackgroundColor:[UIColor whiteColor]];
    deepView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    deepView.layer.borderWidth = 1.0f;
    //deepView.layer.cornerRadius = 10.0f;
    [self addSubview:deepView];
    
    categoryName=[[UITextField alloc] initWithFrame:CGRectMake(0, 0, deepView.frame.size.width-10,30)];
    [categoryName setCenter:CGPointMake(deepView.frame.size.width/2, deepView.frame.size.height/2-20)];
    [categoryName setPlaceholder:@"请输入品类名"];
    [categoryName setBorderStyle:UITextBorderStyleLine];
    [categoryName setReturnKeyType:UIReturnKeyDone];
    [categoryName setDelegate:self];
    [deepView addSubview:categoryName];
    if (change==[NSNumber numberWithInt:0]) {
        UIButton*enterButton=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 25)];
        [enterButton setCenter:CGPointMake(deepView.frame.size.width/2, deepView.frame.size.height/2+20)];
        [enterButton setTitle:@"确定" forState:UIControlStateNormal];
        [enterButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [enterButton addTarget:self action:@selector(changeCategory:) forControlEvents:UIControlEventTouchDown];
        [deepView addSubview:enterButton];
        [categoryName setText:categoryText];
    }else
    {
    UIButton*enterButton=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 25)];
    [enterButton setCenter:CGPointMake(deepView.frame.size.width/2, deepView.frame.size.height/2+20)];
    [enterButton setTitle:@"确定" forState:UIControlStateNormal];
    [enterButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [enterButton addTarget:self action:@selector(addCategory:) forControlEvents:UIControlEventTouchDown];
    [deepView addSubview:enterButton];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
#pragma mark - method
-(void)addCategory:(id)sender
{
    if ([categoryName.text isEqualToString:@""]) {
        UIAlertView*alter=[[UIAlertView alloc] initWithTitle:@"错误" message:@"请输入品类名" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
        return;
    }
    NSURL*url=[NSURL URLWithString:categoryInsertURL];
    ASIFormDataRequest*request=[ASIFormDataRequest requestWithURL:url];
    [request setPostValue:shopID forKey:@"shopID"];
    [request setPostValue:categoryName.text forKey:@"categoryName"];
    [request setCompletionBlock:^{
        SBJsonParser*parser=[[SBJsonParser alloc] init];
        NSDictionary*dic=[parser objectWithString:request.responseString];
        if ([[dic objectForKey:@"back"] integerValue]==1) {
            NSDictionary*categoryDic=[NSDictionary dictionaryWithObjectsAndKeys:shopID,sfCategoryShopID,[dic objectForKey:@"categoryID"],sfCategoryID,[dic objectForKey:@"categoryName"],sfCategoryName,nil];
            CategoryModel*categoryModel=[CategoryModel categoryFromDictionary:categoryDic];
            [CategoryModel saveNewCategory:categoryModel];
            [self dismiss];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"categoryAdd" object:dic];
        }
    }];
    [request setFailedBlock:^{
        UIAlertView*alter=[[UIAlertView alloc] initWithTitle:@"错误" message:@"登录失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
    }];
    [request startAsynchronous];
}
-(void)changeCategory:(id)sender
{
    if ([categoryName.text isEqualToString:@""]) {
        UIAlertView*alter=[[UIAlertView alloc] initWithTitle:@"错误" message:@"请输入品类名" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
        return;
    }
    if ([categoryText isEqualToString:categoryName.text]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"categoryAdd" object:nil];
        [self dismiss];
        return;
    }
    NSURL*url=[NSURL URLWithString:categoryChangeURL];
    ASIFormDataRequest*request=[ASIFormDataRequest requestWithURL:url];
    [request setPostValue:shopID forKey:@"shopID"];
    [request setPostValue:categoryName.text forKey:@"categoryName"];
    [request setPostValue:categoryID forKey:@"categoryID"];
    [request setCompletionBlock:^{
        SBJsonParser*parser=[[SBJsonParser alloc] init];
        NSDictionary*dic=[parser objectWithString:request.responseString];
        if ([[dic objectForKey:@"back"] integerValue]==1) {
            NSDictionary*categoryDic=[NSDictionary dictionaryWithObjectsAndKeys:shopID,sfCategoryShopID,categoryID,sfCategoryID,categoryName.text,sfCategoryName,nil];
            CategoryModel*categoryModel=[CategoryModel categoryFromDictionary:categoryDic];
            //[CategoryModel saveNewCategory:categoryModel];
            [CategoryModel updateCategory:categoryModel];
            [self dismiss];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"categoryAdd" object:dic];
        }
    }];
    [request setFailedBlock:^{
        UIAlertView*alter=[[UIAlertView alloc] initWithTitle:@"错误" message:@"登录失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
    }];
    [request startAsynchronous];
}
#pragma mark - animation
-(void)show
{
    UIWindow *keywindow = [[UIApplication sharedApplication] keyWindow];
    [keywindow addSubview:self];
    
    self.center = CGPointMake(keywindow.bounds.size.width/2.0f,
                              keywindow.bounds.size.height/2.0f);
    [self fadeIn];
}
- (void)fadeIn
{
    self.transform = CGAffineTransformMakeScale(1.3, 1.3);
    self.alpha = 0;
    [UIView animateWithDuration:.35 animations:^{
        self.alpha = 1;
        self.transform = CGAffineTransformMakeScale(1, 1);
    }];
    
}
- (void)dismiss
{
    [self fadeOut];
}
- (void)fadeOut
{
    [UIView animateWithDuration:.35 animations:^{
        self.transform = CGAffineTransformMakeScale(1.3, 1.3);
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished) {
            //[nameField resignFirstResponder];
            //[passwordField resignFirstResponder];
            [self removeFromSuperview];
        }
    }];
}
#pragma mark - blur
-(void)setBlurImage:(UIImage*)image
{
    backImage=[self blurryImage:image withBlurLevel:0.1f];
}
- (UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur {
    if ((blur < 0.0f) || (blur > 1.0f)) {
        blur = 0.5f;
    }
    
    int boxSize = (int)(blur * 100);
    boxSize -= (boxSize % 2) + 1;
    
    CGImageRef img = image.CGImage;
    
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    void *pixelBuffer;
    
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL,
                                       0, 0, boxSize, boxSize, NULL,
                                       kvImageEdgeExtend);
    
    
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(
                                             outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             CGImageGetBitmapInfo(image.CGImage));
    
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    //clean up
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    
    free(pixelBuffer);
    CFRelease(inBitmapData);
    
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageRef);
    
    return returnImage;
}
-(void)selfsetBack:(UIImage*)image
{
    overView.layer.contents=(id)backImage.CGImage;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}
@end
