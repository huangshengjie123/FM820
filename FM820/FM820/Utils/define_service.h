//
//  define_service.h
//  FM820
//
//  Created by huangshengjie on 16/11/9.
//  Copyright © 2016年 Shirley. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface define_service : NSObject

#define W(ww)  (ww*SCREEN_WIDTH/375)
#define H(ww)  (ww*SCREEN_WIDTH/375)

/**
 *  手机系统的版本
 */
#define SYSTEM_VERSION   [[UIDevice currentDevice] systemVersion]

/**
 *  app的主window
 */
#define APP_KEY_WINDOW   [[UIApplication sharedApplication] keyWindow]

/**
 *  app的delegate
 */
#define APP_DELEGATE     ((AppDelegate *)[[UIApplication sharedApplication] delegate])

/**
 *  系统版本是ios10
 */
#define TARGET_IOS10X     [[[UIDevice currentDevice] systemVersion] floatValue] >=10.0f
/**
 *  系统版本是ios9
 */
#define TARGET_IOS9X     [[[UIDevice currentDevice] systemVersion] floatValue] >=9.0f

/**
 *  系统版本是ios8
 */
#define TARGET_IOS8X     [[[UIDevice currentDevice] systemVersion] floatValue] >=8.0f

/**
 *  系统版本是ios7
 */
#define TARGET_IOS7X     [[[UIDevice currentDevice] systemVersion] floatValue] >=7.0f

/**
 *  设备是iPhone5
 */
#define TARGET_IPHONE_5   ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

/**
 *  设备是iPhone6.7
 */
#define TARGET_IPHONE_6   ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334),[[UIScreen mainScreen] currentMode].size) : NO)

/**
 *  设备是iPhone6P.7P
 */
#define TARGET_IPHONE_6PLUS    ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208),[[UIScreen mainScreen] currentMode].size) : NO)



@end
