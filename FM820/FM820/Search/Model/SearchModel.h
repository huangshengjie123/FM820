//
//  SearchModel.h
//  FM820
//
//  Created by huangshengjie on 16/11/14.
//  Copyright © 2016年 Shirley. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchModel : NSObject

@property (nonatomic ,copy) NSString * desc;
@property (nonatomic ,copy) NSString * posturl;
@property (nonatomic ,copy) NSString * iconurl;
@property (nonatomic ,copy) NSString * name;
@property (nonatomic ,strong) NSNumber * pid;
@property (nonatomic ,strong) NSNumber * order;

@end
