//
//  define_font.h
//  FM820
//
//  Created by huangshengjie on 16/11/9.
//  Copyright © 2016年 Shirley. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface define_font : NSObject
#define TXT_SIZE_8  [UIFont systemFontOfSize:8]
#define TXT_SIZE_9  [UIFont systemFontOfSize:9]
#define TXT_SIZE_10 [UIFont systemFontOfSize:10]
#define TXT_SIZE_11 [UIFont systemFontOfSize:11]
#define TXT_SIZE_12 [UIFont systemFontOfSize:12]
#define TXT_SIZE_13 [UIFont systemFontOfSize:13]
#define TXT_SIZE_14 [UIFont systemFontOfSize:14]
#define TXT_SIZE_15 [UIFont systemFontOfSize:15]
#define TXT_SIZE_16 [UIFont systemFontOfSize:16]
#define TXT_SIZE_17 [UIFont systemFontOfSize:17]
#define TXT_SIZE_18 [UIFont systemFontOfSize:18]
#define TXT_SIZE_20 [UIFont systemFontOfSize:20]
#define TXT_SIZE_22 [UIFont systemFontOfSize:22]
#define TXT_SIZE_24 [UIFont systemFontOfSize:24]
#define TXT_SIZE_30 [UIFont systemFontOfSize:30]
#define TXT_SIZE_50 [UIFont systemFontOfSize:50]

/***********字体定义*************/

/*
 * 我的收藏页tableview的组标题
 */
#define FONT_COLLECTION_TITLE FONT_BY_PIXEL(20, 20 , 30)


/**
 * 通过不同机型的设计稿像素值获取系统字体
 *
 *  @param iPhone5  iPhone5机型
 *  @param iPhone6  iPhone6机型
 *  @param iPhone6p iPhone6P机型
 *
 */
#define FONT_BY_PIXEL(iPhone5, iPhone6, iPhone6p)\
(TARGET_IPHONE_6PLUS ? [UIFont systemFontOfSize:iPhone6p / 3] : (TARGET_IPHONE_6 ? [UIFont systemFontOfSize:iPhone6 / 2] : [UIFont systemFontOfSize:iPhone5 / 2]))

#define FONT_BOLD_BY_PIXEL(iPhone5, iPhone6, iPhone6p)\
(TARGET_IPHONE_6PLUS ? [UIFont boldSystemFontOfSize:iPhone6p / 3] : (TARGET_IPHONE_6 ? [UIFont boldSystemFontOfSize:iPhone6 / 2] : [UIFont boldSystemFontOfSize:iPhone5 / 2]))

/**
 * 通过不同机型的设计稿像素值获取系统字体
 *
 *  @param iPhone5  iPhone5机型
 *  @param iPhone6  iPhone6机型
 *  @param iPhone6p iPhone6P机型
 *  @param fontName 字体名
 *
 */
#define FONT_BY_PIXEL_FONTNAME(iPhone5, iPhone6, iPhone6p, fontName)\
(TARGET_IPHONE_6PLUS ? [UIFont fontWithName:fontName size:iPhone6p / 3] : (TARGET_IPHONE_6 ? [UIFont fontWithName:fontName size:iPhone6 / 2] : [UIFont fontWithName:fontName size:iPhone5 / 2]))
@end
