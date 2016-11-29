//
//  FMNetworking.m
//  FM820
//
//  Created by 石芸蕾 on 16/10/10.
//  Copyright © 2016年 Shirley. All rights reserved.
//

#import "FMNetworking.h"


@implementation FMNetworking

+ (void)startRequestWithURL:(NSString *)url AndParameter:(NSDictionary *)parameter AndReturnBlock:(void (^)(NSData *, NSError *))resultBlock{
    //执行网络请求
    //GET
    //请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //设置默认返回类型(NSData)
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //调用get请求
    [manager GET:url parameters:parameter progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //成功
        resultBlock(responseObject,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //失败
        resultBlock(nil,error);
    }];
   
}

#pragma makr - 开始监听网络连接

+ (void)startMonitoring
{
    // 1.获得网络监控的管理者
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    // 2.设置网络状态改变后的处理
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 当网络状态改变了, 就会调用这个block
        switch (status)
        {
            case AFNetworkReachabilityStatusUnknown: // 未知网络
                NSLog(@"未知网络");
                break;
            case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
                NSLog(@"没有网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
                NSLog(@"手机自带网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
                
                NSLog(@"WIFI");
                break;
        }
    }];
    [mgr startMonitoring];
}


@end
