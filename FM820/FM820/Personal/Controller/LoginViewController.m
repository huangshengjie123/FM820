//
//  LoginViewController.m
//  FM820
//
//  Created by 石芸蕾 on 16/10/18.
//  Copyright © 2016年 Shirley. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "User.h"
#import "AppDelegate.h"
#import <UMSocialCore/UMSocialCore.h>

@interface LoginViewController ()<UIGestureRecognizerDelegate>

@property (nonatomic,copy) NSString *uid;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *icon;
@property (nonatomic,strong) User *user;

@property (nonatomic,strong) NSString *wechat;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createUI];
    
}

#pragma mark -UI搭建
- (void)createUI{
    
    //添加背景图片
    UIImageView *bgImageView = [FMUtil createImageViewFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) imageName:@"login_bg"];
    [self.view addSubview:bgImageView];
    
    
    //在中心添加透明视图并加上点击手势
    UIView * myView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 120, 120)];
    //    myView.alpha = 0.8;
    //默认情况 UIImageView\UILabel等无法响应用户交互，选解除限制
    myView.userInteractionEnabled = YES;
    //放在屏幕中间
    myView.center = self.view.center;
    //    myView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:myView];
    //点击手势 轻按
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];
    tap.delegate = self;
    //将手势添加到View上
    [myView addGestureRecognizer:tap];
    
}

- (void)tapGesture:(UITapGestureRecognizer*)tap{
    NSLog(@"触发点击");
    
    
    [[UMSocialManager defaultManager]  authWithPlatform:UMSocialPlatformType_WechatSession currentViewController:self completion:^(id result, NSError *error) {
        //        [self.tableView reloadData];
        UMSocialAuthResponse *authresponse = result;
        
        //        NSString *message = [NSString stringWithFormat:@"result: %d\n uid: %@\n accessToken: %@\n",(int)error.code,authresponse.uid,authresponse.accessToken];
        
        _uid = authresponse.uid;
        
        [self getUserInfoForPlatform: UMSocialPlatformType_WechatSession andwechat:authresponse.uid];
        //        [alert show];
    }];
        
    
}

//获取用户信息
- (void)getUserInfoForPlatform:(UMSocialPlatformType)platformType andwechat:(NSString *)str
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_WechatSession  currentViewController:self completion:^(id result, NSError *error) {
        UMSocialUserInfoResponse *userinfo =result;
        //        NSString *message = [NSString stringWithFormat:@"name: %@\n icon: %@\n gender: %@\n",userinfo.name,userinfo.iconurl,userinfo.gender];
        
        _name = userinfo.name;
        _icon = userinfo.iconurl;
        
        NSDictionary *para = @{@"wechat":str,@"nickname":userinfo.name,@"avatar":userinfo.iconurl};
        [manager POST:@"http://120.26.112.49:8000/baseuser/login" parameters:para progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"成功");
            
            NSLog(@"%ld",[[responseObject objectForKey:@"errno"] integerValue]);
            
            if ([[responseObject objectForKey:@"errno"] integerValue]== 0) {
                _wechat = [[responseObject objectForKey:@"msg"] objectForKey:@"wechat"];
                [self autoLogin];
                
            }else if([[responseObject objectForKey:@"errno"] integerValue] == 1002){
                [self goRegister];
            }
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
        
    }];
    
    
}

#pragma mark -- 手机已经绑定,自动登录
- (void)autoLogin{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager POST:@"http://120.26.112.49:8000/baseuser/autologin" parameters:@{@"wechat":_uid} progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"成功");
        
        _user = [User shareUser];
        _user.userName = [[responseObject objectForKey:@"msg"] objectForKey:@"nickname"];;
        _user.userHeadImgUrl = [[responseObject objectForKey:@"msg"] objectForKey:@"avatar"];;
        _user.phoneNum = [[responseObject objectForKey:@"msg"] objectForKey:@"phonenumber"];;
        _user.userId = [[responseObject objectForKey:@"msg"] objectForKey:@"user_id"];
        _user.sid = [[responseObject objectForKey:@"msg"] objectForKey:@"sid"];
        
        
        [[User shareUser] saveLogin];
        [[User shareUser] saveUser];
        [self gotoMe];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)gotoMe{
    
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
//    [AppDelegate loginMain];
    
}

#pragma mark -- 去注册,添加手机号
- (void)goRegister{
    
    RegisterViewController *registerVc = [[RegisterViewController alloc] init];
    registerVc.wechat = _uid;
    registerVc.nickname = _name;
    registerVc.avatar = _icon;
    [self.navigationController pushViewController:registerVc animated:YES];
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
