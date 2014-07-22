//
//  PasswordCheckViewController.m
//  ShopFriendForShop
//
//  Created by Beautilut on 14-4-16.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import "PasswordCheckViewController.h"
#import "SFNaviBar.h"
@interface PasswordCheckViewController ()
{
    UITextField*phoneCheckField;
}
@end

@implementation PasswordCheckViewController
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
    
    UILabel*label=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    [label setCenter:CGPointMake(navi.frame.size.width/2, navi.frame.size.height-20)];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setText:@"密码验证"];
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
    [enterButton addTarget:self action:@selector(checkPhone:) forControlEvents:UIControlEventTouchDown];
    [enterButton.titleLabel setTextAlignment:NSTextAlignmentRight];
    [enterButton setTitle:@"确定" forState:UIControlStateNormal];
    [enterButton setTitleColor:[UIColor colorWithRed:25.0/255.0 green:173.0/255.0 blue:220.0/255.0 alpha:1.0f] forState:UIControlStateNormal];
    [navi addSubview:enterButton];
    
    phoneCheckField=[[UITextField alloc] initWithFrame:CGRectMake(40,navi.frame.origin.y+navi.frame.size.height+30, screenRect.size.width-80, 40)];
    [phoneCheckField setDelegate:self];
    [phoneCheckField setBorderStyle:UITextBorderStyleLine];
    [phoneCheckField setSecureTextEntry:YES];
    [phoneCheckField setReturnKeyType:UIReturnKeyDone];
    [self.view addSubview:phoneCheckField];
    
    [self.view bringSubviewToFront:navi];
    // Do any additional setup after loading the view.
}
-(void)backNavi:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)checkPhone:(id)sender
{
    if ([phoneCheckField.text isEqualToString:@""]) {
        UIAlertView*alter=[[UIAlertView alloc] initWithTitle:@"" message:@"请输入密码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
        return;
    }
    NSURL*url=[NSURL URLWithString:enterURL];
     NSString*hostID=[[NSUserDefaults standardUserDefaults] objectForKey:kXMPPmyJID];
    ASIFormDataRequest*request=[ASIFormDataRequest requestWithURL:url];
    [request setPostValue:hostID forKey:@"shopID"];
    [request setPostValue:phoneCheckField.text forKey:@"shopPassword"];
    [request setCompletionBlock:^{
        SBJsonParser*parser=[[SBJsonParser alloc] init];
        NSDictionary*dic=[parser objectWithString:request.responseString];
        if ([[dic objectForKey:@"back"] integerValue]==1) {
            [self dismissViewControllerAnimated:YES completion:nil];
            [delegate passwordCheckON:nil];
        }else{
            UIAlertView*alter=[[UIAlertView alloc] initWithTitle:@"错误" message:@"账号密码错误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alter show];
        }
        
    }];
    [request setFailedBlock:^{
        UIAlertView*alter=[[UIAlertView alloc] initWithTitle:@"错误" message:@"验证失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
    }];
    [request startAsynchronous];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)done:(id)sender
{
    [phoneCheckField resignFirstResponder];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
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
