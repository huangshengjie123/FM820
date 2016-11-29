//
//  ArtSearchModel.h
//  FM820
//
//  Created by huangshengjie on 16/11/15.
//  Copyright © 2016年 Shirley. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ArtSearchModel;

@interface OptionsModel : NSObject

@property (nonatomic,copy) NSString *option_id;         // 投票id
@property (nonatomic,copy) NSString *optionpost;        // 投票海报
@property (nonatomic,copy) NSString *optiontitle;       // 投票标题

@end

@interface CommentModel : NSObject

@property (nonatomic,copy) NSString *informations;  // 评论内容
@property (nonatomic,copy) NSString *avatar;        // 用户头像
//@property (nonatomic,strong) NSNumber *anonymous;  // 评论内容
//@property (nonatomic,copy) NSString *createtime;        // 用户头像
//@property (nonatomic,copy) NSString *nickname;  // 评论内容
//@property (nonatomic,strong) NSNumber *rank;        // 用户头像
//@property (nonatomic,strong) NSNumber *valid;  // 评论内容
//@property (nonatomic,strong) NSNumber *user_id;        // 用户头像
//@property (nonatomic,strong) NSNumber *id;        // 用户头像
@end

@interface ArtSearchModel : NSObject

@property (nonatomic,copy) NSString *block_id;
@property (nonatomic,copy) NSString *fm820vote_id;
@property (nonatomic,copy) NSString *vote_id;
@property (nonatomic,copy) NSString *block_name;
@property (nonatomic,strong) NSNumber *dayorder;
@property (nonatomic,copy) NSString *descs;
@property (nonatomic,copy) NSString *desc;
@property (nonatomic,copy) NSString *content;
@property (nonatomic,strong) NSNumber *isfavorite;
@property (nonatomic,strong) NSNumber *isread;
@property (nonatomic,copy) NSString *post;
@property (nonatomic,copy) NSString *publishtime;
@property (nonatomic,strong) NSArray <CommentModel *>*comments;
@property (nonatomic,strong) NSArray <CommentModel *>*options;
@property (nonatomic,strong) NSNumber *readcount;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,strong) NSNumber *weekorder;
@property (nonatomic,strong) NSNumber *id;
@end
/*
 article =         (
 {
 "block_id" = 1;
 "block_name" = "8\U70b920";
 dayorder = 1;
 descs = "\U53e4\U5239\U89c2\U97f3\U7985\U5bfa\U7edd\U7f8e\U5343\U5e74\U94f6\U674f\U3011\U89c2\U97f3\U7985\U5bfa\U4f4d\U4e8e\U897f\U5b89\U5e02\U957f\U5b89\U533a\U7ec8\U5357\U5c71\U5317\U9e93\U7684\U51e4\U51f0\U5cad\U4e0b\U3002\U59cb\U5efa\U4e8e\U5510\U8d1e\U89c2\U5e74\U95f4,\U5bfa\U5185\U4e00\U68f5\U5343\U5e74\U94f6\U674f\U6811,\U8471\U8471\U90c1\U90c1";
 id = 1;
 isfavorite = 0;
 isread = 1;
 post = "https://thumbnail0.baidupcs.com/thumbnail/48317d38a3eda6f8ae53a2e2ca0ab3f9?fid=3962560799-250528-141335571662930&time=1479175200&rt=sh&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-gNDl2GGqmdU9rJTKrno1wVepaJU%3D&expires=8h&chkv=0&chkbd=0&chkpc=&dp-logid=7408976134163774512&dp-callid=0&size=c1440_u900&quality=90";
 publishtime = "2016-11-07 11:00:21";
 readcount = 7;
 title = "IOS\U7ec8\U4e8e\U53ef\U4ee5\U9690\U85cf\U539f\U751f\U5e94\U7528\U4e86\Uff0c\U4f60\U6700\U60f3\U5e72\U6389\U7684\U662f\U54ea\U4e2a\Uff1f";
 weekorder = 1;
 },
 */
