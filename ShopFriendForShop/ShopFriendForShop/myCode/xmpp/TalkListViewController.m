//
//  TalkListViewController.m
//  ShopFriendForShop
//
//  Created by Beautilut on 14-3-13.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import "TalkListViewController.h"
#import "SFNaviBar.h"
#import "SFRefreshFooterView.h"
#import "TalkCell.h"
#import "SFTalkViewController.h"
#define pageCount 15
@interface TalkListViewController ()
{
    UITableView*talkList;
    NSArray*messageArray;
    int count;
    
    SFRefreshFooterView * _footer;
}
@end

@implementation TalkListViewController

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
    SFNaviBar*navi=[[SFNaviBar alloc] init];
    [navi openNaviShadow:YES];
    [self.view addSubview:navi];
    
    UIButton *backbutton=[[UIButton alloc] initWithFrame:CGRectMake(5, 24, 40, 40)];
    [backbutton addTarget:self action:@selector(popViewController:) forControlEvents:UIControlEventTouchDown];
    [backbutton setTitle:@"返回" forState:UIControlStateNormal];
    [backbutton setTitleColor:[UIColor colorWithRed:25.0/255.0 green:173.0/255.0 blue:220.0/255.0 alpha:1.0f] forState:UIControlStateNormal];
    [navi addSubview:backbutton];
    talkList=[[UITableView alloc] initWithFrame:CGRectMake(0, navi.frame.origin.y+navi.frame.size.height, screenBounds.size.width, screenBounds.size.height-navi.frame.size.height)];
    [talkList setBackgroundColor:[UIColor clearColor]];
    [talkList setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [talkList setDelegate:self];
    [talkList setDataSource:self];
    [self.view addSubview:talkList];
    [self.view bringSubviewToFront:navi];
    
    [self refresh];
    //[self addFooter];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(newMsgCome:) name:kXMPPNewMsgNotifaction object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showTalkView:) name:@"showTalkView" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh) name:@"deleteMessage" object:nil];
    // Do any additional setup after loading the view.
}
-(void)popViewController:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CustomBadgeClear" object:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)newMsgCome:(NSNotification *)notifacation
{
    //[self.tabBarController.tabBarItem setBadgeValue:@"1"];
    [self refresh];
}
-(void)refresh
{
    messageArray=[MessageModel fetchRecentChatByPage:count+1];
    [talkList reloadData];
}
- (void)addFooter
{
    __unsafe_unretained TalkListViewController *vc = self;
    SFRefreshFooterView *footer = [SFRefreshFooterView footer];
    footer.scrollView = talkList;
    footer.beginRefreshingBlock = ^(SFRefreshBaseView *refreshView) {
        // 模拟延迟加载数据，因此2秒后才调用）
        int listCount=count*pageCount;
        if (messageArray.count==listCount) {
            count=count+1;
        }
        // 这里的refreshView其实就是footer
        [vc performSelector:@selector(doneWithView:) withObject:refreshView afterDelay:2.0];
        
        //NSLog(@"%@----开始进入刷新状态", refreshView.class);
    };
    _footer = footer;
}
- (void)doneWithView:(SFRefreshBaseView *)refreshView
{
    // 刷新表格
    [talkList reloadData];
    // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    [refreshView endRefreshing];
}
#pragma mark -table method-
#pragma mark - tableView Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return messageArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //static NSString *CellIdentifier = @"Cell";
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    //UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"ShopCell"];
    // Configure the cell...
    TalkCell*cell=[tableView dequeueReusableCellWithIdentifier:@"TalkCell"];
    if (cell==nil) {
        NSArray*nib=[[NSBundle mainBundle] loadNibNamed:@"TalkCell" owner:self options:nil];
        for (id oneObject in nib) {
            if ([oneObject isKindOfClass:[TalkCell class]]) {
                cell=(TalkCell*)oneObject;
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
                MessageUserUnionObject*aUnion=[messageArray objectAtIndex:indexPath.row];
                UserObject*aUser=aUnion.user;
                MessageModel*aMessage=aUnion.message;
                NSURL*url=[NSURL URLWithString:USER_IMAGE_URL(aUser.userId)];
                [cell.talkView setImageWithURL:url];
                cell.talkView.layer.borderWidth=2;
                cell.talkView.layer.borderColor=[UIColor whiteColor].CGColor;
                cell.talkView.layer.cornerRadius=CGRectGetHeight(cell.talkView.bounds)/2;
                cell.talkView.clipsToBounds=YES;
                [cell.name setText:aUser.userNickname];
                NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
                [formatter setAMSymbol:@"上午"];
                [formatter setPMSymbol:@"下午"];
                [formatter setDateFormat:@"a HH:mm"];
                [cell.data setText:[formatter stringFromDate:aMessage.messageDate]];
                [cell.content setText:aMessage.messageContent];
            }
        }
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageUserUnionObject*aUnion=[messageArray objectAtIndex:indexPath.row];
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SFTalkViewController*talkView=[mainStoryboard instantiateViewControllerWithIdentifier:@"SFTalkView"];
    [talkView setChatPerson:aUnion.user];
    //[talkView setChatPerson:user];
    [self.navigationController pushViewController:talkView animated:YES];
    //    TalkViewController*talkView=[mainStoryboard instantiateViewControllerWithIdentifier:@"MyTalkView"];
    //    [self.navigationController pushViewController:talkView animated:YES];
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
