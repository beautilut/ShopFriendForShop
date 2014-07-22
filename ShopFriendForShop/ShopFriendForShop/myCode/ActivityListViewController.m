//
//  ActivityListViewController.m
//  ShopFriendForShop
//
//  Created by Beautilut on 14-6-5.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import "ActivityListViewController.h"
#import "SFNaviBar.h"
@interface ActivityListViewController ()
{
    UITableView*activityListTable;
    
}
@end

@implementation ActivityListViewController

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
    [label setText:@"我的活动"];
    [label setTextColor:[UIColor colorWithRed:25.0/255.0 green:173.0/255.0 blue:220.0/255.0 alpha:1.0f]];
    [label setFont:[UIFont systemFontOfSize:19.0f]];
    [navi addSubview:label];
    
    UIButton *button=[[UIButton alloc] initWithFrame:CGRectMake(5, 24, 40, 40)];
    [button addTarget:self action:@selector(popViewController:) forControlEvents:UIControlEventTouchDown];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:25.0/255.0 green:173.0/255.0 blue:220.0/255.0 alpha:1.0f] forState:UIControlStateNormal];
    [navi addSubview:button];
    
    activityListTable=[[UITableView alloc] initWithFrame:CGRectMake(0, navi.frame.size.height, screenBounds.size.width, screenBounds.size.height-navi.frame.size.height) style:UITableViewStyleGrouped];
    [activityListTable setDelegate:self];
    [activityListTable setDataSource:self];
    [self.view addSubview:activityListTable];
    
    [self.view bringSubviewToFront:navi];
    // Do any additional setup after loading the view.
}
-(void)popViewController:(id)sender
{
    [self.navigationController   popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"HeadImageCell"];
    if (!cell) {
        cell=[[UITableViewCell alloc] init];
    }
    if ([indexPath section]==0&&indexPath.row==0) {
        [cell.textLabel setText:@"橱窗"];
    }
    if ([indexPath section]==0&&indexPath.row==1) {
        [cell.textLabel setText:@"活动"];
    }
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
         [self performSegueWithIdentifier:@"setWindow" sender:nil];
    }
    if (indexPath.row==1) {
         [self performSegueWithIdentifier:@"setActivity" sender:nil];
    }
    [tableView  deselectRowAtIndexPath:indexPath animated:YES];
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
