//
//  EnterViewController.m
//  ShopFriendForShop
//
//  Created by Beautilut on 14-1-23.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import "EnterViewController.h"
#import "NSObject_URLHeader.h"
#import "AppDelegate.h"
#import "TextFieldCell.h"
#import "SFNaviBar.h"
@interface EnterViewController ()
{
    TextFieldCell*shopID;
    TextFieldCell*shopPassword;
}
@end

@implementation EnterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillDisappear:(BOOL)animated
{
}
-(void)viewWillAppear:(BOOL)animated
{
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    CGRect screenRect=[[UIScreen mainScreen] bounds];
    
    SFNaviBar*navi=[[SFNaviBar alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [navi openNaviShadow:YES];
    [self.view addSubview:navi];
    
    UILabel*label=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    [label setCenter:CGPointMake(navi.frame.size.width/2, navi.frame.size.height-23)];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setText:@"店友店铺"];
    [label setTextColor:[UIColor colorWithRed:25.0/255.0 green:173.0/255.0 blue:220.0/255.0 alpha:1.0f]];
    [label setFont:[UIFont systemFontOfSize:19.0f]];
    [navi addSubview:label];
    
    UIButton*leftButton=[[UIButton alloc] initWithFrame:CGRectMake(5, 24, 40, 40)];
    [leftButton addTarget:self action:@selector(backNavi:) forControlEvents:UIControlEventTouchDown];
    [leftButton.titleLabel setTextAlignment:NSTextAlignmentLeft];
    [leftButton setTitle:@"返回" forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor colorWithRed:25.0/255.0 green:173.0/255.0 blue:220.0/255.0 alpha:1.0f] forState:UIControlStateNormal];
    [navi addSubview:leftButton];
    
    UIButton*enterButton=[[UIButton alloc] initWithFrame:CGRectMake(navi.frame.size.width-45,24,40,40)];
    [enterButton addTarget:self action:@selector(enter:) forControlEvents:UIControlEventTouchDown];
    [enterButton.titleLabel setTextAlignment:NSTextAlignmentRight];
    [enterButton setTitle:@"登录" forState:UIControlStateNormal];
    [enterButton setTitleColor:[UIColor colorWithRed:25.0/255.0 green:173.0/255.0 blue:220.0/255.0 alpha:1.0f] forState:UIControlStateNormal];
    [navi addSubview:enterButton];
    
    
    UITableView*table=[[UITableView alloc] initWithFrame:CGRectMake(0,0, screenRect.size.width,150) style:UITableViewStyleGrouped];
    [table setCenter:CGPointMake(screenRect.size.width/2, screenRect.size.height/4)];
    [table setDelegate:self];
    [table setDataSource:self];
    [table setScrollEnabled:NO];
    [self.view addSubview:table];
    [self.view setBackgroundColor:table.backgroundColor];
    [self.view bringSubviewToFront:navi];
	// Do any additional setup after loading the view.
}
-(void)backNavi:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    //[self dismissViewControllerAnimated:YES completion:nil];
}
-(void)enter:(id)sender
{
    [self done:nil];
    if (shopID.textField.text.length==0||shopPassword.textField.text.length==0) {
        UIAlertView*alter=[[UIAlertView alloc] initWithTitle:@"错误" message:@"请填写完账号密码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
        return;
    }else
    {
        NSDictionary*dic=[NSDictionary dictionaryWithObjectsAndKeys:shopID.textField.text,@"shopID",shopPassword.textField.text,@"password",nil];
        [[WebShopMethods share] setDelegate:self];
        [[WebShopMethods share] enter:dic];
    }
}
#pragma mark enterDelegate
-(void)enterSuccess
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)enterPasswordError
{
    UIAlertView*alter=[[UIAlertView alloc] initWithTitle:@"错误" message:@"账号密码错误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alter show];
}
-(void)enterFail
{
    UIAlertView*alter=[[UIAlertView alloc] initWithTitle:@"错误" message:@"登录失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
           [alter show];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
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
            [cell.titleLabel setText:@"用户账号"];
            [cell.textField setPlaceholder:@"请输入手机号码"];
            [cell.textField setDelegate:self];
            [cell.textField setKeyboardType:UIKeyboardTypeNumberPad];
            [cell.textField setReturnKeyType:UIReturnKeyDone];
            shopID=cell;
        }
        if ([indexPath row]==1) {
            [cell.titleLabel setText:@"密码"];
            [cell.textField setSecureTextEntry:YES];
            [cell.textField setPlaceholder:@"请出入密码"];
            [cell.textField setDelegate:self];
            [cell.textField setSecureTextEntry:YES];
            [cell.textField setReturnKeyType:UIReturnKeyDone];
            shopPassword=cell;
        }
    }
    return cell;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}
-(IBAction)done:(id)sender
{
    [shopID.textField resignFirstResponder];
    [shopPassword.textField resignFirstResponder];
}
@end
