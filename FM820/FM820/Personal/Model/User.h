//
//  User.h
//  FM820
//
//  Created by 石芸蕾 on 16/10/18.
//  Copyright © 2016年 Shirley. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (strong,nonatomic) NSString *userName;
@property (strong,nonatomic) NSString *userHeadImgUrl;
@property (strong,nonatomic) NSString *phoneNum;
@property (strong,nonatomic) NSString *userId;
@property (strong,nonatomic) NSString *sid;


//声明一个单例类
+ (User *)shareUser;

-(void)saveUser;
-(void)deleteUser;

+ (instancetype)userFromFile;

//记录登录状态
- (void)saveLogin;
//记录退出状态
- (void)saveExit;

@end
