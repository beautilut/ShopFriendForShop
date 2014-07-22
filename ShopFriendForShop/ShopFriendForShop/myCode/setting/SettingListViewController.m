//
//  SettingListViewController.m
//  ShopFriendForShop
//
//  Created by Beautilut on 14-4-16.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import "SettingListViewController.h"
#import "SFNaviBar.h"
@interface SettingListViewController ()

@end

@implementation SettingListViewController

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
    
    UILabel*label=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    [label setCenter:CGPointMake(navi.frame.size.width/2, navi.frame.size.height-23)];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setText:@"店铺设置"];
    [label setTextColor:[UIColor colorWithRed:25.0/255.0 green:173.0/255.0 blue:220.0/255.0 alpha:1.0f]];
    [label setFont:[UIFont systemFontOfSize:19.0f]];
    [navi addSubview:label];
    
    UIButton*leftButton=[[UIButton alloc] initWithFrame:CGRectMake(5, 24, 40, 40)];
    [leftButton addTarget:self action:@selector(backNavi:) forControlEvents:UIControlEventTouchDown];
    [leftButton.titleLabel setTextAlignment:NSTextAlignmentLeft];
    [leftButton setTitle:@"返回" forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor colorWithRed:25.0/255.0 green:173.0/255.0 blue:220.0/255.0 alpha:1.0f] forState:UIControlStateNormal];
    [navi addSubview:leftButton];
    
    UITableView*settingTable=[[UITableView alloc] initWithFrame:CGRectMake(0, navi.frame.size.height, screenRect.size.width, screenRect.size.height-navi.frame.size.height) style:UITableViewStyleGrouped];
    
    [settingTable setDelegate:self];
    [settingTable setDataSource:self];
    
    [self.view addSubview:settingTable];
    
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
#pragma mark - table -
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 2;
    }
    if (section==1) {
        return 1;
    }
    if (section==2) {
        return 1;
    }
    if (section==3) {
        return 1;
    }
    return 0;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell*cell;
    if (!cell) {
        cell=[[UITableViewCell alloc] init];
    }
    if ([indexPath section]==0&&indexPath.row==0) {
        [cell.textLabel setText:@"修改基本信息"];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    if ([indexPath section]==0&&indexPath.row==1) {
        [cell.textLabel setText:@"修改密码"];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
//    if ([indexPath section]==1&&indexPath.row==0) {
//        [cell.textLabel setText:@"橱窗修改"];
//        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
//    }
    if ([indexPath section]==1&&indexPath.row==0) {
        [cell.textLabel setText:@"反馈"];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    if ([indexPath section]==2&&indexPath.row==0) {
        [cell.textLabel setText:@"退出"];
        [cell.textLabel setTextAlignment:NSTextAlignmentCenter];
        [cell setBackgroundColor:[UIColor redColor]];
        [cell.textLabel setTextColor:[UIColor whiteColor]];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath section]==0&&indexPath.row==0) {
        [self  performSegueWithIdentifier:@"shopBaseInfo" sender:nil];
    }
//    if ([indexPath section]==1&&indexPath.row==0) {
//        [self performSegueWithIdentifier:@"showWindow" sender:nil];
//    }
    if ([indexPath section]==0&&indexPath.row==1) {
        [self performSegueWithIdentifier:@"passwordChange" sender:nil];
    }
    if ([indexPath section]==1&&indexPath.row==0) {
        [self performSegueWithIdentifier:@"feedBack" sender:nil];
    }
    if ([indexPath section]==2&&indexPath.row==0) {
        UIAlertView*alterView=[[UIAlertView alloc] initWithTitle:@"" message:@"是否退出" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alterView show];
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
        if (buttonIndex==1) {
            [[SFXMPPManager  sharedInstance] disconnect];
            [InfoManager sharedInfo].myShop =nil;
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:kXMPPmyJID];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:kXMPPmyPassword];
            UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            //UserEnterViewController*userEnterView=[mainStoryboard instantiateViewControllerWithIdentifier:@"userEnter"];
            UINavigationController*navi=[mainStoryboard instantiateViewControllerWithIdentifier:@"DisplayView"];
            [self  presentViewController:navi animated:NO completion:nil];
            [self.navigationController popToRootViewControllerAnimated:YES];
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
