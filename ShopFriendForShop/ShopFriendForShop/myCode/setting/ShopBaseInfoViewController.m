//
//  ShopBaseInfoViewController.m
//  ShopFriendForShop
//
//  Created by Beautilut on 14-4-16.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import "ShopBaseInfoViewController.h"
#import "SFNaviBar.h"
#import "InfoChangeViewController.h"
@interface ShopBaseInfoViewController ()
{
    ShopObject*myShop;
    NSString*infoKind;
    UITableView*settingTable;
}
@end

@implementation ShopBaseInfoViewController

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
    [label setCenter:CGPointMake(navi.frame.size.width/2, navi.frame.size.height-20)];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setText:@"基本信息设置"];
    [label setTextColor:[UIColor colorWithRed:25.0/255.0 green:173.0/255.0 blue:220.0/255.0 alpha:1.0f]];
    [label setFont:[UIFont systemFontOfSize:19.0f]];
    [navi addSubview:label];
    
    UIButton*leftButton=[[UIButton alloc] initWithFrame:CGRectMake(5, 24, 40, 40)];
    [leftButton addTarget:self action:@selector(backNavi:) forControlEvents:UIControlEventTouchDown];
    [leftButton.titleLabel setTextAlignment:NSTextAlignmentLeft];
    [leftButton setTitle:@"返回" forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor colorWithRed:25.0/255.0 green:173.0/255.0 blue:220.0/255.0 alpha:1.0f] forState:UIControlStateNormal];
    [navi addSubview:leftButton];
    
    settingTable=[[UITableView alloc] initWithFrame:CGRectMake(0, navi.frame.size.height, screenRect.size.width, screenRect.size.height-navi.frame.size.height) style:UITableViewStyleGrouped];
    
    [settingTable setDelegate:self];
    [settingTable setDataSource:self];
    
    [self.view addSubview:settingTable];
    [self.view bringSubviewToFront:navi];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    myShop=[ShopObject fetchShopInfo];
    [settingTable reloadData];
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
#pragma mark - table -
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell*cell;
    if (!cell) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@""];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    if ([indexPath section]==0) {
        [cell.textLabel setText:@"店名"];
        [cell.detailTextLabel setText:myShop.shopName];
    }
    if ([indexPath section]==1) {
        [cell.textLabel setText:@"类别"];
        [cell.detailTextLabel setText:[NSString stringWithFormat:@"%@,%@",myShop.shopCategoryWord,myShop.shopCategoryDetail]];
    }
    if ([indexPath section]==2) {
        [cell.textLabel setText:@"电话"];
        [cell.detailTextLabel setText:myShop.shopTel];
    }
    if ([indexPath section]==3) {
        [cell.textLabel setText:@"地址"];
        [cell.detailTextLabel setText:myShop.shopAddress];
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath section]==0) {
        infoKind=@"name";
        [self performSegueWithIdentifier:@"infoChange" sender:nil];
    }
    if ([indexPath section]==1) {
        infoKind=@"category";
        [self performSegueWithIdentifier:@"infoChange" sender:nil];
    }
    if ([indexPath section]==2) {
        infoKind=@"phone";
        [self performSegueWithIdentifier:@"infoChange" sender:nil];
    }
    if ([indexPath section]==3) {
        UIAlertView*alter=[[UIAlertView alloc] initWithTitle:nil message:@"商铺地址暂不允许修改，如有变更请联系店友" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alter show];
    }
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"infoChange"]) {
        [[segue destinationViewController] getInfoKind:infoKind];
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
