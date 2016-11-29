//
//  FMNetworking.h
//  FM820
//
//  Created by 石芸蕾 on 16/10/10.
//  Copyright © 2016年 Shirley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef enum{
    
    StatusUnknown           = -1, //未知网络
    StatusNotReachable      = 0,    //没有网络
    StatusReachableViaWWAN  = 1,    //手机自带网络
    StatusReachableViaWiFi  = 2     //wifi
    
}NetworkStatus;

@interface FMNetworking : NSObject

//返回值类型 (^) (参数类型)
//外漏方法 传入网址参数返回数据
//(void(^)(NSData *data,NSError *error))

//获取网络
@property (nonatomic,assign) NetworkStatus networkStatus;

//开启网络监测
+ (void)startMonitoring;

//get请求
+ (void)startRequestWithURL:(NSString *)url AndParameter:(NSDictionary *)parameter AndReturnBlock:(void(^)(NSData *data,NSError *error))resultBlock;

@end
