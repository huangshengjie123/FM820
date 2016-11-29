//
//  SearchViewController.m
//  FM820
//
//  Created by 石芸蕾 on 16/10/16.
//  Copyright © 2016年 Shirley. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchModel.h"
#import "SearchCell.h"
#import "ArtSearchViewController.h"

@interface SearchViewController ()<UITableViewDelegate,
                                   UITableViewDataSource>
// 数据原数组
@property (nonatomic ,strong) NSMutableArray <SearchModel *>*dataArray;
// http管理对象
@property (nonatomic, strong) AFHTTPSessionManager *fmManager;
// 表格
@property (nonatomic, strong) UITableView *tableView;
// 刷新控件
@property (nonatomic,strong) UIRefreshControl *refresh;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    // 懒加载
    [self initArray];
    [self loadData];
    [self createTableView];
}

-(AFHTTPSessionManager *)fmManager {
    if (!_fmManager) {
        self.fmManager = [AFHTTPSessionManager manager];
    }
    return _fmManager;
}

-(void)initArray
{
    if (_dataArray == nil )
    {
        _dataArray = [[NSMutableArray alloc]init];
    }
}

-(void)createTableView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    //下拉刷新控件
    _refresh = [[UIRefreshControl alloc]init];
    _refresh.tintColor = [UIColor greenColor];
    [_refresh setAttributedTitle:[[NSAttributedString alloc]initWithString:DOWN_REFRESH]];
    [_refresh addTarget:self action:@selector(dataRefresh) forControlEvents:UIControlEventValueChanged];
    [_tableView addSubview:_refresh];
    
    [_refresh beginRefreshing];
    
}
- (void)dataRefresh
{
    [self loadData];
}
// 数据加载
-(void)loadData
{
    [self.fmManager.tasks makeObjectsPerformSelector:@selector(cancel)];
    [_fmManager POST:kFindUrl_list
          parameters:nil
            progress:^(NSProgress * _Nonnull uploadProgress) {
           } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
               if (_dataArray) {
               [_dataArray removeAllObjects];
           }
               NSLog(@"%@",responseObject);
               [SearchModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
                   return @{
                            @"pid" : @"id",
                            };
               }];
               _dataArray = [SearchModel mj_objectArrayWithKeyValuesArray:responseObject[@"msg"]];
               // 刷新UI
               [_tableView reloadData];
               [_refresh endRefreshing];
           } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
               NSLog(@"error%@",error);
              [_refresh endRefreshing];
           }];
}

#pragma mark UITableView 代理方法

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellId = @"SearchCell";
    SearchCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"SearchCell" owner:self options:nil]lastObject];
    }
    cell.searchModel = _dataArray[indexPath.section];
    
    return  cell;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SCREEN_WIDTH * 9/16 ;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.5f;
}

// 选中板块
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SearchModel * model = _dataArray[indexPath.section];
    ArtSearchViewController * artSearch = [[ArtSearchViewController alloc]init];
    artSearch.block_id = [model.pid stringValue];
    artSearch.postUrl = model.posturl;
    artSearch.name = model.name;
    if ([[model.pid stringValue] isEqualToString:@"8"])
    {
        artSearch.name = @"说点什么";
    }
    artSearch.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:artSearch animated:YES];
}
@end
