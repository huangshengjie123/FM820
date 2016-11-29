//
//  AboutUsViewController.m
//  FM820
//
//  Created by 石芸蕾 on 16/11/9.
//  Copyright © 2016年 Shirley. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()<UIGestureRecognizerDelegate>

@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    //去除导航栏
    self.fd_prefersNavigationBarHidden = YES;
    
    //背景图片
    UIImageView *bgImageView = [FMUtil createImageViewFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) imageName:@"bg_aboutus"];
    [self.view addSubview:bgImageView];
    //返回
    //在左上角添加透明视图并加上点击手势
    UIView * leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50,50)];
    //默认情况 UIImageView\UILabel等无法响应用户交互，选解除限制
    leftView.userInteractionEnabled = YES;
    [self.view addSubview:leftView];
    //点击手势 轻按
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];
    tap.delegate = self;
    //将手势添加到View上
    [leftView addGestureRecognizer:tap];
}

- (void)tapGesture:(UITapGestureRecognizer*)tap{
    
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
