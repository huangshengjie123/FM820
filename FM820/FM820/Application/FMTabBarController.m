  //
//  FMTabBarController.m
//  FM820
//
//  Created by 石芸蕾 on 16/10/12.
//  Copyright © 2016年 Shirley. All rights reserved.
//

#import "FMTabBarController.h"

#import "HomeViewController.h"
#import "SearchViewController.h"
#import "EducationViewController.h"
#import "PersonalViewController.h"
#import "DSNavigationController.h"
#import "AppDelegate.h"

@interface FMTabBarController ()

@end

@implementation FMTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //创建标签栏控制器
    [self createControllers];
    self.selectedIndex = 1;
    
    //设置tabbar背景图片
    [self setupTabBar];
    
    //设置底部的tabBarItem的样式
    [self setupTabBarItemStyle];
}

#pragma mark 创建标签栏控制器
- (void)createControllers{
    
    HomeViewController *homeVc = [[HomeViewController alloc] init];
    SearchViewController *searchVc = [[SearchViewController alloc] init];
    EducationViewController *educationVc = [[EducationViewController alloc] init];
    PersonalViewController *personalVc = [[PersonalViewController alloc] init];
    
    //将视图控制器放置到可变数组中
    NSMutableArray *array = [NSMutableArray arrayWithObjects:homeVc,searchVc,educationVc,personalVc, nil];
    //标题
    NSArray *titleArr = @[@"首页",@"发现",@"教育节",@"我"];
    //图片
    NSArray *normalArr = @[@"tab_btn_home_normal",@"tab_btn_search_normal",@"tab_btn_820_normal",@"tab_btn_me_normal"];
    
    NSArray *selectedArr = @[@"tab_btn_home_hover",@"tab_btn_search_hover",@"tab_btn_820_hover",@"tab_btn_me_hover"];
    
    //循环创建
    for (int i = 0; i < titleArr.count; i++) {
        //1、依次得到每个视图控制器
        UIViewController *vc = array[i];
        //2、视图控制器－》导航控制器
        DSNavigationController *nav = [[DSNavigationController alloc]initWithRootViewController:vc];
        //数组替换操作 nav替换掉原有vc
        [array replaceObjectAtIndex:i withObject:nav];
        //3、标题
        vc.title = titleArr[i];
//        4、图片
        //渲染模式 保证显示图片与给定图片保持一致
        UIImage *normalImage = [UIImage imageNamed:normalArr[i]];
        UIImage *selectImage = [UIImage imageNamed:selectedArr[i]];
        //普通状态
        vc.tabBarItem.image = [normalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        //选中
        vc.tabBarItem.selectedImage = [selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    
    self.viewControllers = array;
    
    self.delegate = self;
    
}

#pragma mark - 设置tabbar背景图片
- (void)setupTabBar{
    
    //给tabbar设置背景图片
    [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"tabbar_bg"]];
    
    [UITabBar appearance].translucent = NO;
}

#pragma mark - 设置底部的tabBarItem的样式
- (void)setupTabBarItemStyle
{
    // 获取所有的TabBarItem
    UITabBarItem *tabBarItem = [UITabBarItem appearance];
    
    // 设置正在状态和选择中状态下的 文字的颜色 和大下
    
    // 正常状态下
    NSMutableDictionary *attr1 = [NSMutableDictionary dictionary];
    // 字体的大小
    attr1[NSFontAttributeName] = TXT_SIZE_10;
    // 字体的颜色
    //attr1[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    
    [tabBarItem setTitleTextAttributes:attr1 forState:UIControlStateNormal];
    
    // 选中状态下
    NSMutableDictionary *attr2 = [NSMutableDictionary dictionary];
    attr2[NSForegroundColorAttributeName] = TabBarTextColor;
    [tabBarItem setTitleTextAttributes:attr2 forState:UIControlStateSelected];
    
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    
//    if (tabBarController.selectedIndex == 3) {
//        if (![AppDelegate checkTabbarLogin]) {
//            
//            tabBarController.selectedIndex = 0;
//            
//        }
//    
////        if (![AppDelegate checkTabbarRegister]) {
////            
////            
////        }
//    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
