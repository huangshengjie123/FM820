//
//  HelpViewController.m
//  FM820
//
//  Created by 石芸蕾 on 16/11/9.
//  Copyright © 2016年 Shirley. All rights reserved.
//

#import "HelpViewController.h"

@interface HelpViewController ()

@end

@implementation HelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = VcBgColor;
    
    [self createMyNav];
}

#pragma mark -导航条样式设置
- (void)createMyNav{
    
    UILabel *titleLabel = [FMUtil addFMNavTitle:@"帮助与反馈"];
    self.navigationItem.titleView = titleLabel;
    UIButton *leftBtn = [FMUtil addFMNavBtn:nil isLeft:YES target:self action:@selector(backAction) bgImageName:@"icon_nav_back"];
    leftBtn.frame = CGRectMake(0, 0, 12, 19);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    
}

- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
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
