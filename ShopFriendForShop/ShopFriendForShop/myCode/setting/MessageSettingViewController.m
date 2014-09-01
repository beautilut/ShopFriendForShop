//
//  MessageSettingViewController.m
//  ShopFriendForShop
//
//  Created by Beautilut on 14-8-14.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import "MessageSettingViewController.h"

@interface MessageSettingViewController ()
{
    UITableView*settinglist;
    UISwitch*messageSwitch;
    UISwitch*messageShackSwitch;
    UISwitch*orderSwitch;
    UISwitch*orderShackSwitch;
}
@end

@implementation MessageSettingViewController

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
    
    UIButton*leftButton=[[UIButton alloc] initWithFrame:CGRectMake(5, 24, 40, 40)];
    [leftButton addTarget:self action:@selector(backNavi:) forControlEvents:UIControlEventTouchDown];
    [leftButton.titleLabel setTextAlignment:NSTextAlignmentLeft];
    [leftButton setTitle:@"返回" forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor colorWithRed:25.0/255.0 green:173.0/255.0 blue:220.0/255.0 alpha:1.0f] forState:UIControlStateNormal];
    [navi addSubview:leftButton];
    
    settinglist=[[UITableView alloc] initWithFrame:CGRectMake(0,navi.frame.size.height, screenBounds.size.width, screenBounds.size.height-navi.frame.size.height) style:UITableViewStyleGrouped];
    [settinglist setDelegate:self];
    [settinglist setDataSource:self];
    [self.view addSubview:settinglist];
    
    messageSwitch=[[UISwitch alloc] init];
    [messageSwitch setTag:0];
    [messageSwitch addTarget:self action:@selector(switchValueChange:) forControlEvents:UIControlEventValueChanged];
    messageShackSwitch=[[UISwitch alloc] init];
    [messageShackSwitch setTag:1];
    [messageShackSwitch addTarget:self action:@selector(switchValueChange:) forControlEvents:UIControlEventValueChanged];
    orderSwitch=[[UISwitch alloc] init];
    [orderSwitch setTag:2];
    [orderSwitch addTarget:self action:@selector(switchValueChange:) forControlEvents:UIControlEventValueChanged];
    orderShackSwitch=[[UISwitch alloc] init];
    [orderShackSwitch setTag:3];
    [orderShackSwitch addTarget:self action:@selector(switchValueChange:) forControlEvents:UIControlEventValueChanged];
    
    [self.view bringSubviewToFront:navi];
    // Do any additional setup after loading the view.`
}
-(void)viewWillAppear:(BOOL)animated
{
    messageSwitch.on=[[[InfoManager sharedInfo].settingDic objectForKey:@"messageSound"] boolValue];
    messageShackSwitch.on=[[[InfoManager sharedInfo].settingDic objectForKey:@"messageShack"] boolValue];
    orderSwitch.on=[[[InfoManager sharedInfo].settingDic objectForKey:@"orderSound"] boolValue];
    orderShackSwitch.on=[[[InfoManager sharedInfo].settingDic objectForKey:@"orderShack"] boolValue];
}
-(void)backNavi:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)switchValueChange:(id)sender
{
    UISwitch*aSwitch=(UISwitch*)sender;
    switch ([aSwitch tag]) {
        case 0:
            [[InfoManager sharedInfo].settingDic setObject:[NSNumber numberWithBool:aSwitch.on]forKey:@"messageSound"];
            [[InfoManager sharedInfo] writeInfoFile];
            break;
        case 1:
            [[InfoManager sharedInfo].settingDic setObject:[NSNumber numberWithBool:aSwitch.on]forKey:@"messageShack"];
            [[InfoManager sharedInfo] writeInfoFile];
            break;
        case 2:
            [[InfoManager sharedInfo].settingDic setObject:[NSNumber numberWithBool:aSwitch.on]forKey:@"orderSound"];
            [[InfoManager sharedInfo] writeInfoFile];
            break;
        case 3:
            [[InfoManager sharedInfo].settingDic setObject:[NSNumber numberWithBool:aSwitch.on]forKey:@"orderShack"];
            [[InfoManager sharedInfo] writeInfoFile];
            break;
        default:
            break;
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark table
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell*cell;
    if (!cell) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    if ([indexPath section]==0&&indexPath.row==0) {
        [cell.textLabel setText:@"声音"];
        [messageSwitch setCenter:CGPointMake(cell.frame.size.width-messageSwitch.frame.size.width/2-10, cell.frame.size.height/2)];
        [cell addSubview:messageSwitch];
    }
    if ([indexPath section]==0&&indexPath.row==1) {
        [cell.textLabel setText:@"震动"];
        [messageShackSwitch setCenter:CGPointMake(cell.frame.size.width-messageShackSwitch.frame.size.width/2-10, cell.frame.size.height/2)];
        [cell addSubview:messageShackSwitch];
    }
    if ([indexPath section]==1&&indexPath.row==0) {
        [cell.textLabel setText:@"声音"];
        
        [orderSwitch setCenter:CGPointMake(cell.frame.size.width-orderSwitch.frame.size.width/2-10, cell.frame.size.height/2)];
        [cell addSubview:orderSwitch];
    }
    if ([indexPath section]==1&&indexPath.row==1) {
        [cell.textLabel setText:@"震动"];
        
        [orderShackSwitch setCenter:CGPointMake(cell.frame.size.width-orderShackSwitch.frame.size.width/2-10, cell.frame.size.height/2)];
        [cell addSubview:orderShackSwitch];
    }
    return cell;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CGRect screenRect=[[UIScreen mainScreen] bounds];
    UIView*view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, screenRect.size.width, 40)];
    UILabel*nameLabel=[[UILabel alloc] initWithFrame:CGRectMake(10, 5,100, 30)];
    [nameLabel setFont:[UIFont systemFontOfSize:18.0f]];
    switch (section) {
        case 0:
            [nameLabel setText:@"顾客"];
            break;
        case 1:
            [nameLabel setText:@"订单"];
            break;
        default:
            break;
    }
    [view addSubview:nameLabel];
    return view;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    CGRect screenRect=[[UIScreen mainScreen] bounds];
    UIView*view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, screenRect.size.width, 60)];
    UILabel*infoLabel=[[UILabel alloc] initWithFrame:CGRectMake(10, 5, view.frame.size.width-20, view.frame.size.height)];
    [infoLabel setFont:[UIFont systemFontOfSize:14.0f]];
    switch (section) {
        case 0:
            [infoLabel setText:@"当店友店铺在运行时，你可以设置是否需要在接收到新的顾客信息时提示音或震动"];
            break;
        case 1:
            [infoLabel setText:@"当店友店铺在运行时，你可以设置是否需要在接收到新的订单信息时提示音或震动"];
            break;
        default:
            break;
    }
    [infoLabel setTextColor:[UIColor grayColor]];
    infoLabel.numberOfLines=3;
    [infoLabel sizeToFit];
    [infoLabel setTextAlignment:NSTextAlignmentCenter];
    [view addSubview:infoLabel];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40.0f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 60.0f;
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
