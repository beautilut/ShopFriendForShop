//
//  AppDelegate.m
//  ShopFriendForShop
//
//  Created by Beautilut on 14-1-23.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import "AppDelegate.h"
#import "NSObject_URLHeader.h"
#import "DDLog.h"
#import "DDTTYLogger.h"
@implementation AppDelegate
BMKMapManager* _mapManager;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeSound|UIRemoteNotificationTypeAlert)];
    
    _mapManager=[[BMKMapManager alloc] init];
    BOOL ret = [_mapManager start:@"HmNiM2bOmGyDEBXnY2inMepp" generalDelegate:self];
	if (!ret) {
		NSLog(@"manager start failed!");
	}
    if (![[SFXMPPManager sharedInstance] connect])
	{
		dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.0 * NSEC_PER_SEC);
		dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            //DisplayViewController*displayView=[mainStoryboard instantiateViewControllerWithIdentifier:@"DisplayView"];
            UINavigationController*navi=[mainStoryboard instantiateViewControllerWithIdentifier:@"DisplayView"];
            [self.window.rootViewController  presentViewController:navi animated:YES completion:Nil];
            //[self.window.rootViewController pushViewController:userEnterView animated:YES];
		});
	}else
    {
        [[InfoManager sharedInfo] getShopInfo];
    }
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    if (![[SFXMPPManager sharedInstance] connect]) {
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.0 * NSEC_PER_SEC);
		dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            //UserEnterViewController*userEnterView=[mainStoryboard instantiateViewControllerWithIdentifier:@"userEnter"];
            UINavigationController*navi=[mainStoryboard instantiateViewControllerWithIdentifier:@"DisplayView"];
            [self.window.rootViewController  presentViewController:navi animated:NO completion:Nil];
            //[self.window.rootViewController pushViewController:userEnterView animated:YES];
		});
        
    }
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    application.applicationIconBadgeNumber=0;
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)onGetPermissionState:(int)iError
{
    if (0 == iError) {
        NSLog(@"授权成功");
    }
    else {
        NSLog(@"onGetPermissionState %d",iError);
    }
}
#pragma mark -push-
-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSLog(@"%@",deviceToken);
    
}
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSLog(@"%@",userInfo);
}
@end
