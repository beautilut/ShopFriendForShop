//
//  WebCategoryViewController.m
//  ShopFriendForShop
//
//  Created by Beautilut on 14-3-15.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import "WebCategoryViewController.h"
#import "SFNaviBar.h"
@interface WebCategoryViewController ()
{
    NSDictionary*categoryDic;
    NSArray*rangeArray;
    UITableView*categoryTable;
}
@end

@implementation WebCategoryViewController
@synthesize delegate;
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
    UIButton *button=[[UIButton alloc] initWithFrame:CGRectMake(5, 24, 40, 40)];
    [button addTarget:self action:@selector(backNavi:) forControlEvents:UIControlEventTouchDown];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:25.0/255.0 green:173.0/255.0 blue:220.0/255.0 alpha:1.0f] forState:UIControlStateNormal];
    [navi addSubview:button];
    categoryTable=[[UITableView alloc] initWithFrame:CGRectMake(0, navi.frame.size.height, screenRect.size.width, screenRect.size.height-navi.frame.size.height) style:UITableViewStyleGrouped];
    [categoryTable setDelegate:self];
    [categoryTable setDataSource:self];
    [self.view addSubview:categoryTable];
    [self.view bringSubviewToFront:navi];
    ASIFormDataRequest*request=[ASIFormDataRequest requestWithURL:[NSURL URLWithString:getAllShopCategory]];
    [request setCompletionBlock:^{
        SBJsonParser*paser=[[SBJsonParser alloc] init];
        categoryDic=[paser objectWithString:request.responseString];
        rangeArray=[categoryDic objectForKey:@"range"];
        [categoryTable reloadData];
        //NSDictionary*rootDic=[paser objectWithString:request.responseString];
    }];
    [request setFailedBlock:^{
        
    }];
    [request startAsynchronous];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return rangeArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"categoryCell"];
    // Configure the cell...
    NSString*key=[[rangeArray objectAtIndex:indexPath.row] stringValue];
    NSString*text=[categoryDic objectForKey:key];
    [cell.textLabel setText:[categoryDic objectForKey:key]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString*key=[[rangeArray objectAtIndex:indexPath.row] stringValue];
    NSArray*array=[[NSArray alloc] initWithObjects:[NSNumber numberWithInt:[key integerValue]],[categoryDic objectForKey:key],nil];
    if ([delegate respondsToSelector:@selector(choose:)]) {
        [delegate choose:array];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
@end
