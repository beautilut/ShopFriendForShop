//
//  TalkSetting.m
//  ShopFriendForShop
//
//  Created by Beautilut on 14-8-26.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import "TalkSetting.h"
#import "ReportViewController.h"
@interface TalkSetting ()
{
    UITableView*backTable;
    UISwitch*messageSwitch;
    NSString*userID;
}
@end

@implementation TalkSetting

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
    UIButton *backbutton=[[UIButton alloc] initWithFrame:CGRectMake(5, 24, 40, 40)];
    [backbutton addTarget:self action:@selector(popViewController:) forControlEvents:UIControlEventTouchDown];
    [backbutton setTitle:@"返回" forState:UIControlStateNormal];
    [backbutton setTitleColor:[UIColor colorWithRed:25.0/255.0 green:173.0/255.0 blue:220.0/255.0 alpha:1.0f] forState:UIControlStateNormal];
    [navi addSubview:backbutton];
    backTable=[[UITableView alloc] initWithFrame:CGRectMake(0, navi.frame.size.height, screenBounds.size.width, screenBounds.size.height-navi.frame.size.height) style:UITableViewStyleGrouped];
    [backTable setDelegate:self];
    [backTable setDataSource:self];
    [self.view addSubview:backTable];
    [self.view bringSubviewToFront:navi];
    // Do any additional setup after loading the view.
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
-(void)setUser:(NSString *)user
{
    userID=user;
}
#pragma mark delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell*cell;
    if (cell==nil) {
        cell=[[UITableViewCell alloc] init];
    }
    if (indexPath.section==0) {
        [cell.textLabel setText:@"清除历史消息"];
    }
    if (indexPath.section==1) {
        [cell.textLabel setText:@"投诉"];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        UIAlertView*alter=[[UIAlertView alloc] initWithTitle:nil message:@"是否清楚历史消息" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alter show];
    }
    if (indexPath.section==1) {
        ReportViewController*report=[[ReportViewController alloc] init];
        [self presentViewController:report animated:YES completion:nil];
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        [MessageModel cleanMessage:userID];
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
