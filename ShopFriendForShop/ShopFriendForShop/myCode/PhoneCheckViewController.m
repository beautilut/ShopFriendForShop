//
//  PhoneCheckViewController.m
//  ShopFriendForShop
//
//  Created by Beautilut on 14-1-23.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import "PhoneCheckViewController.h"
#import "RegisterMainViewController.h"
#import "TextFieldCell.h"
#import "SFNaviBar.h"
@interface PhoneCheckViewController ()
{
    UITableView*enterTable;
    NSMutableArray*cellArray;
    NSString*phoneNumber;
}
@end

@implementation PhoneCheckViewController

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
    cellArray =[[NSMutableArray alloc] init];
    SFNaviBar*navi=[[SFNaviBar alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [navi openNaviShadow:YES];
    [self.view addSubview:navi];

    UILabel*label=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    [label setText:@"手机验证"];
    label.font = [UIFont boldSystemFontOfSize:19.0f];
    label.textColor = [UIColor lightTextColor];
    label.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setTextColor:[UIColor colorWithRed:25.0/255.0 green:173.0/255.0 blue:220.0/255.0 alpha:1.0f]];
    [label setCenter:CGPointMake(navi.frame.size.width/2, navi.frame.size.height-23)];
    [navi addSubview:label];
    
    
    enterTable=[[UITableView alloc] initWithFrame:CGRectMake(0, navi.frame.size.height, screenRect.size.width, 150) style:UITableViewStyleGrouped];
    [enterTable setCenter:CGPointMake(screenRect.size.width/2, screenRect.size.height/4)];
    [enterTable setDelegate:self];
    [enterTable setDataSource:self];
    [enterTable setScrollEnabled:NO];
    [self.view addSubview:enterTable];
    [self.view setBackgroundColor:enterTable.backgroundColor];
    
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"registerMain"]) {
        
       [[segue destinationViewController] setPhoneNumber:phoneNumber];
    }
}
#pragma mark - navi
-(IBAction)done:(id)sender
{
    for (TextFieldCell*cell in cellArray) {
        [cell.textField resignFirstResponder];
    }
}
-(void)backNavi:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    //[self dismissViewControllerAnimated:YES completion:nil];
}
-(void)next:(id)sender
{
    TextFieldCell*cell=[cellArray objectAtIndex:0];
    if ([cell.textField.text isEqualToString:@""]) {
        UIAlertView*alter=[[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入手机号" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
        return;
    }
    phoneNumber=cell.textField.text;
    cell=[cellArray objectAtIndex:1];
    if ([cell.textField.text isEqualToString:@""]) {
        UIAlertView*alter=[[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入验证码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
        return;
    }
    [self performSegueWithIdentifier:@"registerMain" sender:nil];
}
#pragma mark - tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //static NSString *CellIdentifier = @"Cell";
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    //UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"ShopCell"];
    // Configure the cell...
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
            [cell.titleLabel setText:@"手机号码"];
            [cell.textField setPlaceholder:@"请输入手机号码"];
            [cell.textField setDelegate:self];
            [cell.textField setKeyboardType:UIKeyboardTypeNumberPad];
            [cell.textField setReturnKeyType:UIReturnKeyDone];
            [cellArray addObject:cell];
        }
        if ([indexPath row]==1) {
            [cell.titleLabel setText:@"验证码"];
            [cell.textField setSecureTextEntry:YES];
            [cell.textField setPlaceholder:@"请出入验证码"];
            [cell.textField setDelegate:self];
            [cell.textField setKeyboardType:UIKeyboardTypeNumberPad];
            [cell.textField setReturnKeyType:UIReturnKeyDone];
            [cellArray addObject:cell];
        }
    }
    return cell;
}
#pragma mark - textfield
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    TextFieldCell*cell=[cellArray objectAtIndex:0];
    if (textField==cell.textField) {
        if (range.location>10) {
            return NO;
        }
    }
    return YES;
}

@end
