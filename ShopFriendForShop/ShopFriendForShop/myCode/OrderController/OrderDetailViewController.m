//
//  OrderDetailViewController.m
//  ShopFriendForShop
//
//  Created by Beautilut on 14-8-8.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "OrderDetailObject.h"
@interface OrderDetailViewController ()
{
    UIScrollView*backScrollerView;
    OrderObject*myOrder;
    NSArray*detailArray;
}
@end

@implementation OrderDetailViewController

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
    
    backScrollerView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, navi.frame.size.height, screenBounds.size.width, screenBounds.size.height-navi.frame.size.height)];
    [backScrollerView setBackgroundColor:[UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1.0]];
    [self.view addSubview:backScrollerView];
    
    UILabel*orderName=[[UILabel alloc] initWithFrame:CGRectMake(20, 20, screenBounds.size.width-40, 20)];
    //[orderName setTextColor:[UIColor colorWithRed:25.0/255.0 green:173.0/255.0 blue:220.0/255.0 alpha:1.0f]];
    [orderName setFont:[UIFont systemFontOfSize:18.0f]];
    NSString*string=[NSString stringWithFormat:@"订单编号：%@",myOrder.orderID];
    [orderName setText:string];
    [backScrollerView addSubview:orderName];
    
    UILabel*userName=[[UILabel alloc] initWithFrame:CGRectMake(20, 60, screenBounds.size.width-40, 20)];
    //[userName setTextColor:[UIColor colorWithRed:25.0/255.0 green:173.0/255.0 blue:220.0/255.0 alpha:1.0f]];
    [userName setFont:[UIFont systemFontOfSize:18.0f]];
    string=[NSString stringWithFormat:@"用户名：%@",myOrder.userName];
    [userName setText:string];
    [backScrollerView addSubview:userName];
    
    UILabel*locationLabel=[[UILabel alloc] initWithFrame:CGRectMake(20, 100,60, 40)];
    [locationLabel setFont:[UIFont systemFontOfSize:18.0f]];
    [locationLabel setText:@"地址：  "];
    locationLabel.numberOfLines=2;
    [locationLabel sizeToFit];
    [backScrollerView addSubview:locationLabel];
    UILabel*userLocation=[[UILabel alloc] initWithFrame:CGRectMake(65,100, screenBounds.size.width-85, 40)];
    [userLocation setFont:[UIFont systemFontOfSize:18.0f]];
    string=[NSString stringWithFormat:@"%@",myOrder.userLocation];
    [userLocation setText:string];
    userLocation.numberOfLines=2;
    [userLocation sizeToFit];
    [backScrollerView addSubview:userLocation];
    
    UILabel*detailLabel=[[UILabel alloc] initWithFrame:CGRectMake(20, 160, 60, 20)];
    [detailLabel setFont:[UIFont systemFontOfSize:18.0f]];
    [detailLabel setText:@"明细："];
    [backScrollerView addSubview:detailLabel];
    
    int scrollHight=180+detailArray.count*25+50;
    if (scrollHight>backScrollerView.frame.size.height) {
        [backScrollerView setContentSize:CGSizeMake(screenBounds.size.width, scrollHight)];
    }
    //detail
    int hight=190;
    for (NSDictionary*adic in detailArray) {
        OrderDetailObject *aDetail=[OrderDetailObject orderFromDictionary:adic];
        NSString*name;
        if ([aDetail.goodNumber intValue]==1) {
            name=[NSString stringWithFormat:@"%@",aDetail.goodName];
        }else{
            name=[NSString stringWithFormat:@"(%@)*%@",aDetail.goodNumber,aDetail.goodName];
        }
        CGSize size=[name sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:16.0f]}];
        
        UILabel*detail=[[UILabel alloc] initWithFrame:CGRectMake(40, hight,screenBounds.size.width-40-100,size.height)];
        UILabel*price=[[UILabel alloc] initWithFrame:CGRectMake(screenBounds.size.width-100, hight,60,size.height)];
        [price setTextAlignment:NSTextAlignmentRight];
        [price setFont:[UIFont systemFontOfSize:16.0f]];
        [detail setFont:[UIFont systemFontOfSize:16.0f]];
        int more=0;
        if (size.width>detail.frame.size.width) {
            int line=size.width/(screenBounds.size.width-40-100)+1;
            [detail setFrame:CGRectMake(40, hight,detail.frame.size.width,line*size.height)];
            detail.lineBreakMode=UILineBreakModeCharacterWrap;
            detail.numberOfLines=0;
            more=(line-1)*size.height;
        }
        [detail setText:name];
        NSString*priceString=[NSString stringWithFormat:@"%@",aDetail.goodPrice];
        [price setText:priceString];
        [backScrollerView addSubview:detail];
        [backScrollerView addSubview:price];
        hight=hight+25+more;
    }
    
    UIView*line=[[UIView alloc] initWithFrame:CGRectMake(20, hight, screenBounds.size.width-40, 1)];
    [line setBackgroundColor:[UIColor grayColor]];
    [backScrollerView addSubview:line];
    
    UILabel*totalPrice=[[UILabel alloc] initWithFrame:CGRectMake(screenBounds.size.width-150, hight+5,110, 20)];
    NSString*totalPriceString=[NSString stringWithFormat:@"￥%@",myOrder.orderTotalPrice];
    [totalPrice setTextAlignment:NSTextAlignmentRight];
    [totalPrice setText:totalPriceString];
    [backScrollerView addSubview:totalPrice];
    //downView
    
    
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
-(void)getOrderDetail:(NSDictionary*)order
{
    myOrder=[OrderObject orderFromDictionary:order];
    detailArray=[order objectForKey:@"detail"];//=[OrderDetailObject getDetailByID:myOrder.orderID];
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
