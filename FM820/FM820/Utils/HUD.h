//
//  HUD.h
//  zzz
//
//  Created by zym on 3/12/14.
//  Copyright (c) 2014 zym. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

@interface HUD : NSObject


+(MBProgressHUD *)showAlertWithTitle:(NSString *)title;

+(MBProgressHUD *)showAlertWithTitle:(NSString *)title
                            duration:(float)duration;

+(MBProgressHUD *)showAlertWithTitle:(NSString *)title
                              inView:(UIView *)inView;

+(MBProgressHUD *)showAlertWithTitle:(NSString *)title
                              inView:(UIView *)inView
                            duration:(float)duration;


+(void)hideMBIndicator;

@end
