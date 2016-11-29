//
//  HomePageCellModel.m
//  FM820
//
//  Created by garfie on 16/10/25.
//  Copyright © 2016年 Shirley. All rights reserved.
//

#import "HomePageCellModel.h"

@implementation HomePageCellModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {

    if ([key isEqualToString:@"id"]) {
        _ID = value;
    }
}

static HomePageCellModel *homePageCellModel;
+(HomePageCellModel *)HomePageCell {

    if (homePageCellModel == nil) {
        homePageCellModel = [[self alloc] init];
    }
    return homePageCellModel;
}

@end
