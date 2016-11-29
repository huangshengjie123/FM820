//
//  RegisterViewController.m
//  FM820
//
//  Created by 石芸蕾 on 16/10/19.
//  Copyright © 2016年 Shirley. All rights reserved.
//

#import "RegisterViewController.h"
#import "NSString+Adding.h"
#import "User.h"
#import "FMTabBarController.h"
#import "AppDelegate.h"
#import <SMS_SDK/SMSSDK.h>


@interface RegisterViewController ()<UITextFieldDelegate>

{
    int      seconds;
    NSTimer  *timer;
    BOOL isFalse;
}


@property (nonatomic,strong) UITextField *phoneNumber;
@property (nonatomic,strong) UITextField *verificationCode;
@property (nonatomic,strong) UIButton *sendBtn;
@property (nonatomic,strong) UIButton *bindBtn;

@property (nonatomic,strong)UIView *downView;
@property (nonatomic,strong)UILabel *showMsg;
@property (nonatomic,strong)UILabel *showCode;

@property (nonatomic,strong) User *user;
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    isFalse = YES;
    
    self.view.backgroundColor = VcBgColor;
    
    [self createUI];
    
    
}

- (void)createUI{
    //头像
    UIImageView *headImageView = [FMUtil createImageViewFrame:CGRectMake(137.5, 85, 100, 100) imageName:nil];
    [headImageView sd_setImageWithURL:[NSURL URLWithString:_avatar]];
    headImageView.backgroundColor = [UIColor blackColor];
    headImageView.layer.masksToBounds = YES;
    headImageView.layer.cornerRadius = headImageView.frame.size.width * 0.5;
    [self.view addSubview:headImageView];    
    //昵称
    NSString *str = [NSString stringWithFormat:@"%@  欢迎进入",_nickname];
    UILabel *nameLabel = [FMUtil createLabelFrame:CGRectMake(100, 205, 175, 40) title:str];
    nameLabel.font = TXT_SIZE_22;
    nameLabel.textColor = RegisterNameColor;
    nameLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:nameLabel];
    //输入手机号
    _phoneNumber = [[UITextField alloc] init];
    _phoneNumber.borderStyle = UITextBorderStyleRoundedRect;
    _phoneNumber.placeholder = @"手机号";
    [_phoneNumber addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:_phoneNumber];
    
    //手机号错误提示
    _showMsg = [UILabel new];
    _showMsg.textColor = [UIColor redColor];
    _showMsg.font = TXT_SIZE_13;
    _showMsg.text = @"请输入正确的手机号！";
    [self.view addSubview:_showMsg];
    [_showMsg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_phoneNumber.mas_bottom).offset(10);
        make.left.right.equalTo(_phoneNumber);
        make.height.mas_equalTo(10);
    }];
    
    //下滑view
    _downView = [[UIView alloc] init];
//    downView.backgroundColor = [UIColor redColor];
//    downView.alpha = 0.8;
    [self.view addSubview:_downView];
    //输入验证码
    _verificationCode = [[UITextField alloc]init];
    _verificationCode.borderStyle = UITextBorderStyleRoundedRect;
    _verificationCode.placeholder = @"验证码";
    [_downView addSubview:_verificationCode];
    
    //验证码错误提示
    _showCode = [UILabel new];
    _showCode.textColor = [UIColor redColor];
    _showCode.font = TXT_SIZE_12;
    _showCode.text = @"请输入正确的验证码";
    [self.view addSubview:_showCode];
    [_showCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_verificationCode.mas_bottom).offset(10);
        make.left.right.equalTo(_verificationCode);
        make.height.mas_equalTo(10);
    }];
    
    //获取验证码
    _sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _sendBtn.backgroundColor = [UIColor whiteColor];
    _sendBtn.layer.masksToBounds = YES;
    _sendBtn.layer.cornerRadius = 4;
    _sendBtn.enabled = YES;
    _sendBtn.layer.borderWidth = 0.1;
    [_sendBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    _sendBtn.titleLabel.font = TXT_SIZE_15;
    [_sendBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_sendBtn addTarget:self action:@selector(sendVerificationCode) forControlEvents:UIControlEventTouchUpInside];
    [_downView addSubview:_sendBtn];
    //绑定
    _bindBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _bindBtn.backgroundColor = RegisterBtnColor;
    [_bindBtn setTitle:@"绑定" forState:UIControlStateNormal];
    _bindBtn.layer.masksToBounds = YES;
    _bindBtn.layer.cornerRadius = 4;
    _bindBtn.titleLabel.font = TXT_SIZE_15;
    [_bindBtn addTarget:self action:@selector(bind) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_bindBtn];
    
    [headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(85);
        make.width.equalTo(@100);
        make.height.equalTo(@100);
    }];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(headImageView.mas_bottom).offset(18);
        make.width.equalTo(@300);
    }];
    [_phoneNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(nameLabel.mas_bottom).offset(30);
        make.width.equalTo(@305);
        make.height.equalTo(@40);
    }];
    [_downView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(0);
        make.top.equalTo(_phoneNumber.mas_bottom).offset(10);
        make.width.equalTo(self.view.mas_width);
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
    }];
    [_verificationCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_phoneNumber.mas_left).offset(0);
        make.top.equalTo(_downView.mas_top).offset(0);
        make.right.equalTo(_sendBtn.mas_left).offset(-10);
        make.height.equalTo(@40);
    }];
    [_sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_phoneNumber.mas_right).offset(0);
        make.top.equalTo(_downView.mas_top).offset(0);
        make.width.equalTo(@110);
        make.height.equalTo(@40);
    }];
    [_bindBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_phoneNumber.mas_left).offset(0);
        make.right.equalTo(_phoneNumber.mas_right).offset(0);
        make.top.equalTo(_sendBtn.mas_bottom).offset(35);
        make.height.equalTo(@40);
    }];


    _showMsg.hidden = YES;
    _showCode.hidden = YES;
    
}

