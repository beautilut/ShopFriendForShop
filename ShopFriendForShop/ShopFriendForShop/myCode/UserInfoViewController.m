//
//  UserInfoViewController.m
//  ShopFriendForShop
//
//  Created by Beautilut on 14-4-23.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import "UserInfoViewController.h"
#import "SFNaviBar.h"
@interface UserInfoViewController ()

@end

@implementation UserInfoViewController
@synthesize user;
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
    [self.navigationController.navigationBar setHidden:YES];
    SFNaviBar*navi=[[SFNaviBar alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [navi openNaviShadow:YES];
    [self.view addSubview:navi];
    
    UILabel*label=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    [label setText:[user objectForKey:@"user_name"]];
    label.font = [UIFont boldSystemFontOfSize:19.0f];
    label.textColor = [UIColor lightTextColor];
    label.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setTextColor:[UIColor colorWithRed:25.0/255.0 green:173.0/255.0 blue:220.0/255.0 alpha:1.0f]];
    [label setCenter:CGPointMake(navi.frame.size.width/2, navi.frame.size.height-23)];
    [navi addSubview:label];

    UIButton *button=[[UIButton alloc] initWithFrame:CGRectMake(5, 24, 40, 40)];
    [button addTarget:self action:@selector(backNavi:) forControlEvents:UIControlEventTouchDown];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:25.0/255.0 green:173.0/255.0 blue:220.0/255.0 alpha:1.0f] forState:UIControlStateNormal];
    [navi addSubview:button];
    UIButton*buttonRight=[[UIButton alloc] initWithFrame:CGRectMake(navi.frame.size.width-65, 24, 60, 40)];
    //[buttonRight addTarget:self action:@selector() forControlEvents:UIControlEventTouchDown];
    [button.titleLabel setTextAlignment:NSTextAlignmentRight];
    //[buttonRight setTitle:@"下一步" forState:UIControlStateNormal];
    [buttonRight setTitleColor:[UIColor colorWithRed:25.0/255.0 green:173.0/255.0 blue:220.0/255.0 alpha:1.0f] forState:UIControlStateNormal];
    [navi addSubview:buttonRight];
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
-(void)getUserInfo:(NSDictionary *)info
{
    user=info;
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
