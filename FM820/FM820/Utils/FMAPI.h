//
//  FMAPI.h
//  FM820
//
//  Created by 石芸蕾 on 16/10/12.
//  Copyright © 2016年 Shirley. All rights reserved.
//

#ifndef FMAPI_h
#define FMAPI_h

#define FIRSTURLADDRESS http://120.26.112.49:8000
#define GETARTITLEURL http://120.26.112.49:8000/content/list

// 收藏页面
#define kFavoriteUrl_list @"http://120.26.112.49:8000/favorite/list"
// 查询文章界面
#define kArticleSearchUrl_list @"http://120.26.112.49:8000/content/listbyblock"
// 分页查询投票信息列表接口
#define kFm820VoteUrl_list @"http://120.26.112.49:8000/fm820vote/list"
// 根据id查询投票接
#define kVoteQueryUrl_list @"http://120.26.112.49:8001/vote/query"
// 发现界面
#define kFindUrl_list @"http://120.26.112.49:8000/block/list"

// 批量删除收藏接口
#define kFavoriteUrl_deleteall @"http://120.26.112.49:8000/favorite/deleteall"

// 添加收藏接口
#define kFavoriteUrl_add @"http://120.26.112.49:8000/favorite/add"
#endif /* FMAPI_h */