- (void)textFieldDidChange{
    _sendBtn.enabled = YES;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_phoneNumber resignFirstResponder];
    [_verificationCode resignFirstResponder];
    
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [_phoneNumber becomeFirstResponder];
    [_verificationCode resignFirstResponder];
    if (_phoneNumber.text.length == 0) {
        _sendBtn.enabled = NO;
    }
}

//点击获取验证码
- (void)sendVerificationCode{
    
    if ([NSString isMobile:_phoneNumber.text]) {
        //倒计时
        seconds = 60;
        NSDictionary *userinfo = @{@"button":_sendBtn};
        timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDiscrease:) userInfo:userinfo repeats:YES];
        
        _sendBtn.enabled = NO;
        _sendBtn.selected = YES;
        
        [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:_phoneNumber.text
                                       zone:@"86"
                           customIdentifier:nil
                                     result:^(NSError *error){
                                         if (!error) {
                                             NSLog(@"获取验证码成功");
                                         } else {
                                             NSLog(@"错误信息：%@",error);
                                         } }];

    }else{
        
        if (isFalse) {
            _downView.frame  = CGRectMake(_downView.frame.origin.x, _downView.frame.origin.y+20, _downView.frame.size.width, _downView.frame.size.height);
            _sendBtn.enabled = NO;
            self.showMsg.hidden = NO;
        }
    
    }
    
}
/**
 *  倒计时
 *
 *  @param btn
 */
- (void)countDiscrease:(UIButton*)btn
{
    UIButton *button = (UIButton *)(timer.userInfo[@"button"]);
    if(seconds == 0)
    {
        [timer invalidate];
//        button.backgroundColor  = [UIColor colorForHex:@"AA904C"];
        [button setTitle:@"获取验证码" forState:UIControlStateNormal];
        button.enabled = YES;
        //[timer invalidate];
    }
    else
    {
        seconds--;
        button.enabled = NO;
//        button.backgroundColor  = [UIColor colorForHex:@"E5E5E5"];
        [button setTitle:[NSString stringWithFormat:@"重新获取:%ds", seconds] forState:UIControlStateNormal];
    }
}


//点击绑定
- (void)bind{
    [SMSSDK commitVerificationCode:self.verificationCode.text phoneNumber:self.phoneNumber.text zone:@"86" result:^(SMSSDKUserInfo *userInfo, NSError *error) {
        
        {
            if (!error)
            {
                
                NSLog(@"验证成功");
                
                AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                manager.responseSerializer = [AFHTTPResponseSerializer serializer];
                manager.responseSerializer = [AFJSONResponseSerializer serializer];
                
                NSDictionary *para = @{@"wechat":_wechat,@"nickname":_nickname,@"avatar":_avatar,@"phonenumber":_phoneNumber.text};
                [manager POST:@"http://120.26.112.49:8000/baseuser/bind" parameters:para progress:^(NSProgress * _Nonnull uploadProgress) {
                    
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    
                    [[User shareUser] deleteUser];
                    _user = [User shareUser];
                    
                    _user.userName = _nickname;
                    _user.userHeadImgUrl = _avatar;
                    _user.phoneNum = self.phoneNumber.text;
                    _user.userId = [[responseObject objectForKey:@"msg"] objectForKey:@"user_id"];
                    _user.sid = [[responseObject objectForKey:@"msg"] objectForKey:@"sid"];
                    [[User shareUser] saveLogin];
                    [[User shareUser] saveUser];
                    [self gotoMe];
                    
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    
                }];

            }
            else
            {
               
                NSLog(@"错误信息:%@",error);
                
                [HUD showAlertWithTitle:@"验证码不正确"];
                
            }
        }
    }];
    
    
}

- (void)gotoMe{
    
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
    [AppDelegate loginMain];
    
}

- (void)hideKeyBorder{
    
    //点击屏幕任意位置取消键盘
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPressed)];
    [self.view addGestureRecognizer:tapGesture];
    tapGesture.cancelsTouchesInView = NO;
    
    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
}
-(void)tapPressed
{
    [self.view endEditing:YES];
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
