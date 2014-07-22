//
//  UserFansViewController.m
//  ShopFriendForShop
//
//  Created by Beautilut on 14-4-23.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import "UserFansViewController.h"
#import "SFNaviBar.h"
#import "FansCell.h"
#import "UserInfoViewController.h"
@interface UserFansViewController ()
{
    NSMutableArray*fansList;
    NSIndexPath*user;
}
@end

@implementation UserFansViewController

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
    fansList =[[NSMutableArray alloc] init];
    NSURL*url=[NSURL URLWithString:getUserFnas];
    ASIFormDataRequest*request=[ASIFormDataRequest requestWithURL:url];
    NSString*hostID=[[NSUserDefaults standardUserDefaults]objectForKey:kXMPPmyJID];
    [request setPostValue:hostID forKey:@"shopID"];
    [request setCompletionBlock:^{
        SBJsonParser*parser=[[SBJsonParser alloc] init];
        NSDictionary*dic=[parser objectWithString:request.responseString];
        if ([[dic objectForKey:@"back"] integerValue]==1) {
            fansList=[dic objectForKey:@"user"];
            [fansTable reloadData];
        }
    }];
    [request setFailedBlock:^{
        
    }];
    [request startAsynchronous];
    
    CGRect screenBounds=[[UIScreen mainScreen] bounds];
    SFNaviBar*navi=[[SFNaviBar alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [navi openNaviShadow:YES];
    [self.view addSubview:navi];
    UIButton *backbutton=[[UIButton alloc] initWithFrame:CGRectMake(5, 24, 40, 40)];
    [backbutton addTarget:self action:@selector(backNavi:) forControlEvents:UIControlEventTouchDown];
    [backbutton setTitle:@"返回" forState:UIControlStateNormal];
    [backbutton setTitleColor:[UIColor colorWithRed:25.0/255.0 green:173.0/255.0 blue:220.0/255.0 alpha:1.0f] forState:UIControlStateNormal];
    [navi addSubview:backbutton];
    
    fansTable=[[UITableView alloc] initWithFrame:CGRectMake(0, navi.frame.size.height, screenBounds.size.width, screenBounds.size.height-40-navi.frame.size.height)];
    [fansTable setBackgroundColor:[UIColor clearColor]];
    [fansTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [fansTable setDelegate:self];
    [fansTable setDataSource:self];
    //float topInset = self.navigationController.navigationBar.frame.size.height+20;
    //fansTable.contentInset = UIEdgeInsetsMake(topInset, 0, 0, 0);
    [self.view addSubview:fansTable];
    
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
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return fansList.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FansCell*cell=[tableView dequeueReusableCellWithIdentifier:@"fansCell"];
    if (cell==nil) {
        NSArray*nib=[[NSBundle mainBundle] loadNibNamed:@"FansCell" owner:self options:nil];
        for (id oneObject in nib) {
            if ([oneObject isKindOfClass:[FansCell class]]) {
                cell=(FansCell*)oneObject;
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
                NSDictionary*dic=[fansList objectAtIndex:indexPath.row];
                NSString*userID=[dic objectForKey:@"user_ID"];
                NSURL*url=[NSURL URLWithString:USER_IMAGE_URL(userID)];
                [cell.headImage setImageWithURL:url];
                cell.headImage.layer.borderWidth=2;
                cell.headImage.layer.borderColor=[UIColor whiteColor].CGColor;
                cell.headImage.layer.cornerRadius=CGRectGetHeight(cell.headImage.bounds)/2;
                cell.headImage.clipsToBounds=YES;
                [cell.name setText:[dic objectForKey:@"user_name"]];
            }
        }
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    user=indexPath;
    [self performSegueWithIdentifier:@"userInfo" sender:nil];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"userInfo"]) {
        [[segue destinationViewController] getUserInfo:[fansList objectAtIndex:user.row]];
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
