//
//  MenuCategoryViewController.m
//  ShopFriendForShop
//
//  Created by Beautilut on 14-2-12.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import "MenuCategoryViewController.h"
#import "MenuMainViewController.h"
#import "AddView.h"
#import "SFNaviBar.h"

@interface MenuCategoryViewController ()
{
    NSMutableArray*categoryArray;
    UITableView*categoryTable;
    NSString*shopID;
    CategoryModel*postModel;
    NSIndexPath *path;
}
@end

@implementation MenuCategoryViewController

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
    //postDic=[[NSMutableDictionary alloc] init];
    shopID=[[NSUserDefaults standardUserDefaults] stringForKey:kXMPPmyJID];
    [self getMenu:shopID];
    SFNaviBar*navi=[[SFNaviBar alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [navi openNaviShadow:YES];
    [self.view addSubview:navi];
    
    UILabel*label=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    [label setCenter:CGPointMake(navi.frame.size.width/2, navi.frame.size.height-23)];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setText:@"我的菜单"];
    [label setTextColor:[UIColor colorWithRed:25.0/255.0 green:173.0/255.0 blue:220.0/255.0 alpha:1.0f]];
    [label setFont:[UIFont systemFontOfSize:19.0f]];
    [navi addSubview:label];
    
    int naviHeight=self.navigationController.navigationBar.frame.size.height+20;
    categoryTable=[[UITableView alloc] initWithFrame:CGRectMake(0,naviHeight , self.view.frame.size.width, self.view.frame.size.height-naviHeight) style:UITableViewStyleGrouped];
    [categoryTable setDelegate:self];
    [categoryTable setDataSource:self];
    [self.view addSubview:categoryTable];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getNewCategory:) name:@"categoryAdd" object:nil];
    
    UIButton *button=[[UIButton alloc] initWithFrame:CGRectMake(5, 24, 40, 40)];
    [button addTarget:self action:@selector(popViewController:) forControlEvents:UIControlEventTouchDown];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:25.0/255.0 green:173.0/255.0 blue:220.0/255.0 alpha:1.0f] forState:UIControlStateNormal];
    [navi addSubview:button];
    UIButton*buttonRight=[[UIButton alloc] initWithFrame:CGRectMake(navi.frame.size.width-45,24,40,40)];
    [buttonRight addTarget:self action:@selector(addCategory:) forControlEvents:UIControlEventTouchDown];
    [buttonRight setTitle:@"添加" forState:UIControlStateNormal];
    [buttonRight setTitleColor:[UIColor colorWithRed:25.0/255.0 green:173.0/255.0 blue:220.0/255.0 alpha:1.0f] forState:UIControlStateNormal];
    [navi addSubview:buttonRight];
    [self.view bringSubviewToFront:navi];
	// Do any additional setup after loading the view.
}
-(void)popViewController:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - navi methods
-(void)addCategory:(id)sender
{
    AddView*adView=[[AddView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) with:shopID];
    [adView setBlurImage:[self rn_screenshot]];
    [adView selfsetBack:nil];
    [adView show];
}
- (UIImage *)rn_screenshot {
    UIGraphicsBeginImageContext(self.view.bounds.size);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // helps w/ our colors when blurring
    // feel free to adjust jpeg quality (lower = higher perf)
    NSData *imageData = UIImageJPEGRepresentation(image, 0.75);
    image = [UIImage imageWithData:imageData];
    
    return image;
}
-(void)backNavi:(id)sender
{
    
}
#pragma  mark - asi
-(void)updateTableView:(id)sender
{
    [categoryTable reloadData];
}
-(void)getNewCategory:(id)sender
{
    [self getMenu:shopID];
    [categoryTable reloadData];
}
-(void)getMenu:(NSString*)string
{
    [categoryArray removeAllObjects];
    categoryArray=[CategoryModel fetchAllCategoryFromLocal];
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
    return [categoryArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString*cellIdentifier=@"Cell";
    SWTableViewCell*cell=(SWTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell==nil) {
        NSMutableArray*rightUtilityButtons=[NSMutableArray new];
        NSMutableArray*leftButtons=[NSMutableArray new];
        [rightUtilityButtons addUtilityButtonWithColor:[UIColor colorWithRed:0.78f green:0.78f blue:0.8f alpha:1.0] title:@"修改"];
        [rightUtilityButtons addUtilityButtonWithColor:[UIColor colorWithRed:1.0f green:0.231f blue:0.188 alpha:1.0f] title:@"删除"];
        [leftButtons addUtilityButtonWithColor:[UIColor colorWithRed:25.0/255.0 green:173.0/255.0 blue:220.0/255.0 alpha:1.0f] title:@"移动"];
        cell=[[SWTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier containingTableView:categoryTable leftUtilityButtons:leftButtons rightUtilityButtons:rightUtilityButtons];
        cell.delegate=self;
    }
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    CategoryModel*model=[categoryArray objectAtIndex:[indexPath row]];
    [cell.textLabel setText:model.categoryName];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    postModel=[categoryArray objectAtIndex:[indexPath row]];
    [self performSegueWithIdentifier:@"menuAdd" sender:nil];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"menuAdd"]) {
        
        [[segue destinationViewController] postInfo:postModel];
    }
}
-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    CategoryModel*model=[categoryArray objectAtIndex:sourceIndexPath.row];
    //[categoryArray exchangeObjectAtIndex:sourceIndexPath.row withObjectAtIndex:destinationIndexPath.row];
    [categoryArray removeObjectAtIndex:sourceIndexPath.row];
    [categoryArray insertObject:model atIndex:destinationIndexPath.row];
}
#pragma mark - SWTableViewDelegate
-(void)swippableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index
{
    switch (index) {
        case 0:
        {
            NSIndexPath*cellIndexPath=[categoryTable indexPathForCell:cell];
            CategoryModel*category=[categoryArray objectAtIndex:cellIndexPath.row];
            AddView*adView=[[AddView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) with:shopID withCategoryID:category.categoryID withCategoryName:category.categoryName];
            [adView setBlurImage:[self rn_screenshot]];
            [adView selfsetBack:nil];
            [adView show];
            [cell hideUtilityButtonsAnimated:YES];
            break;
        }
        case 1:
        {
            NSURL*url=[NSURL URLWithString:categoryDeleteURL];
            ASIFormDataRequest*request=[ASIFormDataRequest requestWithURL:url];
            [request setPostValue:shopID forKey:@"shopID"];
            NSIndexPath*cellIndexPath=[categoryTable indexPathForCell:cell];
            CategoryModel*category=[categoryArray objectAtIndex:cellIndexPath.row];
            [request setPostValue:category.categoryID forKey:@"categoryID"];
            [request setCompletionBlock:^{
                SBJsonParser*parser=[[SBJsonParser alloc] init];
                NSDictionary*dic=[parser objectWithString:request.responseString];
                if ([[dic objectForKey:@"back"] integerValue]==1) {
                    [CategoryModel deleteCategoryByID:category.categoryID];
                [categoryArray removeObjectAtIndex:cellIndexPath.row];
                [categoryTable deleteRowsAtIndexPaths:@[cellIndexPath] withRowAnimation:UITableViewRowAnimationLeft];
                }
            }];
            [request setFailedBlock:^{
                
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
    //NSIndexPath*cellIndexPath=[categoryTable indexPathForCell:cell];
    switch (index) {
        case 0:
            [categoryTable setEditing:!categoryTable.editing animated:YES];
            [cell hideUtilityButtonsAnimated:YES];
            if (categoryTable.editing==NO) {
                NSURL*url=[NSURL URLWithString:categoryRankURL];
                ASIFormDataRequest*request=[ASIFormDataRequest requestWithURL:url];
                [request setPostValue:shopID forKey:@"shopID"];
                NSMutableArray*postArray=[[NSMutableArray alloc] init];
                for (int i=0; i<[categoryArray count]; i++) {
                    CategoryModel*model=[categoryArray objectAtIndex:i];
                    NSMutableArray*array=[[NSMutableArray alloc] initWithObjects:model.categoryID,[NSNumber numberWithInt:i],nil];
                    [postArray addObject:array];
                }
                NSString*string=[[ToolMethods sharedMethods] JSONString:postArray];
                [request setPostValue:string forKey:@"array"];
                [request setCompletionBlock:^{
                    SBJsonParser*parser=[[SBJsonParser alloc] init];
                    NSDictionary*dic=[parser objectWithString:request.responseString];
                    if ([[dic objectForKey:@"back"] integerValue]==1) {
                        [CategoryModel updateCategoryRank:postArray];
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
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
@end
