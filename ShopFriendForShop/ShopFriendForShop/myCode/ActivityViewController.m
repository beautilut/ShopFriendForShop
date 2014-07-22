//
//  ActivityViewController.m
//  ShopFriendForShop
//
//  Created by Beautilut on 14-6-5.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import "ActivityViewController.h"
#import "SFNaviBar.h"
@interface ActivityViewController ()
{
    UIScrollView*backScroller;
    UITextView*activityTextView;
}
@end

@implementation ActivityViewController

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
    [label setText:@"活动"];
    [label setTextColor:[UIColor colorWithRed:25.0/255.0 green:173.0/255.0 blue:220.0/255.0 alpha:1.0f]];
    [label setFont:[UIFont systemFontOfSize:19.0f]];
    [navi addSubview:label];
    
    UIButton *button=[[UIButton alloc] initWithFrame:CGRectMake(5, 24, 40, 40)];
    [button addTarget:self action:@selector(popViewController:) forControlEvents:UIControlEventTouchDown];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:25.0/255.0 green:173.0/255.0 blue:220.0/255.0 alpha:1.0f] forState:UIControlStateNormal];
    [navi addSubview:button];
    
    UIButton*buttonRight=[[UIButton alloc] initWithFrame:CGRectMake(navi.frame.size.width-45,24,40,40)];
    [buttonRight addTarget:self action:@selector(updateShopActivity:) forControlEvents:UIControlEventTouchDown];
    [buttonRight setTitle:@"发布" forState:UIControlStateNormal];
    [buttonRight setTitleColor:[UIColor colorWithRed:25.0/255.0 green:173.0/255.0 blue:220.0/255.0 alpha:1.0f] forState:UIControlStateNormal];
    [navi addSubview:buttonRight];
    
    backScroller = [[UIScrollView alloc] initWithFrame:CGRectMake(0, navi.frame.size.height, screenBounds.size.width, screenBounds.size.height-navi.frame.size.height)];
    [backScroller setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:backScroller];
    
    UIControl*controlView=[[UIControl alloc] initWithFrame:CGRectMake(0, 0, backScroller.frame.size.width, backScroller.frame.size.height+100)];
    [controlView addTarget:self action:@selector(done:) forControlEvents:UIControlEventTouchDown];
    [backScroller addSubview:controlView];
    
    activityTextView=[[UITextView alloc] initWithFrame:CGRectMake(0, 0, 200, 230)];
    [activityTextView setTextAlignment:NSTextAlignmentCenter];
    [activityTextView setFont:[UIFont systemFontOfSize:20.0f]];
    [activityTextView setCenter:CGPointMake(backScroller.frame.size.width/2,300/2)];
    activityTextView.layer.borderColor=[UIColor orangeColor].CGColor;
    [activityTextView setDelegate:self];
    activityTextView.layer.borderWidth=2;
    [activityTextView setEditable:NO];
    [backScroller addSubview:activityTextView];
    
    UILabel*infoLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
    [infoLabel setTextAlignment:NSTextAlignmentLeft];
    [infoLabel setNumberOfLines:20.0f];
    [infoLabel setCenter:CGPointMake(backScroller.frame.size.width/2, 100/2+300)];
    [infoLabel setText:@"* 与用户体验一致，支持9个中文一行，9行。"];
    [infoLabel setFont:[UIFont systemFontOfSize:12.0f]];
    [backScroller addSubview:infoLabel];
    
    [self.view bringSubviewToFront:navi];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    NSURL*url=[NSURL URLWithString:getShopActivity];
    ASIFormDataRequest*request=[ASIFormDataRequest requestWithURL:url];
    NSString*hostID=[[NSUserDefaults standardUserDefaults]objectForKey:kXMPPmyJID];
    [request setPostValue:hostID forKey:@"shopID"];
    [request setCompletionBlock:^{
        SBJsonParser*parser=[[SBJsonParser alloc] init];
        NSDictionary*dic=[parser objectWithString:request.responseString];
        if ([[dic objectForKey:@"back"] integerValue]==1) {
            NSArray*array=[dic objectForKey:@"data"];
            NSDictionary*dataDic=[array objectAtIndex:0];
            [activityTextView setText:[dataDic objectForKey:@"shop_activity_info"]];
            [activityTextView setEditable:YES];
        }
    }];
    [request setFailedBlock:^{
        
    }];
    [request startAsynchronous];
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
-(void)updateShopActivity:(id)sender
{
    NSURL*url=[NSURL URLWithString:changeShopActivity];
    ASIFormDataRequest*request=[ASIFormDataRequest requestWithURL:url];
    NSString*hostID=[[NSUserDefaults standardUserDefaults]objectForKey:kXMPPmyJID];
    [request setPostValue:hostID forKey:@"shopID"];
    [request setPostValue:activityTextView.text forKey:@"activityInfo"];
    [request setCompletionBlock:^{
        SBJsonParser*parser=[[SBJsonParser alloc] init];
        NSDictionary*dic=[parser objectWithString:request.responseString];
        if ([[dic objectForKey:@"back"] integerValue]==1) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
    [request setFailedBlock:^{
        
    }];
    [request startAsynchronous];
}
-(void)done:(id)sender
{
    [activityTextView resignFirstResponder];
}
#pragma mark textView delegate
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    [backScroller setContentSize:CGSizeMake(backScroller.frame.size.width, backScroller.frame.size.height+100)];
}
-(void)textViewDidEndEditing:(UITextView *)textView
{
    [backScroller setContentSize:CGSizeMake(backScroller.frame.size.width, backScroller.frame.size.height-100)];
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
