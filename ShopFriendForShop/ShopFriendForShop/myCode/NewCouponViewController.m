//
//  NewCouponViewController.m
//  ShopFriendForShop
//
//  Created by Beautilut on 14-7-1.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import "NewCouponViewController.h"
#import "SFNaviBar.h"
#import "SFTextField.h"
@interface NewCouponViewController ()
{
    UIScrollView*couponModelBackScroller;
    SFTextField*couponModel_Name;
    UITextView*couponModel_Info;
    UILabel*couponModel_InfoLabel;
    UITextView*couponModel_UseInfo;
    UILabel*couponModel_UseInfoLabel;
    UILabel*couponModel_BeginTime;
    UILabel*couponModel_EndTime;
    UIDatePicker*datePicker;
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
    [super viewDidLoad];
    CGRect screenBounds=[[UIScreen mainScreen] bounds];
    SFNaviBar*navi=[[SFNaviBar alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [navi openNaviShadow:YES];
    [self.view addSubview:navi];
    
    //[self.view setBackgroundColor:[UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:244.0/255.0 alpha:1]];
    
    UILabel*label=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    [label setCenter:CGPointMake(navi.frame.size.width/2, navi.frame.size.height-23)];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setText:@"新的优惠券"];
    [label setTextColor:[UIColor colorWithRed:25.0/255.0 green:173.0/255.0 blue:220.0/255.0 alpha:1.0f]];
    [label setFont:[UIFont systemFontOfSize:19.0f]];
    [navi addSubview:label];
    
    UIButton*leftButton=[[UIButton alloc] initWithFrame:CGRectMake(5, 24, 40, 40)];
    [leftButton addTarget:self action:@selector(backNavi:) forControlEvents:UIControlEventTouchDown];
    [leftButton.titleLabel setTextAlignment:NSTextAlignmentLeft];
    [leftButton setTitle:@"返回" forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor colorWithRed:25.0/255.0 green:173.0/255.0 blue:220.0/255.0 alpha:1.0f] forState:UIControlStateNormal];
    [navi addSubview:leftButton];
    
    UIButton*buttonRight=[[UIButton alloc] initWithFrame:CGRectMake(navi.frame.size.width-45,24,40,40)];
    [buttonRight addTarget:self action:@selector(addCoupon:) forControlEvents:UIControlEventTouchDown];
    [buttonRight setTitle:@"确定" forState:UIControlStateNormal];
    [buttonRight setTitleColor:[UIColor colorWithRed:25.0/255.0 green:173.0/255.0 blue:220.0/255.0 alpha:1.0f] forState:UIControlStateNormal];
    [navi addSubview:buttonRight];
    
    couponModelBackScroller=[[UIScrollView alloc] initWithFrame:CGRectMake(0, navi.frame.size.height, screenBounds.size.width,screenBounds.size.height-navi.frame.size.height)];
    //[couponModelBackScroller setBackgroundColor:[UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:244.0/255.0 alpha:1]];
    [self.view addSubview:couponModelBackScroller];
    
    couponModel_Name=[[SFTextField alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
    [couponModel_Name setDelegate:self];
    [couponModel_Name setCenter:CGPointMake(couponModelBackScroller.frame.size.width/2, 40)];
    [couponModel_Name setBackgroundColor:[UIColor whiteColor]];
    [couponModel_Name setPlaceholder:@"优惠券名称"];
    [couponModelBackScroller addSubview:couponModel_Name];
    UIView*leftView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
    [leftView setUserInteractionEnabled:NO];
    couponModel_Name.leftView=leftView;
    couponModel_Name.leftViewMode=UITextFieldViewModeAlways;
    
    couponModel_Info=[[UITextView alloc] initWithFrame:CGRectMake(0, 0, 300, 100)];
    [couponModel_Info setCenter:CGPointMake(couponModelBackScroller.frame.size.width/2,130)];
    [couponModel_Info setDelegate:self];
    [couponModel_Info setFont:[UIFont systemFontOfSize:17.0f]];
    [couponModelBackScroller addSubview:couponModel_Info];
    couponModel_InfoLabel=[[UILabel alloc] initWithFrame:CGRectMake(couponModel_Info.frame.origin.x+5, couponModel_Info.frame.origin.y, couponModel_Info.frame.size.width-3,40)];
    [couponModel_InfoLabel setText:@"优惠券详情"];
    [couponModel_InfoLabel setTextColor:[UIColor grayColor]];
    [couponModel_InfoLabel setFont:[UIFont systemFontOfSize:17.0f]];
    [couponModelBackScroller addSubview:couponModel_InfoLabel];
    
    UILabel*beginLabel=[[UILabel alloc] initWithFrame:CGRectMake(couponModel_Info.frame.origin.x+5,200, 100, 40)];
    [beginLabel  setText:@"起始时间"];
    [beginLabel setTextColor:[UIColor grayColor]];
    [couponModelBackScroller addSubview:beginLabel];
    
    UILabel*endLabel=[[UILabel alloc] initWithFrame:CGRectMake(beginLabel.frame.origin.x, 250, 100, 40)];
    [endLabel setTextColor:[UIColor grayColor]];
    [endLabel setText:@"结束时间"];
    [couponModelBackScroller addSubview:endLabel];
    
    
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
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
#pragma mark text delegate
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    textField.layer.borderColor=[UIColor orangeColor].CGColor;
    textField.layer.borderWidth=1.0f;
    textField.layer.masksToBounds=YES;
    textField.layer.cornerRadius=5.0f;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    textField.layer.borderWidth=0.0f;
    textField.layer.borderColor=[UIColor whiteColor].CGColor;
    textField.layer.masksToBounds=NO;
    textField.layer.cornerRadius=0.0f;
}
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    textView.layer.borderColor=[UIColor orangeColor].CGColor;
    textView.layer.borderWidth=1.0f;
    textView.layer.masksToBounds=YES;
    textView.layer.cornerRadius=5.0f;
}
-(void)textViewDidEndEditing:(UITextView *)textView
{
    textView.layer.borderColor=[UIColor whiteColor].CGColor;
    textView.layer.borderWidth=0.0f;
    textView.layer.masksToBounds=NO;
    textView.layer.cornerRadius=0.0f;
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (textView==couponModel_Info) {
        if (couponModel_Info.text.length==0) {
            if ([text isEqualToString:@""]) {
                [couponModel_InfoLabel setHidden:NO];
            }else
            {
                [couponModel_InfoLabel setHidden:YES];
            }
        }else
        {
            if (couponModel_Info.text.length==1) {
                if ([text isEqualToString:@""]) {
                    [couponModel_InfoLabel setHidden:NO];
                }else
                {
                    [couponModel_InfoLabel setHidden:YES];
                }
            }else{
                [couponModel_InfoLabel  setHidden:YES];
            }
        }
    }
    if (textView==couponModel_UseInfo) {
        if (couponModel_UseInfo.text.length==0) {
            if ([text isEqualToString:@""]) {
                [couponModel_UseInfo setHidden:NO];
            }else
            {
                [couponModel_UseInfo setHidden:YES];
            }
        }else
        {
            if (couponModel_UseInfo.text.length==1) {
                if ([text isEqualToString:@""]) {
                    [couponModel_UseInfoLabel setHidden:NO];
                }else
                {
                    [couponModel_UseInfoLabel setHidden:YES];
                }
            }else
            {
                [couponModel_UseInfoLabel setHidden:YES];
            }
        }
    }
    return YES;
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
