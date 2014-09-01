//
//  ServerDetailViewController.m
//  ShopFriendForShop
//
//  Created by Beautilut on 14-8-20.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import "ServerDetailViewController.h"
#import "TextFieldCell.h"
#import "MenuInfoCell.h"
@interface ServerDetailViewController ()
{
    UIButton*buttonRight;
    
    
    //table
    UITableView*serverDetailTable;
    UITextField*rangeField;
    UITextView*infoView;
    BOOL myServer;
    BOOL turn;
    BOOL registering;
}
@end

@implementation ServerDetailViewController
@synthesize detailInfo;
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
    
    
    SFNaviBar*navi=[[SFNaviBar alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [navi openNaviShadow:YES];
    [self.view addSubview:navi];
    
    UIButton*leftButton=[[UIButton alloc] initWithFrame:CGRectMake(5, 24, 40, 40)];
    [leftButton addTarget:self action:@selector(backNavi:) forControlEvents:UIControlEventTouchDown];
    [leftButton.titleLabel setTextAlignment:NSTextAlignmentLeft];
    [leftButton setTitle:@"返回" forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor colorWithRed:25.0/255.0 green:173.0/255.0 blue:220.0/255.0 alpha:1.0f] forState:UIControlStateNormal];
    [navi addSubview:leftButton];
    
    buttonRight=[[UIButton alloc] initWithFrame:CGRectMake(navi.frame.size.width-45,24,40,40)];
    [buttonRight addTarget:self action:@selector(serverSetting:) forControlEvents:UIControlEventTouchDown];
    [buttonRight setTitle:@"开启" forState:UIControlStateNormal];
    [buttonRight setTitleColor:[UIColor colorWithRed:25.0/255.0 green:173.0/255.0 blue:220.0/255.0 alpha:1.0f] forState:UIControlStateNormal];
    [buttonRight setHidden:YES];
    [navi addSubview:buttonRight];
    
    if (![[detailInfo objectForKey:@"shop_ID"] isEqualToString:[InfoManager sharedInfo].myShop.shopID]) {
        myServer=NO;
    }else
    {
        myServer=YES;
    }
    [self setTable:self.view];
    
//    UILabel*label=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
//    [label setCenter:CGPointMake(navi.frame.size.width/2, navi.frame.size.height-23)];
//    [label setTextAlignment:NSTextAlignmentCenter];
//    //[label setText:[detailInfo objectForKey:@"server_name"]];
//    [label setTextColor:[UIColor colorWithRed:25.0/255.0 green:173.0/255.0 blue:220.0/255.0 alpha:1.0f]];
//    [label setFont:[UIFont systemFontOfSize:19.0f]];
//    [navi addSubview:label];
//    backScroll=[[UIScrollView alloc] initWithFrame:CGRectMake(0, navi.frame.size.height, screenBounds.size.width, screenBounds.size.height-navi.frame.size.height)];
//    [backScroll setBackgroundColor:[UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1.0]];
//    [self.view addSubview:backScroll];
//    UIControl*serverView=[[UIControl alloc] initWithFrame:CGRectMake(0, 0, backScroll.frame.size.width, 200)];
//    [serverView addTarget:self action:@selector(done:) forControlEvents:UIControlEventTouchDown];
//    [backScroll addSubview:serverView];
//    
//    [self setServerView:serverView];
//    if (![[detailInfo objectForKey:@"shop_ID"] isEqualToString:[InfoManager sharedInfo].myShop.shopID]) {
//        registerButton=[[UIButton alloc] initWithFrame:CGRectMake(0, 0,screenBounds.size.width-100, 40)];
//        [registerButton setCenter:CGPointMake(screenBounds.size.width/2, serverView.frame.size.height+serverView.frame.origin.y+50)];
//        [registerButton setTitle:@"注册此项服务" forState:UIControlStateNormal];
//        registerButton.layer.borderColor=[UIColor colorWithRed:25.0/255.0 green:173.0/255.0 blue:220.0/255.0 alpha:1.0f].CGColor;
//        registerButton.layer.borderWidth=2.0f;
//        [registerButton setTitleColor:[UIColor colorWithRed:25.0/255.0 green:173.0/255.0 blue:220.0/255.0 alpha:1.0f] forState:UIControlStateNormal];
//        [registerButton addTarget:self action:@selector(registerServer:) forControlEvents:UIControlEventTouchDown];
//        [backScroll addSubview:registerButton];
//    }else
//    {
//        [self setMyServer:backScroll];
//    }
//    
    turn=NO;
    [self.view bringSubviewToFront:navi];
    // Do any additional setup after loading the view.
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
-(void)setTable:(UIView*)view
{
    CGRect screenBounds=[[UIScreen mainScreen] bounds];
    serverDetailTable=[[UITableView alloc] initWithFrame:CGRectMake(0, naviHight, screenBounds.size.width, screenBounds.size.height-naviHight) style:UITableViewStyleGrouped];
    [serverDetailTable setDataSource:self];
    [serverDetailTable setDelegate:self];
    [view addSubview:serverDetailTable];
}
#pragma mark tableView Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 4;
    }
    if (section==1) {
        if (myServer) {
            return 3;
        }else
        {
            return 1;
        }
    }
    return 0;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0&&indexPath.row==0) {
        UITableViewCell*cell;
        if (!cell) {
            cell=[[UITableViewCell alloc] init];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        UILabel*nameLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 90,70)];
        [nameLabel setText:@"服务标示"];
        [nameLabel setFont:[UIFont systemFontOfSize:15.0f]];
        [nameLabel setTextAlignment:NSTextAlignmentCenter];
        [cell addSubview:nameLabel];
        UIImageView*serverimage=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
        [serverimage setCenter:CGPointMake(cell.frame.size.width-35, 35)];
        serverimage.layer.masksToBounds = YES;
        serverimage.layer.cornerRadius = 30.0;
        serverimage.layer.borderWidth = 1.0;
        serverimage.layer.borderColor = [[UIColor greenColor] CGColor];
        [cell addSubview:serverimage];
        return cell;
    }
    if (indexPath.section==0&&indexPath.row==1) {
        UITableViewCell*cell;
        if (!cell) {
            cell=[[UITableViewCell alloc] init];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        UILabel*nameLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 90,44)];
        [nameLabel setText:@"服务名称"];
        [nameLabel setFont:[UIFont systemFontOfSize:15.0f]];
        [nameLabel setTextAlignment:NSTextAlignmentCenter];
        [cell addSubview:nameLabel];
        UILabel*infoLabel=[[UILabel alloc] initWithFrame:CGRectMake(90, 0, cell.frame.size.width-105, 44)];
        [infoLabel setTextAlignment:NSTextAlignmentRight];
        [infoLabel setFont:[UIFont systemFontOfSize:15.0f]];
        [infoLabel setText:[detailInfo objectForKey:@"server_name"]];
        [cell addSubview:infoLabel];
        return cell;
    }
    if (indexPath.section==0&&indexPath.row==2) {
        UITableViewCell*cell;
        if (!cell) {
            cell=[[UITableViewCell alloc] init];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        UILabel*nameLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 90,44)];
        [nameLabel setText:@"服务类型"];
        [nameLabel setFont:[UIFont systemFontOfSize:15.0f]];
        [nameLabel setTextAlignment:NSTextAlignmentCenter];
        [cell addSubview:nameLabel];
        UILabel*infoLabel=[[UILabel alloc] initWithFrame:CGRectMake(90, 0, cell.frame.size.width-105, 44)];
        [infoLabel setTextAlignment:NSTextAlignmentRight];
        [infoLabel setFont:[UIFont systemFontOfSize:15.0f]];
        NSString*string;
        NSNumber*serverKind=[detailInfo objectForKey:@"server_kind"];
        switch ([serverKind integerValue]) {
            case 0:
                string=@"公开服务";
                break;
            case 1:
                string=@"私有服务";
            default:
                break;
        }
        [infoLabel setText:string];
        [cell addSubview:infoLabel];
        return cell;
    }
    if (indexPath.section==0&&indexPath.row==3) {
        UITableViewCell*cell;
        if (!cell) {
            cell=[[UITableViewCell alloc] init];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        UILabel*nameLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 90,44)];
        [nameLabel setText:@"单次费用"];
        [nameLabel setFont:[UIFont systemFontOfSize:15.0f]];
        [nameLabel setTextAlignment:NSTextAlignmentCenter];
        [cell addSubview:nameLabel];
        UILabel*infoLabel=[[UILabel alloc] initWithFrame:CGRectMake(90, 0, cell.frame.size.width-105, 44)];
        [infoLabel setTextAlignment:NSTextAlignmentRight];
        [infoLabel setFont:[UIFont systemFontOfSize:15.0f]];
        [infoLabel setText:[detailInfo objectForKey:@"server_spend"]];
        [cell addSubview:infoLabel];
        return cell;
    }
    if (indexPath.section==1&&indexPath.row==0) {
        if (myServer) {
            UITableViewCell*cell;
            if (!cell) {
                cell=[[UITableViewCell alloc] init];
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            }
            UILabel*nameLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 90,44)];
            [nameLabel setText:@"单次费用"];
            [nameLabel setFont:[UIFont systemFontOfSize:15.0f]];
            [nameLabel setTextAlignment:NSTextAlignmentCenter];
            [cell addSubview:nameLabel];
            UILabel*infoLabel=[[UILabel alloc] initWithFrame:CGRectMake(90, 0, cell.frame.size.width-105, 44)];
            [infoLabel setTextAlignment:NSTextAlignmentRight];
            [infoLabel setFont:[UIFont systemFontOfSize:15.0f]];
            NSNumber*status=[detailInfo objectForKey:@"server_shop_status"];
            NSString*string;
            switch ([status integerValue]) {
                case 0:
                    string=@"服务停止中";
                    [infoLabel setTextColor:[UIColor redColor]];
                    break;
                case 1:
                    string=@"服务中";
                    [infoLabel setTextColor:[UIColor greenColor]];
                    [buttonRight setHidden:NO];
                    break;
                case 2:
                    [infoLabel setTextColor:[UIColor orangeColor]];
                    string=@"服务审核中";
                    break;
                default:
                    break;
            }

            [infoLabel setText:string];
            [cell addSubview:infoLabel];
            return cell;
        }else
        {
            UITableViewCell*cell;
            if (!cell) {
                cell=[[UITableViewCell alloc] init];
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            }
            UILabel*registerLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
            [registerLabel setTextAlignment:NSTextAlignmentCenter];
            [registerLabel setFont:[UIFont systemFontOfSize:18.0f]];
            [registerLabel setTextColor:[UIColor orangeColor]];
            [registerLabel setText:@"注册此项服务"];
            [cell addSubview:registerLabel];
            return cell;
        }
    }
    if (indexPath.section==1&&indexPath.row==1) {
        UITableViewCell*cell;
        if (!cell) {
            cell=[[UITableViewCell alloc] init];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        UILabel*nameLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 90,44)];
        [nameLabel setText:@"服务半径"];
        [nameLabel setFont:[UIFont systemFontOfSize:15.0f]];
        [nameLabel setTextAlignment:NSTextAlignmentCenter];
        [cell addSubview:nameLabel];
        rangeField=[[UITextField alloc] initWithFrame:CGRectMake(90, 0, cell.frame.size.width-105, 44)];
        [rangeField setDelegate:self];
        if ([detailInfo objectForKey:@"server_range"]!=[NSNull null]) {
            [rangeField setText:[detailInfo objectForKey:@"server_range"]];
        }
        [rangeField setTextAlignment:NSTextAlignmentRight];
        [rangeField setEnabled:NO];
        [rangeField setKeyboardType:UIKeyboardTypeNumberPad];
        [rangeField setDelegate:self];
        [cell addSubview:rangeField];
        return cell;

        return cell;
    }
    if (indexPath.section==1&&indexPath.row==2) {
        MenuInfoCell*cell;
        NSArray*nib=[[NSBundle mainBundle] loadNibNamed:@"MenuInfoCell" owner:self options:nil];
        for (id oneObject in nib) {
            if ([oneObject isKindOfClass:[MenuInfoCell class]]) {
                cell=(MenuInfoCell*)oneObject;
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
            }
        }
        [cell.namelabel setText:@"服务信息"];
        [cell.namelabel setFont:[UIFont systemFontOfSize:15.0f]];
        [cell.menuInfo setDelegate:self];
        infoView=cell.menuInfo;
        if ([detailInfo objectForKey:@"server_shop_info"]!=[NSNull null]) {
            [infoView setText:[detailInfo objectForKey:@"server_shop_info"]];
        }
        [cell.menuInfo setReturnKeyType:UIReturnKeyNext];
        [infoView setDelegate:self];
        [infoView setEditable:NO];
        return cell;
    }
    UITableViewCell*cell;
    if (!cell) {
        cell=[[UITableViewCell alloc] init];
         [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0&&indexPath.row==0) {
        return 70.0f;
    }
    if (indexPath.section==1&&indexPath.row==2) {
        return 110.0f;
    }
        return 44.0f;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1&&indexPath.row==0) {
        if (!myServer) {
            if(!registering){
                [self registerServer:nil];
            }
        }
    }
}
#pragma mark -
-(void)getServerDetailInfo:(NSDictionary *)dic
{
    detailInfo=dic;
}
-(void)setServerView:(UIView*)serverView
{
    UILabel*namelabel=[[UILabel alloc] initWithFrame:CGRectMake(10, 20, serverView.frame.size.width-20, 40)];
    [namelabel setTextColor:[UIColor colorWithRed:25.0/255.0 green:173.0/255.0 blue:220.0/255.0 alpha:1.0f]];
    [namelabel setFont:[UIFont systemFontOfSize:20.0f]];
    NSString*string=[NSString stringWithFormat:@"服务名称：%@",[detailInfo objectForKey:@"server_name"]];
    [namelabel setText:string];
    [serverView addSubview:namelabel];
    
    UILabel*kindLabel=[[UILabel alloc] initWithFrame:CGRectMake(10, 70, serverView.frame.size.width-20, 40)];
    [kindLabel setTextColor:[UIColor colorWithRed:25.0/255.0 green:173.0/255.0 blue:220.0/255.0 alpha:1.0f]];
    [kindLabel setFont:[UIFont systemFontOfSize:20.0f]];
    NSNumber*serverKind=[detailInfo objectForKey:@"server_kind"];
    switch ([serverKind integerValue]) {
        case 0:
            string=@"服务类型：公开服务";
            break;
        case 1:
            string=@"服务类型：私有服务";
        default:
            break;
    }
    [kindLabel setText:string];
    [serverView addSubview:kindLabel];
    
    UILabel*priceLabel=[[UILabel alloc] initWithFrame:CGRectMake(10, 120, serverView.frame.size.width-20, 40)];
    [priceLabel setTextColor:[UIColor colorWithRed:25.0/255.0 green:173.0/255.0 blue:220.0/255.0 alpha:1.0f]];
    [priceLabel setFont:[UIFont systemFontOfSize:20.0f]];
    string=[NSString stringWithFormat:@"单次服务费用：%@",[detailInfo objectForKey:@"server_spend"]];
    [priceLabel setText:string];
    [serverView addSubview:priceLabel];
}
//-(void)setMyServer:(UIScrollView*)scroll
//{
//    [scroll setContentSize:CGSizeMake(scroll.frame.size.width, 800)];
//    
//    myServerView =[[UIControl alloc] initWithFrame:CGRectMake(0,200, scroll.frame.size.width, 500)];
//    [myServerView  addTarget:self action:@selector(done:) forControlEvents:UIControlEventTouchDown];
//    [scroll addSubview:myServerView];
//    
//    UIView*line=[[UIView alloc] initWithFrame:CGRectMake(0, 0, scroll.frame.size.width, 1)];
//    [line setBackgroundColor:[UIColor colorWithRed:25.0/255.0 green:173.0/255.0 blue:220.0/255.0 alpha:1.0f]];
//    [myServerView addSubview:line];
//    
//    UILabel*statusLabel=[[UILabel alloc] initWithFrame:CGRectMake(10, 10, scroll.frame.size.width-20, 40)];
//    NSNumber*status=[detailInfo objectForKey:@"server_shop_status"];
//    NSString*string;
//    switch ([status integerValue]) {
//        case 0:
//            string=@"服务停止中";
//            break;
//        case 1:
//            string=@"服务中";
//            [buttonRight setHidden:NO];
//            break;
//        case 2:
//            string=@"服务审核中";
//            break;
//        default:
//            break;
//    }
//    [statusLabel setTextColor:[UIColor colorWithRed:25.0/255.0 green:173.0/255.0 blue:220.0/255.0 alpha:1.0f]];
//    [statusLabel setFont:[UIFont systemFontOfSize:20.0f]];
//    NSString*statusinfo=[NSString stringWithFormat:@"服务状态：%@",string];
//    [statusLabel setText:statusinfo];
//    [myServerView addSubview:statusLabel];
//    
//    UILabel*rangeLabel=[[UILabel alloc] initWithFrame:CGRectMake(10,60, scroll.frame.size.width-20, 40)];
//    [rangeLabel setText:@"服务半径(公里)："];
//    [rangeLabel setFont:[UIFont systemFontOfSize:20.0f]];
//    [rangeLabel setTextColor:[UIColor colorWithRed:25.0/255.0 green:173.0/255.0 blue:220.0/255.0 alpha:1.0f]];
//    [myServerView addSubview:rangeLabel];
//    
//    UIView*rangeView=[[UIView alloc] initWithFrame:CGRectMake(10, 105, rangeLabel.frame.size.width, 40)];
//    rangeView.layer.borderWidth=1.0f;
//    rangeView.layer.borderColor=[UIColor colorWithRed:25.0/255.0 green:173.0/255.0 blue:220.0/255.0 alpha:1.0f].CGColor;
//    [myServerView addSubview:rangeView];
//    
//    rangeField=[[UITextField alloc] initWithFrame:CGRectMake(5,0,rangeLabel.frame.size.width, 40)];
//    if ([detailInfo objectForKey:@"server_range"]!=[NSNull null]) {
//         [rangeField setText:[detailInfo objectForKey:@"server_range"]];
//    }
//    [rangeField setEnabled:NO];
//    [rangeField setKeyboardType:UIKeyboardTypeNumberPad];
//    [rangeField setDelegate:self];
//    [rangeView addSubview:rangeField];
//    
//    UILabel*infoLabel=[[UILabel alloc] initWithFrame:CGRectMake(10, 160, scroll.frame.size.width-20, 40)];
//    [infoLabel setText:@"服务信息："];
//    [infoLabel setTextColor:[UIColor colorWithRed:25.0/255.0 green:173.0/255.0 blue:220.0/255.0 alpha:1.0f]];
//    [infoLabel setFont:[UIFont systemFontOfSize:20.0f]];
//    [myServerView addSubview:infoLabel];
//    
//    infoView=[[UITextView alloc] initWithFrame:CGRectMake(10, 200, scroll.frame.size.width-20,250)];
//    [infoView setTextColor:[UIColor colorWithRed:25.0/255.0 green:173.0/255.0 blue:220.0/255.0 alpha:1.0f]];
//    [infoView setFont:[UIFont systemFontOfSize:15.0f]];
//    if ([detailInfo objectForKey:@"server_shop_info"]!=[NSNull null]) {
//        [infoView setText:[detailInfo objectForKey:@"server_shop_info"]];
//    }
//    [infoView setDelegate:self];
//    infoView.layer.borderColor=[UIColor colorWithRed:25.0/255.0 green:173.0/255.0 blue:220.0/255.0 alpha:1.0f].CGColor;
//    infoView.layer.borderWidth=1.0f;
//    [infoView setEditable:NO];
//    [myServerView addSubview:infoView];
//}

