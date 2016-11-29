//
//  ArtSearchViewController.h
//  FM820
//
//  Created by huangshengjie on 16/11/15.
//  Copyright © 2016年 Shirley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArtSearchViewController : UIViewController

@property (nonatomic ,copy) NSString *block_id;   // 板块id
@property (nonatomic ,copy) NSString *postUrl;    // 表头图片
@property (nonatomic ,copy) NSString *name;       // 表头标题
@property (nonatomic ,copy) NSString *url;        // 链接
@end
