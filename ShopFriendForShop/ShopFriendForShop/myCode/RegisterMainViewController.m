//
//  RegisterMainViewController.m
//  ShopFriendForShop
//
//  Created by Beautilut on 14-1-23.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import "RegisterMainViewController.h"

#import "RegisterOtherViewController.h"
#import "TextFieldCell.h"
#import "categoryCell.h"
#import "SFNaviBar.h"
@interface RegisterMainViewController ()
{
    NSMutableArray*cellArray;
    UITableView*tableView;
    categoryCell*theCell;
    
    NSMutableDictionary*sendDic;
    //CGFloat moveHeight;
    NSString*phoneNumber;
    BMKSearch*search;
    int moveHeight;
}
@end

@implementation RegisterMainViewController
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
    search=[[BMKSearch alloc] init];
    [search setDelegate:self];
    sendDic=[[NSMutableDictionary alloc] init];
    SFNaviBar*navi=[[SFNaviBar alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [navi openNaviShadow:YES];
    [self.view addSubview:navi];
    
    UILabel*label=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    [label setText:@"基本信息"];
    label.font = [UIFont boldSystemFontOfSize:19.0f];
    label.textColor = [UIColor lightTextColor];
    label.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setTextColor:[UIColor colorWithRed:25.0/255.0 green:173.0/255.0 blue:220.0/255.0 alpha:1.0f]];
    [label setCenter:CGPointMake(navi.frame.size.width/2, navi.frame.size.height-23)];
    [navi addSubview:label];
    
    cellArray=[[NSMutableArray alloc] init];
    tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, navi.frame.size.height, screenRect.size.width,screenRect.size.height-navi.frame.size.height) style:UITableViewStyleGrouped];
    [tableView setDelegate:self];
    [tableView setDataSource:self];
    [tableView setScrollEnabled:NO];
    [self.view addSubview:tableView];
    [self.view setBackgroundColor:tableView.backgroundColor];
    
    UIButton *button=[[UIButton alloc] initWithFrame:CGRectMake(5, 24, 40, 40)];
    [button addTarget:self action:@selector(backNavi:) forControlEvents:UIControlEventTouchDown];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:25.0/255.0 green:173.0/255.0 blue:220.0/255.0 alpha:1.0f] forState:UIControlStateNormal];
    [navi addSubview:button];
    UIButton*buttonRight=[[UIButton alloc] initWithFrame:CGRectMake(navi.frame.size.width-65, 24, 60, 40)];
    [buttonRight addTarget:self action:@selector(next:) forControlEvents:UIControlEventTouchDown];
    [button.titleLabel setTextAlignment:NSTextAlignmentRight];
    [buttonRight setTitle:@"下一步" forState:UIControlStateNormal];
    [buttonRight setTitleColor:[UIColor colorWithRed:25.0/255.0 green:173.0/255.0 blue:220.0/255.0 alpha:1.0f] forState:UIControlStateNormal];
    [navi addSubview:buttonRight];
    [self.view bringSubviewToFront:navi];
	// Do any additional setup after loading the view.
}
-(void)choose:(NSArray *)array
{
    [sendDic setObject:[array objectAtIndex:1] forKey:@"shopCategoryWord"];
    [sendDic setObject:[array objectAtIndex:0] forKey:@"shopCategory"];
    [theCell setCategory:[array objectAtIndex:1]];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setPhoneNumber:(NSString*)number
{
    phoneNumber=number;
}
-(void)backNavi:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)next:(id)sender
{
    [self allResignFirstresponse:nil];
    NSArray*keyArray=[[NSArray alloc] initWithObjects:@"shopName",@"shopAddress",@"shopTel",@"shopCategoryDetail", nil];
    for (int i=0; i<[cellArray count]; i++) {
        TextFieldCell*cell=[cellArray objectAtIndex:i];
        if ([cell.textField.text isEqualToString:@""]) {
            UIAlertView*alter=[[UIAlertView alloc] initWithTitle:@"提示" message:@"请填写完整" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alter show];
            return;
        }else
        {
            [sendDic setObject:cell.textField.text forKey:[keyArray objectAtIndex:i]];
        }
    }
    if ([sendDic objectForKey:@"shopCategory"]==nil) {
        UIAlertView*alter=[[UIAlertView alloc] initWithTitle:@"提示" message:@"请选择营业范围" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
        return;
    }
    [self performSegueWithIdentifier:@"registerOther" sender:nil];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"registerOther"]) {
        [sendDic setObject:phoneNumber forKey:@"shopID"];
        [[segue destinationViewController] getSendFromMain:sendDic];
    }
}
#pragma mark -
#pragma mark textFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}
- (void)moveView:(UITextField *)textField leaveView:(BOOL)leave
{
        CGRect screenRect=[[UIScreen mainScreen] bounds];
        moveHeight=30;
        if (leave==YES) {
            const float movementDuration = 0.2f;
            [UIView beginAnimations: @"textFieldAnim" context: nil];
            [UIView setAnimationBeginsFromCurrentState: YES];
            [UIView setAnimationDuration: movementDuration];
            tableView.frame = CGRectOffset(tableView.frame, 0, moveHeight);
            [UIView commitAnimations];
        }else
        {
            if (moveHeight>0) {
                const float movementDuration = 0.2f;
                [UIView beginAnimations: @"textFieldAnim" context: nil];
                [UIView setAnimationBeginsFromCurrentState: YES];
                [UIView setAnimationDuration: movementDuration];
                tableView.frame = CGRectOffset(tableView.frame, 0,-moveHeight);
                [UIView commitAnimations];
            }
        }
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField==((TextFieldCell*)[cellArray objectAtIndex:3]).textField) {
    [self moveView:textField leaveView:NO];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField;
{
    if (textField==((TextFieldCell*)[cellArray objectAtIndex:1]).textField) {
        [search geocode:textField.text withCity:nil];
    }
    if (textField==((TextFieldCell*)[cellArray objectAtIndex:3]).textField) {
         [self moveView:textField leaveView:YES];
    }
}
- (IBAction)allResignFirstresponse:(id)sender
{
    for (TextFieldCell*cell in cellArray) {
        [cell.textField resignFirstResponder];
    }
}
#pragma mark - baiduMAp
- (void)onGetAddrResult:(BMKAddrInfo*)result errorCode:(int)error
{

    NSLog(@"%f,%f",result.geoPt.latitude,result.geoPt.longitude);
    [sendDic setObject:[NSNumber numberWithFloat:result.geoPt.latitude] forKey:@"shopLat"];
    [sendDic setObject:[NSNumber numberWithFloat:result.geoPt.longitude] forKey:@"shopLon"];
    //showmeg = [NSString stringWithFormat:@"经度:%f,纬度:%f",item.coordinate.latitude,item.coordinate.longitude];
        
}
#pragma mark - tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section==0) {
        return 3;
    }
    if (section==1) {
        return 2;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //static NSString *CellIdentifier = @"Cell";
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    //UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"ShopCell"];
    // Configure the cell...
    if ([indexPath section]==0) {
            TextFieldCell*cell=[tableView dequeueReusableCellWithIdentifier:@"TextFieldCell"];
            if (cell==nil) {
                NSArray*nib=[[NSBundle mainBundle] loadNibNamed:@"TextFieldCell" owner:self options:nil];
                for (id oneObject in nib) {
                    if ([oneObject isKindOfClass:[TextFieldCell class]]) {
                        cell=(TextFieldCell*)oneObject;
                        cell.selectionStyle=UITableViewCellSelectionStyleNone;
                    }
                }
                if ([indexPath row]==0) {
                    [cell.titleLabel setText:@"商店名称"];
                    [cell.textField setPlaceholder:@"店名"];
                    [cell.textField setDelegate:self];
           // [cell.textField setKeyboardType:UIKeyboardTypeNumberPad];
                    [cell.textField setReturnKeyType:UIReturnKeyNext];
                    [cellArray addObject:cell];
                }
                if ([indexPath row]==1) {
                    [cell.titleLabel setText:@"地址"];
                    [cell.textField setPlaceholder:@"xx市xx区xx路xx号"];
                    [cell.textField setDelegate:self];
            //[cell.textField setKeyboardType:UIKeyboardTypeNumberPad];
           // [cell.textField setReturnKeyType:UIReturnKeyDone];
                    [cellArray addObject:cell];
                }
                if ([indexPath row]==2) {
                    [cell.titleLabel setText:@"联系电话"];
                    [cell.textField setPlaceholder:@"xxxxxxxxx"];
                    [cell.textField setDelegate:self];
                    [cell.textField setKeyboardType:UIKeyboardTypeNumberPad];
                    //[cell.textField setReturnKeyType:UIReturnKeyDone];
                    [cellArray addObject:cell];
                }
            }
        return cell;
        }
    if ([indexPath section]==1) {
        if ([indexPath row]==0) {
        theCell=[tableView dequeueReusableCellWithIdentifier:@"categoryCell"];
        if (theCell==nil) {
            NSArray*nib=[[NSBundle mainBundle] loadNibNamed:@"categoryCell" owner:self options:nil];
            for (id oneObject in nib) {
                if ([oneObject isKindOfClass:[categoryCell class]]) {
                    theCell=(categoryCell*)oneObject;
                    theCell.selectionStyle=UITableViewCellSelectionStyleBlue;
                }
            }
            return theCell;
        }
        }
        if ([indexPath row]==1) {
            TextFieldCell*cell=[tableView dequeueReusableCellWithIdentifier:@"TextFieldCell"];
            if (cell==nil) {
                NSArray*nib=[[NSBundle mainBundle] loadNibNamed:@"TextFieldCell" owner:self options:nil];
                for (id oneObject in nib) {
                    if ([oneObject isKindOfClass:[TextFieldCell class]]) {
                        cell=(TextFieldCell*)oneObject;
                        cell.selectionStyle=UITableViewCellSelectionStyleNone;
                    }
                }
                [cell.titleLabel setText:@"类别备注"];
                [cell.textField setPlaceholder:@"补充"];
                [cell.textField setDelegate:self];
                [cell.textField setReturnKeyType:UIReturnKeyDone];
                [cellArray addObject:cell];
                return cell;
            }
        }
    }
    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath section]==1) {
        WebCategoryViewController*category=[[WebCategoryViewController alloc] init];
        [self allResignFirstresponse:nil];
        [category setDelegate:self];
        [self.navigationController pushViewController:category animated:YES];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
