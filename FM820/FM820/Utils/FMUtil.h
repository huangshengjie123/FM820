//
//  FMUtil.h
//  FM820
//
//  Created by 石芸蕾 on 16/10/16.
//  Copyright © 2016年 Shirley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FMUtil : NSObject

//创建UILabel
+ (UILabel *)createLabelFrame:(CGRect)frame title:(NSString *)title;

//创建UILabel-->对应于我的收藏页tableview的组头
+ (UILabel *)createLabelFrame:(CGRect)frame attributeString:(NSString *)titleString;

//创建UIButton
+ (UIButton *)createBtnFrame:(CGRect)frame title:(NSString *)title bgImage:(NSString *)bgImage target:(id)target action:(SEL)action;

//创建UIImageView
+ (UIImageView *)createImageViewFrame:(CGRect)frame imageName:(NSString *)imageName;


//添加导航标题
+ (UILabel *)addFMNavTitle:(NSString *)title;

//添加导航按钮
/*
 @return void
 @param title:按钮上面的文字
 @param isLeft:区分是左边还是右边的导航按钮
 @param target:响应点击事件的对象
 @param action:响应点击事件的方法
 */
+ (UIButton *)addFMNavBtn:(NSString *)title isLeft:(BOOL)isLeft target:(id)target action:(SEL)action bgImageName:(NSString *)bgImageName;

//返回按钮
+ (UIButton *)addNavBackButtonTarget:(id)target action:(SEL)action;


@end
