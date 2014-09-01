//
//  ServerListViewController.m
//  ShopFriendForShop
//
//  Created by Beautilut on 14-8-14.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import "ServerListViewController.h"
#import "ServerDetailViewController.h"

@interface ServerListViewController ()
{
    UITextField*searchField;
    UIControl*backView;
    ServerScrollerView*ownServerList;
    ServerScrollerView*serverList;
    NSMutableArray*myServers;
    NSArray*allServerList;
    NSString*imagePath;
    NSDictionary*serverDetailDic;
}
@end

@implementation ServerListViewController

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
    
    [[WebServerMethods shared] setDelegate:self];
    [[WebServerMethods shared] getServerList];
    [[WebServerMethods shared] showMyServer:@"all"];
    
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
    
//    UIButton*buttonRight=[[UIButton alloc] initWithFrame:CGRectMake(navi.frame.size.width-45,24,40,40)];
//    [buttonRight addTarget:self action:@selector(serverSetting:) forControlEvents:UIControlEventTouchDown];
//    [buttonRight setTitle:@"编辑" forState:UIControlStateNormal];
//    [buttonRight setTitleColor:[UIColor colorWithRed:25.0/255.0 green:173.0/255.0 blue:220.0/255.0 alpha:1.0f] forState:UIControlStateNormal];
//    [navi addSubview:buttonRight];
    
    UILabel*label=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    [label setCenter:CGPointMake(navi.frame.size.width/2, navi.frame.size.height-23)];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setText:@"服务"];
    [label setTextColor:[UIColor colorWithRed:25.0/255.0 green:173.0/255.0 blue:220.0/255.0 alpha:1.0f]];
    [label setFont:[UIFont systemFontOfSize:19.0f]];
    [navi addSubview:label];
    
    backView=[[UIControl alloc] initWithFrame:CGRectMake(0, navi.frame.size.height, screenBounds.size.width, screenBounds.size.height-navi.frame.size.height)];
    [backView addTarget:self action:@selector(done:) forControlEvents:UIControlEventTouchDown];
    //[backView setBackgroundColor:[UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1.0]];
    [self.view addSubview:backView];
    
    searchField=[[UITextField alloc] initWithFrame:CGRectMake(0, 0, screenBounds.size.width-50, 40)];
    [searchField setCenter:CGPointMake(screenBounds.size.width/2, 30)];
    [searchField setBorderStyle:UITextBorderStyleRoundedRect];
    [searchField setPlaceholder:@"输入服务名称"];
    [searchField setDelegate:self];
    [searchField setReturnKeyType:UIReturnKeyDone];
   // [backView addSubview:searchField];
    
    UIControl*ownView=[[UIControl alloc] initWithFrame:CGRectMake(0,0, screenBounds.size.width,(backView.frame.size.height-60)/2)];
    [ownView addTarget:self action:@selector(done:) forControlEvents:UIControlEventTouchDown];
    [ownView setBackgroundColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5]];
    [backView addSubview:ownView];
    CGFloat title=ownView.frame.size.height*0.15;
    UILabel*titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, ownView.frame.size.width, title)];
    [titleLabel setBackgroundColor:[UIColor colorWithRed:0.1 green:0.68 blue:0.86 alpha:0.5]];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [titleLabel setText:@"  已注册服务"];
    [ownView addSubview:titleLabel];
    ownServerList=[[ServerScrollerView alloc] initWithFrame:CGRectMake(0,titleLabel.frame.size.height, ownView.frame.size.width, ownView.frame.size.height-titleLabel.frame.size.height)];
    [ownServerList setDelegate:self];
    [ownView addSubview:ownServerList];
    
    UIControl*listView=[[UIControl alloc] initWithFrame:CGRectMake(0, ownView.frame.origin.y+ownView.frame.size.height,screenBounds.size.width, ownView.frame.size.height)];
    [listView addTarget:self action:@selector(done:) forControlEvents:UIControlEventTouchDown];
    [listView setBackgroundColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5]];
    [backView addSubview:listView];
    
    UILabel*titleLabel2=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, listView.frame.size.width, title)];
    [titleLabel2 setBackgroundColor:[UIColor colorWithRed:0.1 green:0.68 blue:0.86 alpha:0.5]];
    [titleLabel2 setTextColor:[UIColor whiteColor]];
    [titleLabel2 setText:@"  未注册服务"];
    [listView addSubview:titleLabel2];
    serverList=[[ServerScrollerView alloc] initWithFrame:CGRectMake(0, titleLabel2.frame.size.height, listView.frame.size.width, listView.frame.size.height-titleLabel2.frame.size.height)];
    [listView addSubview:serverList];
    [serverList setDelegate:self];
    
    //notification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(newServerRegiter:) name:@"newServerRegister" object:nil];
    
    [self.view bringSubviewToFront:navi];
    // Do any additional setup after loading the view.
}
-(void)backNavi:(id)sender
{
    [self.navigationController  popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)done:(id)sender
{
    [searchField resignFirstResponder];
}
-(void)serverSetting:(id)sender
{
    
}
#pragma mark serverDelegate
-(void)getServerListSuccess:(NSDictionary *)dic
{
    if (myServers==nil) {
        allServerList=[dic objectForKey:@"server"];
    }else
    {
        [self rangeServers:[dic objectForKey:@"server"]];
    }
    imagePath=[dic objectForKey:@"imagePath"];
    [serverList detailTheScroller:allServerList withImagePath:imagePath];
}
-(void)getServerListFial
{
    
}
-(void)showMyServerSuccess:(NSDictionary *)dic
{
    myServers=[dic objectForKey:@"server"];
    imagePath=[dic objectForKey:@"imagePath"];
    if (allServerList!=nil) {
        [self rangeServers:allServerList];
        //[serverList serverScrollViewReloadData:allServerList withImagePath:imagePath];
        [serverList serverScrollViewReloadData:allServerList withImagePath:imagePath];
    }
    [ownServerList detailTheScroller:myServers withImagePath:imagePath];
}
-(void)showMyServerFail
{
    
}
#pragma mark textFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
#pragma mark serverScroll delegate
-(void)serverInfo:(NSDictionary *)dic
{
    serverDetailDic=dic;
    [self performSegueWithIdentifier:@"serverDetail" sender:nil];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"serverDetail"]) {
        [[segue destinationViewController] getServerDetailInfo:serverDetailDic];
    }
}
-(void)rangeServers:(NSArray*)array
{
    NSMutableArray*newArray=[[NSMutableArray alloc] init];
    for (NSDictionary*dic in array) {
        NSNumber*number=[dic objectForKey:@"server_ID"];
        BOOL isExist=NO;
        for (int x=0; x<myServers.count; x++) {
            NSDictionary*myDic=[myServers objectAtIndex:x];
            NSNumber*myID=[myDic objectForKey:@"server_ID"];
            if (myID.intValue==number.intValue) {
                isExist=YES;
            }
        }
        if (isExist!=YES) {
            [newArray addObject:dic];
        }
    }
    allServerList=newArray;
}
-(void)newServerRegiter:(id)sender
{
    [[WebServerMethods shared] setDelegate:self];
    [[WebServerMethods shared] showMyServer:@"all"];
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
