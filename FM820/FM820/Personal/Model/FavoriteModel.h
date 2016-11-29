//
//  ArticleModel.h
//  FM820
//
//  Created by 石芸蕾 on 16/11/1.
//  Copyright © 2016年 Shirley. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FavoriteModel;

/*
 数据外层
 */
@interface Fav_listModel : NSObject

@property (nonatomic, copy) NSString *date;                      // 阅读日期
@property (nonatomic, strong) NSArray<FavoriteModel *> *list;    // 阅读明细数组

@end
/*
 数据内层
 */
@interface FavoriteModel : NSObject

@property (nonatomic, copy) NSString *favorite_id;     //收藏记录id
@property (nonatomic, strong) NSNumber *dayorder;      //小图标颜色
@property (nonatomic, copy) NSString *block_name;
@property (nonatomic, copy) NSString *title;           // 阅读标题
@property (nonatomic, copy) NSString *posturl;         // 阅读图片链接
@property (nonatomic, strong) NSNumber *readcount;     // 阅读次数
@property (nonatomic, copy) NSString *createtime;      // 建立时间


@end
