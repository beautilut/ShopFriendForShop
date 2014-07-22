//
//  MenuMainViewController.m
//  ShopFriendForShop
//
//  Created by Beautilut on 14-2-12.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import "MenuMainViewController.h"
#import "AddMenuViewController.h"
#import "AddView.h"
#import "SFNaviBar.h"
@interface MenuMainViewController ()
{
    NSString*shopID;
    NSString*categoryID;
    UITableView*menuTable;
    NSMutableArray*menuArray;
    BOOL change;
    NSMutableDictionary*postDic;
    NSIndexPath *path;
}
@end

@implementation MenuMainViewController

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
    postDic=[[NSMutableDictionary alloc] init];
    
    SFNaviBar*navi=[[SFNaviBar alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [navi openNaviShadow:YES];
    [self.view addSubview:navi];
//    UIBarButtonItem*leftButton=[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:self action:@selector(backNavi:)];
//    self.navigationItem.leftBarButtonItem=leftButton;
//    UIBarButtonItem*rightButton=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewMenu:)];
//    self.navigationItem.rightBarButtonItem=rightButton;
    
    int naviHeight=self.navigationController.navigationBar.frame.size.height+20;
    menuTable=[[UITableView alloc] initWithFrame:CGRectMake(0,naviHeight , self.view.frame.size.width, self.view.frame.size.height-naviHeight) style:UITableViewStyleGrouped];
    [menuTable setDelegate:self];
    [menuTable setDataSource:self];
    [self.view addSubview:menuTable];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(menuAdd:) name:@"menuAdd" object:nil];
    
    UIButton *button=[[UIButton alloc] initWithFrame:CGRectMake(5, 24, 40, 40)];
    [button addTarget:self action:@selector(popViewController:) forControlEvents:UIControlEventTouchDown];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:25.0/255.0 green:173.0/255.0 blue:220.0/255.0 alpha:1.0f] forState:UIControlStateNormal];
    [navi addSubview:button];
    UIButton*buttonRight=[[UIButton alloc] initWithFrame:CGRectMake(navi.frame.size.width-45,24,40,40)];
    [buttonRight addTarget:self action:@selector(addNewMenu:) forControlEvents:UIControlEventTouchDown];
    [buttonRight setTitle:@"添加" forState:UIControlStateNormal];
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
#pragma mark - navi methods
-(void)postInfo:(CategoryModel*)model
{
    shopID=model.shopID;
    //NSDictionary*cateDic=[dic objectForKey:@"category"];
    categoryID=model.categoryID;
    menuArray=[MenuObject fetchAllGoodFromLocal:categoryID];
}
-(void)popViewController:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)addNewMenu:(id)sender
{
    [postDic setObject:@"add" forKey:@"kind"];
    [self performSegueWithIdentifier:@"addMenu" sender:nil];
}
-(void)menuAdd:(id)sender
{
    menuArray=[MenuObject fetchAllGoodFromLocal:categoryID];
    [menuTable reloadData];
}
#pragma mark - tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [menuArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //static NSString *CellIdentifier = @"Cell";
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    //UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"ShopCell"];
    // Configure the cell...
    static NSString*cellIdentifier=@"Cell";
    SWTableViewCell*cell=(SWTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell==nil) {
        NSMutableArray*rightUtilityButtons=[NSMutableArray new];
        NSMutableArray*leftButtons=[NSMutableArray new];
        [rightUtilityButtons addUtilityButtonWithColor:[UIColor colorWithRed:1.0f green:0.231f blue:0.188 alpha:1.0f] title:@"删除"];
        [leftButtons addUtilityButtonWithColor:[UIColor colorWithRed:25.0/255.0 green:173.0/255.0 blue:220.0/255.0 alpha:1.0f] title:@"移动"];
        cell=[[SWTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier containingTableView:menuTable leftUtilityButtons:leftButtons rightUtilityButtons:rightUtilityButtons];
        cell.delegate=self;
    }
    MenuObject*menu=[menuArray objectAtIndex:[indexPath row]];
    [cell.textLabel setText:menu.goodName];
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = kCFNumberFormatterCurrencyStyle;
    float floatNumber=[menu.goodPrice floatValue];
    NSString *pricestring = [formatter stringFromNumber:[NSNumber numberWithFloat:floatNumber]];
    NSString*price=[NSString stringWithFormat:@"%@",pricestring];
    [cell.detailTextLabel setText:price];
    [cell.detailTextLabel setTextColor:[UIColor orangeColor]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MenuObject*menu=[menuArray objectAtIndex:[indexPath row]];
    [postDic setObject:menu forKey:@"menuDetail"];
    [postDic setObject:@"change" forKey:@"kind"];
    [self performSegueWithIdentifier:@"addMenu" sender:nil];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"addMenu"]) {
       [postDic setObject:categoryID forKey:@"categoryID"];
        [postDic setObject:shopID forKey:@"shopID"];
        [[segue destinationViewController] getInfo:postDic];
        [postDic removeAllObjects];
        
    }
}
#pragma mark - SWTableViewDelegate
-(void)swippableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index
{
    switch (index) {
        case 0:
        {
            NSIndexPath*cellIndexPath=[menuTable indexPathForCell:cell];
            MenuObject*menu=[menuArray objectAtIndex:cellIndexPath.row];
            NSURL*url=[NSURL URLWithString:menuDeleteURL];
            ASIFormDataRequest*request=[ASIFormDataRequest requestWithURL:url];
            [request setPostValue:menu.goodPhotoCount forKey:@"count"];
            [request setPostValue:shopID forKey:@"shopID"];
            [request setPostValue:menu.goodID forKey:@"goodID"];
            //[request setPostValue:menu.goodName forKey:@"goodName"];
            [request setPostValue:menu.categoryID forKey:@"goodCategory"];
            [request setCompletionBlock:^{
                SBJsonParser*parser=[[SBJsonParser alloc] init];
                NSDictionary*dic=[parser objectWithString:request.responseString];
                if ([[dic objectForKey:@"back"] intValue]==1) {
                    [MenuObject deleteGoodById:menu.goodID];
                    [menuArray removeObjectAtIndex:cellIndexPath.row];
                    [menuTable deleteRowsAtIndexPaths:@[cellIndexPath] withRowAnimation:UITableViewRowAnimationLeft];
                }
            }];
            [request setFailedBlock:^{
                UIAlertView*alter=[[UIAlertView alloc] initWithTitle:@"错误" message:@"修改失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alter show];
                [self.navigationController popViewControllerAnimated:YES];
            }];
            [request startAsynchronous];
            break;
        }
        default:
            break;
    }
}
-(void)swippableTableViewCell:(SWTableViewCell *)cell didTriggerLeftUtilityButtonWithIndex:(NSInteger)index
{
    NSIndexPath*cellIndexPath=[menuTable indexPathForCell:cell];
    switch (index) {
        case 0:
            [menuTable setEditing:!menuTable.editing animated:YES];
            [cell hideUtilityButtonsAnimated:YES];
            if (menuTable.editing==NO) {
                NSURL*url=[NSURL URLWithString:menuRankURL];
                ASIFormDataRequest*request=[ASIFormDataRequest requestWithURL:url];
                //[request setPostValue:shopID forKey:@"shopID"];
                [request setPostValue:categoryID forKey:@"categoryID"];
                NSMutableArray*postArray=[[NSMutableArray alloc] init];
                for (int i=0; i<[menuArray count]; i++) {
                    MenuObject*model=[menuArray objectAtIndex:i];
                    NSMutableArray*array=[[NSMutableArray alloc] initWithObjects:model.goodID,[NSNumber numberWithInt:i],nil];
                    [postArray addObject:array];
                }
                NSString*string=[self JSONString:postArray];
                [request setPostValue:string forKey:@"array"];
                [request setCompletionBlock:^{
                    SBJsonParser*parser=[[SBJsonParser alloc] init];
                    NSDictionary*dic=[parser objectWithString:request.responseString];
                    if ([[dic objectForKey:@"back"] integerValue]==1) {
                        [MenuObject updategoodRank:postArray];
                    }
                }];
                [request setFailedBlock:^{
                    
                }];
                
                [request startAsynchronous];
            }
            break;
        default:
            break;
    }
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleNone;
}
-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    MenuObject*model=[menuArray objectAtIndex:sourceIndexPath.row];
    //[categoryArray exchangeObjectAtIndex:sourceIndexPath.row withObjectAtIndex:destinationIndexPath.row];
    [menuArray removeObjectAtIndex:sourceIndexPath.row];
    [menuArray insertObject:model atIndex:destinationIndexPath.row];
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
-(NSString*)JSONString:(id)data;
{
    NSError* error = nil;
    id result = [NSJSONSerialization dataWithJSONObject:data options:kNilOptions
                                                  error:&error];
    if (error != nil) return nil;
    NSString*string=[[NSString alloc] initWithData:result encoding:NSASCIIStringEncoding];
    return string;
}
@end
