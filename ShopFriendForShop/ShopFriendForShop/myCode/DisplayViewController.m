//
//  DisplayViewController.m
//  ShopFriendForShop
//
//  Created by Beautilut on 14-1-23.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import "DisplayViewController.h"

@interface DisplayViewController ()
{
    UITableView*selectTableView;
}
@end

@implementation DisplayViewController

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
    selectTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, screenRect.size.height-100, screenRect.size.width,80)];
    selectTableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    //[selectTableView setSeparatorColor:[UIColor colorWithRed:70.0/255.0 green:137.0/255.0 blue:252.0/255.0 alpha:0.5f]];
    [selectTableView setDelegate:self];
    [selectTableView setDataSource:self];
    [selectTableView setScrollEnabled:NO];
    [self.view addSubview:selectTableView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dismiss:) name:@"registerSuccess" object:nil];
	// Do any additional setup after loading the view.
}
-(void)dismiss:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - tableView Methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Get the transcript for this row
   // Transcript *transcript = [self.transcripts objectAtIndex:indexPath.row];
    UITableViewCell*cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"defaultCell"];
    [cell.textLabel setTextColor:[UIColor colorWithRed:70.0/255.0 green:137.0/255.0 blue:252.0/255.0 alpha:0.9f]];
    //[cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    cell.selectionStyle=UITableViewCellSelectionStyleBlue;
    if (indexPath.row==0) {
        [cell.textLabel setText:@"登录"];
    }
    if (indexPath.row==1) {
        [cell.textLabel setText:@"注册"];
    }
    [cell.textLabel setTextColor:[UIColor colorWithRed:25.0/255.0 green:173.0/255.0 blue:220.0/255.0 alpha:1.0f]];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0)
    {
        [self performSegueWithIdentifier:@"enter" sender:nil];
    }
    else if(indexPath.row==1)
    {
        [self performSegueWithIdentifier:@"register" sender:nil];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
