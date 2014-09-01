//
//  DatePickViewController.m
//  ShopFriendForShop
//
//  Created by Beautilut on 14-8-22.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import "DatePickViewController.h"
#import "SFNaviBar.h"
@interface DatePickViewController ()
{
    UIDatePicker*datePicker;
}
@end

@implementation DatePickViewController
@synthesize oldDate,delegate;

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
    
    UIImageView*backImage=[[UIImageView alloc] initWithFrame:CGRectMake(5,32, 20, 20)];
    [backImage setImage:[UIImage imageNamed:@"back"]];
    [navi addSubview:backImage];
    UIButton *button=[[UIButton alloc] initWithFrame:CGRectMake(0,24,40, 40)];
    [button addTarget:self action:@selector(backNavi:) forControlEvents:UIControlEventTouchDown];
    [navi addSubview:button];
    
    backImage=[[UIImageView alloc] initWithFrame:CGRectMake(navi.frame.size.width-35, 32, 20, 20)];
    [backImage setImage:[UIImage imageNamed:@"check"]];
    [navi addSubview:backImage];
    UIButton*checkButton=[[UIButton alloc] initWithFrame:CGRectMake(navi.frame.size.width-40,24,40,40)];
    [checkButton addTarget:self action:@selector(infoChange:) forControlEvents:UIControlEventTouchDown];
    [navi addSubview:checkButton];
    
    UIView*backView=[[UIView alloc] initWithFrame:CGRectMake(0, navi.frame.size.height, screenBounds.size.width, screenBounds.size.height-navi.frame.size.height)];
    [self.view addSubview:backView];
    datePicker=[[UIDatePicker alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height,screenBounds.size.width , 400)];
    [datePicker setDatePickerMode:UIDatePickerModeDate];
    [backView addSubview:datePicker];
    
    [self.view bringSubviewToFront:navi];
    // Do any additional setup after loading the view.
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
-(void)infoChange:(id)sender
{
    double count= [datePicker.date timeIntervalSinceNow];
    if (count>0) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString*old=[dateFormatter stringFromDate:oldDate];
        NSString*new=[dateFormatter stringFromDate:datePicker.date];
        if ([old isEqual:new]) {
            [self.navigationController popViewControllerAnimated:YES];
            return;
        }else if(datePicker.date )
        {
            if ([delegate respondsToSelector:@selector(dateChange:)]) {
                [delegate dateChange:datePicker.date];
            }
            [self.navigationController popViewControllerAnimated:YES];
            return;
        }

    }else
    {
        UIAlertView*alter=[[UIAlertView alloc]initWithTitle:nil message:@"所选日期必须大于今日" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
        return;
    }
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
