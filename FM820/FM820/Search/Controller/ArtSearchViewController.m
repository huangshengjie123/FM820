//
//  ArtSearchViewController.m
//  FM820
//
//  Created by huangshengjie on 16/11/15.
//  Copyright © 2016年 Shirley. All rights reserved.
//

#import "ArtSearchViewController.h"
#import "ArtSearchCell.h"
#import "ArtSearchModel.h"
#import "SaySomethingCell.h"

#define one                          @"0"   // 用来判断投票还是吐槽，
#define eight                        @"8"
#define nine                         @"9"

@interface ArtSearchViewController ()<UITableViewDelegate,
                                      UITableViewDataSource>

// 数据原数组
@property (nonatomic ,strong) NSMutableArray <ArtSearchModel*>*dataArray;
// 临时数组
@property (nonatomic ,strong) NSMutableArray *tempArray;
// http管理对象
@property (nonatomic, strong) AFHTTPSessionManager *fmManager;
// 表格
@property (nonatomic, strong) UITableView *tableView;
// 刷新控件
@property (nonatomic,strong) UIRefreshControl *refresh;
// 存储投票id值
@property (nonatomic,strong) NSString *idString;
@end

@implementation ArtSearchViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    // 设置导航栏背景图片
    /*
     1、图片信息[[UIImage alloc]init]表示透明图片
     2、设备朝向
     */
    [self.navigationController.navigationBar setBackgroundImage:[UIImage alloc] forBarMetrics:UIBarMetricsDefault];
    // 去除阴影线
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc]init]];
    // 设置导航栏文字渲染色
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];

}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //重置导航栏图片
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setShadowImage:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = VcBgColor;
    [self initArray];
    [self createTableView];
    [self loadData];
    // 创建表头视图
    [self createHeadView];
    
}

-(void)initArray
{
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    if (_tempArray == nil) {
        _tempArray = [[NSMutableArray alloc]init];
    }

}

-(NSString *)url
{
    
    if (_idString.length == 1)
    {
        return kFm820VoteUrl_list;
    }
    else if (_idString.length > 1)
    {
        return kVoteQueryUrl_list;
    }
    else
    {
        return kArticleSearchUrl_list;
 
    }
}
-(AFHTTPSessionManager *)fmManager {
    if (!_fmManager) {
        self.fmManager = [AFHTTPSessionManager manager];
    }
    return _fmManager;
}

-(void)createTableView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // 行高自定义
    self.tableView.estimatedRowHeight = 300.0f;
    self.tableView.backgroundColor = VcBgColor;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.view addSubview:self.tableView];
    
    _refresh = [[UIRefreshControl alloc]init];
    _refresh.tintColor = [UIColor greenColor];
    [_refresh setAttributedTitle:[[NSAttributedString alloc]initWithString:DOWN_REFRESH]];
    [_refresh addTarget:self action:@selector(dataRefresh) forControlEvents:UIControlEventValueChanged];
    [_tableView addSubview:_refresh];
    [_refresh beginRefreshing];
}

-(void)createHeadView
{
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*9/16)];
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.postUrl] placeholderImage:nil];
    UIView * view = [[UIView alloc]initWithFrame:imageView.bounds];
    view.backgroundColor = UIColorFromRGB(0x000000);
    view.alpha = 0.6f;
    [imageView addSubview:view];
    UILabel * headLabel = [[UILabel alloc]init];
    [imageView addSubview:headLabel];
    [headLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imageView.mas_left).offset(10);
        make.right.equalTo(imageView.mas_right).offset(-10);
        make.centerY.equalTo(imageView.mas_centerY);
        make.height.equalTo(@30);
    }];
    headLabel.font = TXT_SIZE_24;
    headLabel.text = self.name;
    headLabel.textAlignment = NSTextAlignmentCenter;
    headLabel.textColor = UIColorFromRGB(0xffffff);
    self.tableView.tableHeaderView = imageView;

}


-(void)loadData
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"user_id"] = @"1";
    dic[@"sid"] = @"1";
    dic[@"block_id"] = self.block_id;
    dic[@"skip"] = @"0";
    dic[@"limit"] = @"10";
    if ([self.block_id isEqualToString:eight] && _idString.length < 1)
    {
        dic[@"block_id"] = nine;
        self.block_id = nine;
    }
    // 如果是投票，先获取vote_id,再另外掉接口
    if (_idString.length > 1)
    {
        [dic removeAllObjects];
        dic[@"vote_id"] = _idString;
        self.block_id = one;
    }
    // 弱引用
    WS(weakSelf)
    [self.fmManager.tasks makeObjectsPerformSelector:@selector(cancel)];
    [_fmManager POST:self.url
          parameters:dic
            progress:^(NSProgress * _Nonnull uploadProgress) {
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (_dataArray && _idString.length < 1) {
                    [_dataArray removeAllObjects];
                }
                // 投票
                if ([self.block_id isEqualToString:eight])
                {
                    for (NSDictionary * dic in responseObject[@"msg"][@"fm820vote"]) {
                        _idString = dic[@"vote_id"];
                    }
                    
                    [weakSelf loadData];
                    
                }
                // 吐槽
                else if ([self.block_id isEqualToString:nine])
                {
                    _dataArray = [ArtSearchModel mj_objectArrayWithKeyValuesArray:responseObject[@"msg"][@"article"]];
                    _idString = one;
                    weakSelf.block_id = eight;
                    [weakSelf loadData];
                }
                // 一般文章
                else
                {
                    if (_idString.length > 1)
                    {
                        _tempArray = [ArtSearchModel mj_objectArrayWithKeyValuesArray:responseObject[@"msg"]];
                        [_dataArray addObjectsFromArray:_tempArray];
                    }
                    else
                    {

                        _dataArray = [ArtSearchModel mj_objectArrayWithKeyValuesArray:responseObject[@"msg"][@"article"]];
                    }

                }

                // 刷新UI
                [_tableView reloadData];
                [_refresh endRefreshing];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"error%@",error);
                [_refresh endRefreshing];
            }];
}

- (void)dataRefresh
{
    [self loadData];
}

#pragma mark UITableView 代理方法

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.block_id isEqualToString:eight] || [self.block_id isEqualToString:nine] || [self.block_id isEqualToString:one])
    {
        SaySomethingCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SaySomethingCell class])];
        if (!cell)
        {
            cell = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([SaySomethingCell class]) owner:self options:nil]lastObject];
        }
        cell.backgroundColor = VcBgColor;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.artSearchModel = _dataArray[indexPath.section];
        return  cell;
    }
    else
    {
        ArtSearchCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ArtSearchCell class])];
        if (!cell)
        {
            cell = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([ArtSearchCell class]) owner:self options:nil]lastObject];
        }
        cell.backgroundColor = VcBgColor;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.artSearchModel = _dataArray[indexPath.section];
        return  cell;
    }

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArray.count;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.0f;
}

@end
