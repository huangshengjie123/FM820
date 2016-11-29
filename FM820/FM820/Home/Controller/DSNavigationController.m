//
//  DSNavigationController.m
//  FM820
//
//  Created by garfie on 16/11/9.
//  Copyright © 2016年 Shirley. All rights reserved.
//

#import "DSNavigationController.h"

@interface DSNavigationController ()

@end

@implementation DSNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.childViewControllers.count > 0) {
         viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

@end
