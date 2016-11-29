//
//  User.m
//  FM820
//
//  Created by 石芸蕾 on 16/10/18.
//  Copyright © 2016年 Shirley. All rights reserved.
//

#import "User.h"

@implementation User

static User *instance = nil;

MJCodingImplementation

+ (User *)shareUser
{
    if (!instance)
    {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            instance = [[super allocWithZone:NULL] init];
            
        });
    }
    
    return instance;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [self shareUser];
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

- (id)init {
    if (instance) {
        return instance;
    }
    self = [super init];
    return self;
}



- (void)saveUser
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self];
    [userDefaults setObject:data forKey:@"user"];
    [userDefaults synchronize];
}

- (void)deleteUser
{
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"user"];
    [userDefaults synchronize];
    
}



+ (instancetype)userFromFile
{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [userDefaults objectForKey:@"user"];
    
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}
- (void)saveLogin
{
    [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:KHaveLogin];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (void)saveExit
{
    [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:KHaveLogin];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end
