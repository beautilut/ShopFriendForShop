//
//  InfoChangeViewController.m
//  ShopFriendForShop
//
//  Created by Beautilut on 14-4-16.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import "InfoChangeViewController.h"
#import "SFNaviBar.h"
#import "TextFieldCell.h"
#import "categoryCell.h"
@interface InfoChangeViewController ()
{
    UITextField*infoTextField;
    UITextView*infoTextView;
    UITableView*infoTable;
    categoryCell*theCell;
    TextFieldCell*textFieldCell;
    
    NSString*oldInfo;
    NSString*infoKind;
    NSString*titleString;
    ShopObject*myShop;
    NSNumber*categoryNumber;
    NSString*categoryString;
    BMKSearch*search;
    NSNumber*lat;
    NSNumber*lon;
    NSNumber*infoKindNumber;
    NSArray*infoKindArray;
}
@end

@implementation InfoChangeViewController

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
    search=[[BMKSearch alloc] init];
    [search setDelegate:self];
    UILabel*label=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    [label setCenter:CGPointMake(navi.frame.size.width/2, navi.frame.size.height-23)];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setText:titleString];
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
    [enterButton addTarget:self action:@selector(checkSure:) forControlEvents:UIControlEventTouchDown];
    [enterButton.titleLabel setTextAlignment:NSTextAlignmentRight];
    [enterButton setTitle:@"确定" forState:UIControlStateNormal];
    [enterButton setTitleColor:[UIColor colorWithRed:25.0/255.0 green:173.0/255.0 blue:220.0/255.0 alpha:1.0f] forState:UIControlStateNormal];
    [navi addSubview:enterButton];
    
    switch ([infoKindNumber intValue]) {
        case 1:
            infoTextField=[[UITextField alloc] initWithFrame:CGRectMake(40,navi.frame.origin.y+navi.frame.size.height+30, screenRect.size.width-80, 40)];
            [infoTextField setText:oldInfo];
            [infoTextField setDelegate:self];
            [infoTextField setTextAlignment:NSTextAlignmentCenter];
            [infoTextField setBorderStyle:UITextBorderStyleLine];
            [infoTextField setReturnKeyType:UIReturnKeyDone];
            [self.view addSubview:infoTextField];
            break;
        case 2:
            infoTextView=[[UITextView alloc] initWithFrame:CGRectMake(40,navi.frame.origin.y+navi.frame.size.height+30, screenRect.size.width-80, 140)];
            [infoTextView setText:oldInfo];
            [infoTextView setFont:[UIFont systemFontOfSize:15.0f]];
            [infoTextView setDelegate:self];
            infoTextView.layer.borderWidth=1.0f;
            infoTextView.layer.borderColor=[UIColor blackColor].CGColor;
            infoTextView.layer.masksToBounds = YES;
            infoTextView.layer.cornerRadius = 6.0;
            [infoTextView setReturnKeyType:UIReturnKeyDone];
            [self.view addSubview:infoTextView];
            break;
        case 3:
            infoTable=[[UITableView alloc] initWithFrame:CGRectMake(0, navi.frame.size.height, screenRect.size.width,screenRect.size.height-navi.frame.size.height) style:UITableViewStyleGrouped];
            [infoTable setDelegate:self];
            [infoTable setDataSource:self];
            [infoTable setScrollEnabled:NO];
            [self.view addSubview:infoTable];
            break;
        default:
            break;
    }
    [self.view bringSubviewToFront:navi];
    // Do any additional setup after loading the view.
}
-(void)backNavi:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)getInfoKind:(NSString *)kind
{
    myShop=[ShopObject fetchShopInfo];
    if ([kind isEqualToString:@"name"]) {
        oldInfo=myShop.shopName;
        infoKind=@"shop_name";
        titleString=@"店名修改";
        infoKindNumber=[NSNumber numberWithInt:1];
    }
    if ([kind isEqualToString:@"phone"]) {
        oldInfo=myShop.shopTel;
        infoKind=@"shop_tel";
        titleString=@"电话修改";
        infoKindNumber=[NSNumber numberWithInt:1];
    }
    if ([kind isEqualToString:@"address"]) {
        oldInfo=myShop.shopAddress;
        infoKind=@"shop_address";
        titleString=@"地址修改";
        infoKindNumber=[NSNumber numberWithInt:2];
    }
    if ([kind isEqualToString:@"category"]) {
        infoKind=@"shop_category";
        titleString=@"类型修改";
        oldInfo=myShop.shopCategoryDetail;
        categoryNumber=myShop.shopCategory;
        categoryString=myShop.shopCategoryWord;
        infoKindNumber=[NSNumber numberWithInt:3];
    }
    infoKindArray=[[NSArray alloc]   initWithObjects:@"shop_name",@"shop_tel",@"shop_address",@"shop_category",nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)done:(id)sender
{
    [infoTextField resignFirstResponder];
    [infoTextView resignFirstResponder];
    [textFieldCell.textField resignFirstResponder];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}
#pragma mark - table -
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath row]==0) {
        theCell=[tableView dequeueReusableCellWithIdentifier:@"categoryCell"];
        if (theCell==nil) {
            NSArray*nib=[[NSBundle mainBundle] loadNibNamed:@"categoryCell" owner:self options:nil];
            for (id oneObject in nib) {
                if ([oneObject isKindOfClass:[categoryCell class]]) {
                    theCell=(categoryCell*)oneObject;
                    theCell.selectionStyle=UITableViewCellSelectionStyleBlue;
                    [theCell setCategory:myShop.shopCategoryWord];
                }
            }
            [theCell setSelectionStyle:UITableViewCellSelectionStyleNone];
            return theCell;
        }
    }
    if ([indexPath row]==1) {
        textFieldCell=[tableView dequeueReusableCellWithIdentifier:@"TextFieldCell"];
        if (textFieldCell==nil) {
            NSArray*nib=[[NSBundle mainBundle] loadNibNamed:@"TextFieldCell" owner:self options:nil];
            for (id oneObject in nib) {
                if ([oneObject isKindOfClass:[TextFieldCell class]]) {
                    textFieldCell=(TextFieldCell*)oneObject;
                    [textFieldCell.textField setReturnKeyType:UIReturnKeyDone];
                    [textFieldCell.textField setDelegate:self];
                    textFieldCell.selectionStyle=UITableViewCellSelectionStyleNone;
                    [textFieldCell.textField setText:myShop.shopCategoryDetail];
                }
            }
            [textFieldCell.titleLabel setText:@"类别备注"];
            [textFieldCell.textField setPlaceholder:@"补充"];
            [textFieldCell.textField setDelegate:self];
            return textFieldCell;
        }
    }
    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        WebCategoryViewController*category=[[WebCategoryViewController alloc] init];
        [category setDelegate:self];
        [self.navigationController pushViewController:category animated:YES];
    }
}
-(void)choose:(NSArray *)array
{
    categoryNumber=[array objectAtIndex:0];
    categoryString=[array objectAtIndex:1];
    [theCell setCategory:categoryString];
}
#pragma mark - info change -
-(void)checkSure:(id)sender
{
    BOOL update=NO;
    switch ([infoKindNumber intValue]) {
        case 1:
            if ([infoTextField.text isEqual:@""]) {
                UIAlertView*alter=[[UIAlertView alloc] initWithTitle:nil message:@"修改内容不能为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alter show];
                return;
            }
            if ([infoTextField.text isEqual:oldInfo]) {
                [self.navigationController popViewControllerAnimated:YES];
                return;
            }
            update=YES;
            break;
        case 2:
            if ([infoTextView.text isEqual:@""]) {
                UIAlertView*alter=[[UIAlertView alloc] initWithTitle:nil message:@"修改内容不能位空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alter show];
                return;
            }
            if ([infoTextView.text isEqual:oldInfo]) {
                [self.navigationController popViewControllerAnimated:YES];
            }
            update=YES;
            break;
        case 3:
            if ([textFieldCell.textField.text isEqual:@""]) {
                UIAlertView*alter=[[UIAlertView alloc] initWithTitle:nil message:@"品类明细不能为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alter show];
                return;
            }
            if ([textFieldCell.textField.text isEqual:oldInfo]&&categoryNumber==myShop.shopCategory) {
                [self.navigationController popViewControllerAnimated:YES];
            }
            update=YES;
            break;
        default:
            break;
    }
    if (update) {
        [self infoChange:nil];
    }
}
-(void)infoChange:(id)sender
{
    NSURL*url=[NSURL URLWithString:shopInfoChangeURL];
    ASIFormDataRequest*request=[ASIFormDataRequest requestWithURL:url];
    switch ([infoKindNumber intValue]) {
        case 1:
            [request setPostValue:infoTextField.text forKey:@"data"];
            [request setPostValue:infoKind forKey:@"key"];
            break;
        case 2:
            [request setPostValue:infoTextView.text forKey:@"data"];
            [request setPostValue:lat forKey:@"lat"];
            [request setPostValue:lon forKey:@"lon"];
            [request setPostValue:infoKind forKey:@"key"];
            break;
        case 3:
            [request setPostValue:categoryNumber forKey:@"data"];
            [request setPostValue:textFieldCell.textField.text forKey:@"data2"];
            [request setPostValue:infoKind forKey:@"key"];
            break;
        default:
            break;
    }
    NSString*hostID=[[NSUserDefaults standardUserDefaults]objectForKey:kXMPPmyJID];
    [request setPostValue:hostID forKey:@"host"];
    [request setCompletionBlock:^{
        SBJsonParser*parser=[[SBJsonParser alloc] init];
        NSDictionary*dic=[parser objectWithString:request.responseString];
        if ([[dic objectForKey:@"back"] intValue]==1) {
            NSUInteger index=[infoKindArray indexOfObject:infoKind];
            switch (index) {
                case 0:
                    [ShopObject updateShop:@"shopName" with:infoTextField.text];
                    break;
                case 1:
                    [ShopObject updateShop:@"shopTel" with:infoTextField.text];
                    break;
                case 2:
                    [ShopObject updateShop:@"shopAddress" with:infoTextView.text];
                    break;
                case 3:
                    [ShopObject updateShop:@"shopCategory" with:categoryNumber];
                    [ShopObject updateShop:@"shopCategoryWord" with:categoryString];
                    [ShopObject updateShop:@"shopCategoryDetail" with:textFieldCell.textField.text];
                    break;
                default:
                    break;
            }
        }
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [request setFailedBlock:^{
        UIAlertView*alter=[[UIAlertView alloc] initWithTitle:nil message:@"修改失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alter show];
    }];
    [request startAsynchronous];
}
//#pragma mark - baiduMAp
//-(void)textViewDidEndEditing:(UITextView *)textView
//{
//    [search geocode:textView.text withCity:nil];
//}
//- (void)onGetAddrResult:(BMKAddrInfo*)result errorCode:(int)error
//{
//    
//    lat=[NSNumber numberWithFloat:result.geoPt.latitude];
//    lon=[NSNumber numberWithFloat:result.geoPt.longitude];
//    NSLog(@"%f,%f",result.geoPt.latitude,result.geoPt.longitude);
//    //showmeg = [NSString stringWithFormat:@"经度:%f,纬度:%f",item.coordinate.latitude,item.coordinate.longitude];
//}
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
