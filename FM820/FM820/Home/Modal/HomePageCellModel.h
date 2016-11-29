//
//  HomePageCellModel.h
//  FM820
//
//  Created by garfie on 16/10/25.
//  Copyright © 2016年 Shirley. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomePageCellModel : NSObject

+(HomePageCellModel *)HomePageCell;

@property (nonatomic,  strong) NSString *ID;
@property (nonatomic,  strong) NSString *title;
@property (nonatomic,  strong) NSString *descs;
@property (nonatomic,  strong) NSString *content;
@property (nonatomic,  strong) NSString *post;
@property (nonatomic,  strong) NSString *weekorder;
@property (nonatomic,  strong) NSString *dayorder;
@property (nonatomic,  strong) NSString *publishtime;
@property (nonatomic,  strong) NSString *block_id;
@property (nonatomic,  strong) NSString *block_name;
@property (nonatomic,  strong) NSString *readcount;
@property (nonatomic, strong) NSString *optionURL;
@end
