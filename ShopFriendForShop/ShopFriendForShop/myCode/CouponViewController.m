//
//  CouponViewController.m
//  ShopFriendForShop
//
//  Created by Beautilut on 14-6-29.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import "CouponViewController.h"
#import "SFNaviBar.h"
#import "NewCouponViewController.h"
@interface CouponViewController ()
{
    UITableView*couponTableView;
    NSArray*couponArray;
}
@end

@implementation CouponViewController

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
    [label setText:@"我的优惠券"];
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
    [buttonRight setTitle:@"添加" forState:UIControlStateNormal];
    [buttonRight setTitleColor:[UIColor colorWithRed:25.0/255.0 green:173.0/255.0 blue:220.0/255.0 alpha:1.0f] forState:UIControlStateNormal];
    [navi addSubview:buttonRight];
    
    [[WebCouponMethods sharedCoupon] setDelegate:self];
    [[WebCouponMethods sharedCoupon] webCouponGet];
    
    //tableView
    couponTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, naviHight, screenBounds.size.width, screenBounds.size.height-navi.frame.size.height) style:UITableViewStyleGrouped];
    [couponTableView setDelegate:self];
    [couponTableView setDataSource:self];
    
    [self.view addSubview:couponTableView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(newCouponGet:) name:@"newCoupon" object:nil];
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
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)newCouponGet:(id)sender
{
    [[WebCouponMethods sharedCoupon] setDelegate:self];
    [[WebCouponMethods sharedCoupon] webCouponGet];
}
#pragma mark -tableView-
-(void)addCoupon:(id)sender
{
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController*navi=[mainStoryboard instantiateViewControllerWithIdentifier:@"newCoupon"];
    [self presentViewController:navi animated:YES completion:nil];
}
#pragma mark talbeViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return couponArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5.0f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 8.0f;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell*cell;
    if (cell==nil) {
        cell=[[UITableViewCell alloc] init];
    }
    NSDictionary*dic=[couponArray objectAtIndex:indexPath.section];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    UILabel*namelabel=[[UILabel alloc] initWithFrame:CGRectMake(5, 5, cell.frame.size.width-10, 45)];
    [namelabel setTextAlignment:NSTextAlignmentCenter];
    [namelabel setFont:[UIFont systemFontOfSize:20.0f]];
    [namelabel setText:[dic objectForKey:sfCouponModelName]];
    [namelabel setTextColor:[UIColor colorWithRed:25.0/255.0 green:173.0/255.0 blue:220.0/255.0 alpha:1.0f]];
    [cell addSubview:namelabel];
    UILabel*dateLabel=[[UILabel alloc] initWithFrame:CGRectMake(5, 50, (cell.frame.size.width-10)/2, 45)];
    [dateLabel setTextAlignment:NSTextAlignmentCenter];
    NSString*date=[[dic objectForKey:sfCouponModelEndTime] substringToIndex:10];
    [dateLabel setText:date];
    [cell addSubview:dateLabel];
    UILabel*numberLabel=[[UILabel alloc] initWithFrame:CGRectMake((cell.frame.size.width-10)/2, 50, (cell.frame.size.width-10)/2, 45)];
    [numberLabel setText:[dic objectForKey:sfCouponModelNumber]];
    [numberLabel setTextAlignment:NSTextAlignmentRight];
    [cell addSubview:numberLabel];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController*navi=[mainStoryboard instantiateViewControllerWithIdentifier:@"newCoupon"];
    [(NewCouponViewController*)navi.topViewController getCoupon:[couponArray objectAtIndex:indexPath.section]];
    [self presentViewController:navi animated:YES completion:nil];
}
#pragma mark couponDelegate
-(void)webCouponGetSuccess:(NSArray *)dic
{
    couponArray=dic;
    [couponTableView reloadData];
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
