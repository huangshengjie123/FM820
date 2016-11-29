//
//  define_color.h
//  FM820
//
//  Created by huangshengjie on 16/11/9.
//  Copyright © 2016年 Shirley. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface define_color : NSObject
// rgb颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

// 获取RGB颜色
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

#define RGB(r,g,b) RGBA(r,g,b,1.0f)

//tabbar字体颜色
#define TabBarTextColor UIColorFromRGB(0x6889AA)

//导航栏标题颜色
#define NavTitleColor UIColorFromRGB(0x333333)

#define VcBgColor UIColorFromRGB(0xf5f8f9)

//registerVc
#define RegisterNameColor UIColorFromRGB(0x6788A8)

#define RegisterBtnColor UIColorFromRGB(0x92a9c0)

//favoriteCell
#define CellLineColor UIColorFromRGB(0xe5e5e5)

#define CellTextColor UIColorFromRGB(0x90A7BE)

//设置页面
#define SwitchColor UIColorFromRGB(0x6788A8)


@end
