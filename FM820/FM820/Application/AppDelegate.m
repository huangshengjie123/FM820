//
//  AppDelegate.m
//  FM820
//
//  Created by 石芸蕾 on 16/9/29.
//  Copyright © 2016年 Shirley. All rights reserved.
//

#import "AppDelegate.h"
#import "FMTabBarController.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "User.h"

#import <SMS_SDK/SMSSDK.h>
#import <UMSocialCore/UMSocialCore.h>



@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    //设置根视图
    self.window.rootViewController = [[FMTabBarController alloc] init];
    
    //初始化应用，appKey和appSecret从后台申请得
    [SMSSDK registerApp:@"17e5d748d1d04"
                    withSecret:@"13dbfad35380acd249f6b19317d0bff9"];
    
    
    //初始化U-Share及第三方平台
    //打开调试日志
    [[UMSocialManager defaultManager] openLog:YES];
    //设置友盟appkey
    [[UMSocialManager defaultManager] setUmSocialAppkey:@"57ff206f67e58eb8260013df"];
    //设置微信的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wx50cda8ed84f72610" appSecret:@"a13cfe678f157682a03407a96ead2c5d" redirectURL:@"http://mobile.umeng.com/social"];
    
    [self.window makeKeyAndVisible];
    
      
    return YES;
}

#pragma mark 设置系统回调
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

//+ (BOOL)checkTabbarLogin
//{
//    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    NSString *isHaveRun =  [[NSUserDefaults standardUserDefaults] objectForKey:];
//}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//调用登录
+ (BOOL)loginMain
{
    
    
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    FMTabBarController *tabbarController = [[FMTabBarController alloc] init];
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"KHaveLogin"] isEqualToString:@"YES"]) {
     
        tabbarController.selectedIndex = 3;
    }else{
        tabbarController.selectedIndex = 0;
    }
    
    
    app.window.rootViewController = tabbarController;
    //    app.isLoginLock = YES;
    return YES;

}

//检验是否登录
+ (BOOL)checkTabbarLogin
{
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSString *isHaveRun = [[NSUserDefaults standardUserDefaults] objectForKey:KHaveLogin];
    if (!isHaveRun || [isHaveRun isEqualToString:@"NO"]) {
        if (app.window.rootViewController.presentingViewController == nil) {
            //  跳转登录
            LoginViewController *loginVC = [[LoginViewController alloc] init];
            //            loginVC.typeStr = @"tabbar";
            UINavigationController *baseNav = [[UINavigationController alloc]initWithRootViewController:loginVC];
            [app.window.rootViewController presentViewController:baseNav animated:YES completion:^{
            }];
        }
        return NO;
    }else{
        return YES;
    }
}

//检验是否登记号码
+ (BOOL)checkTabbarRegister
{
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSString *isHaveRun = [[NSUserDefaults standardUserDefaults] objectForKey:KHaveRegister];
    if (!isHaveRun || [isHaveRun isEqualToString:@"NO"]) {
        if (app.window.rootViewController.presentingViewController == nil) {
            //  跳转登记
            RegisterViewController *registerVc = [[RegisterViewController alloc] init];
            //            registerVC.typeStr = @"tabbar";
            UINavigationController *baseNav = [[UINavigationController alloc]initWithRootViewController:registerVc];
            [app.window.rootViewController presentViewController:baseNav animated:YES completion:^{
            }];
        }
        return NO;
    }else{
        return YES;
    }
}



@end
