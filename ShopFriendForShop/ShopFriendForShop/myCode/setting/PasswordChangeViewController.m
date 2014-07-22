//
//  PasswordChangeViewController.m
//  shopFriend
//
//  Created by Beautilut on 14-3-20.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import "PasswordChangeViewController.h"
#import "SFNaviBar.h"
@interface PasswordChangeViewController ()
{
    UITableView*passwordTable;
    TextFieldCell *oneCell;
    TextFieldCell *twoCell;
}
@end

@implementation PasswordChangeViewController

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
    UIButton*leftButton=[[UIButton alloc] initWithFrame:CGRectMake(5, 24, 40, 40)];
    [leftButton addTarget:self action:@selector(backNavi:) forControlEvents:UIControlEventTouchDown];
    [leftButton.titleLabel setTextAlignment:NSTextAlignmentLeft];
    [leftButton setTitle:@"返回" forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor colorWithRed:25.0/255.0 green:173.0/255.0 blue:220.0/255.0 alpha:1.0f] forState:UIControlStateNormal];
    [navi addSubview:leftButton];
    passwordTable=[[UITableView alloc] initWithFrame:CGRectMake(0, 0,screenBounds.size.width,screenBounds.size.height) style:UITableViewStyleGrouped];
    [passwordTable setDelegate:self];
    [passwordTable setDataSource:self];
    float topInset = self.navigationController.navigationBar.frame.size.height+20;
    passwordTable.contentInset = UIEdgeInsetsMake(topInset, 0, 0, 0);
    [self.view addSubview:passwordTable];
    UIButton*checkButton=[[UIButton alloc] initWithFrame:CGRectMake(navi.frame.size.width-45,24,40,40)];
    [checkButton addTarget:self action:@selector(changePassword:) forControlEvents:UIControlEventTouchDown];
    [checkButton.titleLabel setTextAlignment:NSTextAlignmentRight];
    [checkButton setTitle:@"确定" forState:UIControlStateNormal];
    [checkButton setTitleColor:[UIColor colorWithRed:25.0/255.0 green:173.0/255.0 blue:220.0/255.0 alpha:1.0f] forState:UIControlStateNormal];

    [navi addSubview:checkButton];
    [self.view bringSubviewToFront:navi];
    // Do any additional setup after loading the view.
}
-(void)backNavi:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)changePassword:(id)sender
{
    NSString*password=oneCell.textField.text;
    NSString*check=twoCell.textField.text;
    if (password.length<6||check.length<6) {
        UIAlertView*alter=[[UIAlertView alloc] initWithTitle:@"错误" message:@"密码长度小于6位" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alter show];
        return;
    }
    
    if (![oneCell.textField.text isEqualToString:@""]&&![twoCell.textField.text isEqualToString:@""]) {
        if ([password isEqualToString:check]) {
            NSURL*url=[NSURL URLWithString:shopInfoChangeURL];
            ASIFormDataRequest*request=[ASIFormDataRequest requestWithURL:url];
            [request setPostValue:@"shop_password" forKey:@"key"];
            [request setPostValue:password forKey:@"data"];
            NSString*hostID=[[NSUserDefaults standardUserDefaults]objectForKey:kXMPPmyJID];
            [request setPostValue:hostID forKey:@"host"];
            [request setCompletionBlock:^{
                SBJsonParser*parser=[[SBJsonParser alloc] init];
                NSDictionary*dic=[parser objectWithString:request.responseString];
                if ([[dic objectForKey:@"back"] intValue]==1) {
                    [[NSUserDefaults standardUserDefaults] setObject:password forKey:kXMPPmyPassword];
                    [[SFXMPPManager sharedInstance] disconnect];
                    [[SFXMPPManager sharedInstance] connect];
                     [self.navigationController popViewControllerAnimated:YES];
                }
            }];
            [request setFailedBlock:^{
                UIAlertView*alter=[[UIAlertView alloc] initWithTitle:@"错误" message:@"修改失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alter show];
                [self.navigationController popViewControllerAnimated:YES];
            }];
            [request startAsynchronous];
        }else
        {
            UIAlertView*alter=[[UIAlertView alloc] initWithTitle:@"错误" message:@"密码不一致" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alter show];
            return;
        }
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    TextFieldCell*cell=[tableView dequeueReusableCellWithIdentifier:@"TextFieldCell"];
    if (cell==nil) {
        NSArray*nib=[[NSBundle mainBundle] loadNibNamed:@"TextFieldCell" owner:self options:nil];
        for (id oneObject in nib) {
            if ([oneObject isKindOfClass:[TextFieldCell class]]) {
                cell=(TextFieldCell*)oneObject;
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
            }
        }
    }
    if ([indexPath row]==0) {
        [cell.titleLabel setText:@"密码 "];
        [cell.textField setPlaceholder:@"请设置密码"];
        [cell.textField setDelegate:self];
        [cell.textField setReturnKeyType:UIReturnKeyNext];
        [cell.textField setSecureTextEntry:YES];
        oneCell=cell;
    }
    if ([indexPath row]==1) {
        [cell.titleLabel setText:@"确认密码"];
        [cell.textField setPlaceholder:@"请再次填入"];
        [cell.textField setDelegate:self];
        [cell.textField setReturnKeyType:UIReturnKeyDone];
        [cell.textField setSecureTextEntry:YES];
        twoCell=cell;
    }
    return cell;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField==oneCell.textField) {
        [twoCell.textField becomeFirstResponder];
    }else
    {
    [textField resignFirstResponder];
    }
    return YES;
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
