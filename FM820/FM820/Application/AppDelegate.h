//
//  AppDelegate.h
//  FM820
//
//  Created by 石芸蕾 on 16/9/29.
//  Copyright © 2016年 Shirley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

//调用登录
+ (BOOL)loginMain;

//检验是否登录
+ (BOOL)checkTabbarLogin;
//检验是否注册手机号
+ (BOOL)checkTabbarRegister;


@end