#pragma mark textField
- (void)moveView:(UITextView *)textVew leaveView:(BOOL)leave
{
    if (leave==YES) {
        const float movementDuration = 0.2f;
        [UIView beginAnimations: @"textFieldAnim" context: nil];
        [UIView setAnimationBeginsFromCurrentState: YES];
        [UIView setAnimationDuration: movementDuration];
        //tableView.frame = CGRectOffset(tableView.frame, 0, moveHeight);
        //[backScroll setContentOffset:CGPointMake(0, 0)];
        [serverDetailTable setContentOffset:CGPointMake(0, 0)];
        [UIView commitAnimations];
    }else
    {
            const float movementDuration = 0.2f;
            [UIView beginAnimations: @"textFieldAnim" context: nil];
            [UIView setAnimationBeginsFromCurrentState: YES];
            [UIView setAnimationDuration: movementDuration];
            //tableView.frame = CGRectOffset(tableView.frame, 0,-moveHeight);
            //[backScroll setContentOffset:CGPointMake(0, 400)];
         [serverDetailTable setContentOffset:CGPointMake(0,250)];
            [UIView commitAnimations];
    }
}
-(void)moveField:(UITextField*)textField leaveView:(BOOL)leave
{
    if (leave==YES) {
        const float movementDuration = 0.2f;
        [UIView beginAnimations: @"textFieldAnim" context: nil];
        [UIView setAnimationBeginsFromCurrentState: YES];
        [UIView setAnimationDuration: movementDuration];
        //tableView.frame = CGRectOffset(tableView.frame, 0, moveHeight);
        //[backScroll setContentOffset:CGPointMake(0,0)];
         [serverDetailTable setContentOffset:CGPointMake(0,0)];
        [UIView commitAnimations];
    }else
    {
            const float movementDuration = 0.2f;
            [UIView beginAnimations: @"textFieldAnim" context: nil];
            [UIView setAnimationBeginsFromCurrentState: YES];
            [UIView setAnimationDuration: movementDuration];
            //tableView.frame = CGRectOffset(tableView.frame, 0,-moveHeight);
           // [backScroll setContentOffset:CGPointMake(0,300)];
         [serverDetailTable setContentOffset:CGPointMake(0,250)];
            [UIView commitAnimations];
    }
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self moveField:textField leaveView:NO];
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [self moveField:textField leaveView:YES];
}
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    [self moveView:textView leaveView:NO];
}
-(void)textViewDidEndEditing:(UITextView *)textView
{
    [self moveView:textView leaveView:YES];
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if(scrollView!=infoView)
    {
        [self done:nil];
    }
}
-(void)done:(id)sender
{
    [infoView resignFirstResponder];
    [rangeField resignFirstResponder];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [infoView becomeFirstResponder];
    return YES;
}
-(void)serverSetting:(id)sender
{
    if (turn==NO) {
        [infoView setEditable:YES];
        [rangeField setEnabled:YES];
        turn=YES;
        [buttonRight setTitle:@"锁定" forState:UIControlStateNormal];
    }else
    {
        [self equal];
        [infoView setEditable:NO];
        [rangeField setEnabled:NO];
        [buttonRight setTitle:@"开启" forState:UIControlStateNormal];
        turn=NO;
    }
}
-(void)equal
{
    if (([detailInfo objectForKey:@"server_range"])||(([detailInfo objectForKey:@"server_range"]!=nil)&&![[detailInfo objectForKey:@"server_range"] isEqualToString:rangeField.text])) {
        [self webChange:rangeField.text withInfo:infoView.text];
        return;
    }
    if (([detailInfo objectForKey:@"server_shop_info"]!=nil)&&![[detailInfo objectForKey:@"server_shop_info"] isEqualToString:infoView.text]) {
        [self webChange:rangeField.text withInfo:infoView.text];
        return;
    }
}
-(void)webChange:(NSString*)range withInfo:(NSString*)info{
    if ([range floatValue]>=100.0f) {
        [rangeField setText:[detailInfo objectForKey:@"server_range"]];
        UIAlertView*alter=[[UIAlertView alloc] initWithTitle:nil message:@"服务距离多大" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
        return;
    }else
    {
        [buttonRight setEnabled:NO];
        [[WebServerMethods shared] setDelegate:self];
        [[WebServerMethods shared] changeServerRange:range withInfo:info with:(NSDictionary*)detailInfo];
        [ProgressHUD show:@"正在修改服务"];
    }
}
-(void)registerServer:(id)sender
{
     registering=YES;
    [[WebServerMethods shared] setDelegate:self];
    [[WebServerMethods shared] registerServer:detailInfo];
    [ProgressHUD show:@"正在注册服务"];
}
#pragma mark webServerDelegate
-(void)registerServerAccept
{
    //[self setMyServer:backScroll];
    myServer=YES;
    [serverDetailTable reloadData];
    registering=NO;
    [ProgressHUD dismiss];
}
-(void)registerServerFail
{
    UIAlertView*alter=[[UIAlertView alloc] initWithTitle:nil message:@"注册服务失败，请重新尝试" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alter show];
    registering=NO;
    [ProgressHUD dismiss];
}
-(void)changeServerSuccess
{
    [buttonRight setEnabled:YES];
    [ProgressHUD dismiss];
}
-(void)changeServerFail
{
    UIAlertView*alter=[[UIAlertView alloc] initWithTitle:nil message:@"修改服务信息失败，请重新尝试" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alter show];
    [buttonRight setEnabled:YES];
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
