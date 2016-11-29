//
//  FavoriteViewController.h
//  FM820
//
//  Created by 石芸蕾 on 16/11/1.
//  Copyright © 2016年 Shirley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FavoriteViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

{
    NSMutableDictionary *dataDic;
    UIButton *deletebtn;
    UIButton *addbtn;
}

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,strong) NSMutableArray *dataArray;

//存储文章的大数组
@property (nonatomic,strong) NSMutableArray *articleArr;
//存储标题数组
@property (nonatomic,strong) NSMutableArray *titleArr;

@property (nonatomic,copy) NSString *url;

- (void)loadData;

@end
