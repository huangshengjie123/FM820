//
//  VersionCheck.h
//  FM820
//
//  Created by 石芸蕾 on 16/11/14.
//  Copyright © 2016年 Shirley. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VersionCheck : NSObject

@property (nonatomic,strong)NSString * AppStoreURL;
@property (nonatomic,strong)NSString * AvailableVersions;
@property (nonatomic,strong)NSString * ClientVersion;
@property (nonatomic,strong)NSString * Description;
@property (nonatomic,strong)NSString * DeviceID;
@property (nonatomic,strong)NSString * DeviceName;
@property (nonatomic,strong)NSString * Other1;
@property (nonatomic,strong)NSString * Other2;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
