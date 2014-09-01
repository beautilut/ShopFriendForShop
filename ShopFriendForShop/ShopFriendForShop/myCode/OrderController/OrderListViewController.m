//
//  OrderListViewController.m
//  ShopFriendForShop
//
//  Created by Beautilut on 14-8-6.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import "OrderListViewController.h"
#import "OrderDetailViewController.h"
@interface OrderListViewController ()
{
    UITableView*OrderListTable;
    NSArray*OrderList;
    NSDictionary*postOrder;
    UIView*touchView;
}
@end

@implementation OrderListViewController
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
    [backbutton addTarget:self action:@selector(backNavi:) forControlEvents:UIControlEventTouchDown];
    [backbutton setTitle:@"返回" forState:UIControlStateNormal];
    [backbutton setTitleColor:[UIColor colorWithRed:25.0/255.0 green:173.0/255.0 blue:220.0/255.0 alpha:1.0f] forState:UIControlStateNormal];
    [navi addSubview:backbutton];
    
    int naviHeight=self.navigationController.navigationBar.frame.size.height+20;
    OrderListTable=[[UITableView alloc] initWithFrame:CGRectMake(0, naviHeight, self.view.frame.size.width, self.view.frame.size.height-naviHeight) style:UITableViewStyleGrouped];
    [OrderListTable setDelegate:self];
    [OrderListTable setDataSource:self];
    //OrderList=[OrderObject showOrders:[InfoManager sharedInfo].myShop.shopID];
    [[WebOrderMethods sharedOrder] setDelegate:self];
    [[WebOrderMethods sharedOrder] getAllOrders];
    
    [self.view addSubview:OrderListTable];
    
    touchView=[[UIView alloc] initWithFrame:OrderListTable.frame];
    [touchView setBackgroundColor:[UIColor clearColor]];
    [touchView setHidden:YES];
    [self.view addSubview:touchView];
    //notifaction
    
    [self.view bringSubviewToFront:navi];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"OrderBadgeClear" object:nil];
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
#pragma mark order methods
-(void)getAllOrdersSuccess:(NSDictionary *)dic
{
    OrderList=[dic objectForKey:@"order"];
    [OrderListTable reloadData];
    [touchView setHidden:YES];
    [ProgressHUD dismiss];
}
-(void)getAllOrdersFail
{
    [touchView setHidden:YES];
    [ProgressHUD dismiss];
}
#pragma mark -table-
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [OrderList count];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString*cellIdentifier=@"";
    SWTableViewCell*cell;//=(SWTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell==nil) {
        NSMutableArray*rightUtilityButton=[NSMutableArray new];
        NSMutableArray*leftUtilityButtons=[NSMutableArray new];
        //OrderObject*order=[OrderList objectAtIndex:indexPath.section];
        NSDictionary*dic=[OrderList objectAtIndex:indexPath.section];
        if ([[dic objectForKey:sfOrderStatus] integerValue]==1) {
            [rightUtilityButton addUtilityButtonWithColor:[UIColor orangeColor] title:@"确认"];
        }else if([[dic objectForKey:sfOrderStatus] integerValue]==2){
            [rightUtilityButton addUtilityButtonWithColor:[UIColor greenColor] title:@"完成"];
        }
        if ([[dic objectForKey:sfOrderStatus] integerValue]==1) {
            [leftUtilityButtons addUtilityButtonWithColor:[UIColor redColor] title:@"拒接"];
        }
        //[rightUtilityButton addUtilityButtonWithColor:[UIColor redColor] title:@"取消"];
        cell=[[SWTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier containingTableView:OrderListTable leftUtilityButtons:leftUtilityButtons rightUtilityButtons:rightUtilityButton];
        
        cell.delegate=self;
        [self initCell:cell path:dic];
        
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    tableView.rowHeight=105.0f;
    return 105.0f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15.0f;
}
-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1f;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    postOrder=[OrderList objectAtIndex:indexPath.section];
    [self performSegueWithIdentifier:@"OrderDetail" sender:nil];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"OrderDetail"]) {
        [[segue destinationViewController] getOrderDetail:postOrder];
    }
}
-(void)initCell:(SWTableViewCell*)cell path:(NSDictionary*)order
{
    UILabel*label_ID=[[UILabel alloc] initWithFrame:CGRectMake(10, 5, 150, 15)];
    [label_ID setFont:[UIFont systemFontOfSize:15.0f]];
    NSString*string=[NSString stringWithFormat:@"订单号：%@",[order objectForKey:sfOrderID]];
    [label_ID setText:string];
    [cell.scrollViewContentView addSubview:label_ID];
    UILabel*label_server=[[UILabel alloc] initWithFrame:CGRectMake(10,25, 50, 15)];
    [label_server setFont:[UIFont systemFontOfSize:15.0f]];
    [label_server setText:[order objectForKey:sfServername]];
    [cell.scrollViewContentView addSubview:label_server];
    UILabel*label_location=[[UILabel alloc] initWithFrame:CGRectMake(10,45,cell.frame.size.width,50)];
    [label_location setFont:[UIFont systemFontOfSize:20.0f]];
    [label_location setText:[order objectForKey:sfUserLocation]];
    //[label_location setText:@"嘉定区塔城路789弄14号501室嘉定区塔城路789弄14号501室嘉定区塔城路789弄14号501室"];
    label_location.lineBreakMode = UILineBreakModeWordWrap;
    label_location.numberOfLines=2;
    [label_location sizeToFit];
    [cell.scrollViewContentView addSubview:label_location];
    UILabel*label_price=[[UILabel alloc] initWithFrame:CGRectMake(cell.frame.size.width-180,5,170, 30)];
    string=[NSString stringWithFormat:@"￥ %@",[order objectForKey:sfOrderTotalPrice]];
    [label_price setTextAlignment:NSTextAlignmentRight];
    [label_price setText:string];
    [label_price setTextColor:[UIColor redColor]];
    [label_price setFont:[UIFont systemFontOfSize:20.0f]];
    [cell.scrollViewContentView addSubview:label_price];
    
    UILabel*statusLabel=[[UILabel alloc] initWithFrame:CGRectMake(0,100, cell.frame.size.width, 5)];
    switch ([[order objectForKey:sfOrderStatus] integerValue]) {
        case 0:
            [statusLabel setBackgroundColor:[UIColor redColor]];
            break;
        case 1:
            [statusLabel setBackgroundColor:[UIColor orangeColor]];
            break;
        case 2:
            [statusLabel setBackgroundColor:[UIColor greenColor]];
            break;
        default:
            break;
    }
    [cell.scrollViewContentView addSubview:statusLabel];
}
#pragma mark swtablecell delegate
- (void)swippableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index
{
    if (index==0) {
        NSDictionary*dic=[OrderList objectAtIndex:[OrderListTable indexPathForCell:cell].section];
        OrderObject*order=[OrderObject orderFromDictionary:dic];
        switch ([order.orderStatus intValue]) {
            case 1:
                [order setOrderStatus:[NSNumber numberWithInt:2]];
                break;
            case 2:
                [order setOrderStatus:[NSNumber numberWithInt:3]];
                break;
            default:
                break;
        }
        [[WebOrderMethods sharedOrder] setDelegate:self];
        [[WebOrderMethods sharedOrder] webOrderUpdate:order];
        [touchView setHidden:NO];
        [cell hideUtilityButtonsAnimated:YES];
        [ProgressHUD show:@"正在修改订单状态"];
    }
}
-(void)swippableTableViewCell:(SWTableViewCell *)cell didTriggerLeftUtilityButtonWithIndex:(NSInteger)index
{
    if (index==0) {
        NSDictionary*dic=[OrderList objectAtIndex:[OrderListTable indexPathForCell:cell].section];
        OrderObject*order=[OrderObject orderFromDictionary:dic];
        [order setOrderStatus:[NSNumber numberWithInt:0]];
        [[WebOrderMethods sharedOrder] setDelegate:self];
        [[WebOrderMethods sharedOrder]   webOrderUpdate:order];
        [touchView setHidden:NO];
        [cell hideUtilityButtonsAnimated:YES];
        [ProgressHUD show:@"正在修改订单状态"];
    }
}
#pragma mark webOrderDelegate
-(void)webOrderUpdateSuccess
{
    //OrderList=[OrderObject showOrders:[InfoManager sharedInfo].myShop.shopID];
    [[WebOrderMethods sharedOrder] setDelegate:self];
    [[WebOrderMethods sharedOrder] getAllOrders];
}
-(void)webOrderUpdateFail
{
    [OrderListTable reloadData];
    [touchView setHidden:YES];
    [ProgressHUD dismiss];
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
