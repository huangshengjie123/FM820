//
//  VersionCheck.m
//  FM820
//
//  Created by 石芸蕾 on 16/11/14.
//  Copyright © 2016年 Shirley. All rights reserved.
//

#import "VersionCheck.h"

@implementation VersionCheck

- (instancetype)initWithDic:(NSDictionary *)dic{
    
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{}


@end
