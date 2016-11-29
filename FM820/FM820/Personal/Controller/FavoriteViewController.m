//
//  FavoriteViewController.m
//  FM820
//
//  Created by 石芸蕾 on 16/11/1.
//  Copyright © 2016年 Shirley. All rights reserved.
//

#import "FavoriteViewController.h"
#import "User.h"
#import "FavoriteModel.h"
#import "FavoriteTableViewCell.h"

@interface FavoriteViewController ()

@property (nonatomic, strong) User *user;

@property (nonatomic,strong) UIRefreshControl *refresh;

@property (nonatomic, strong) AFHTTPSessionManager *fmManager;

@property (nonatomic, strong) UIView *toolBarView;

@end

@implementation FavoriteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = VcBgColor;
    
    [self createMyNav];
    //初始化
    [self initData];
    //创建列表
    [self createTableView];
    //加载数据
    [self loadData];
    //创建底部自定义toolBar
    [self createToolBarView];
    
    
}

//初始化
- (void)initData{
    
    dataDic = [[NSMutableDictionary alloc]init];
    
    _articleArr = [[NSMutableArray alloc]init];
    
    _titleArr = [[NSMutableArray alloc]init];
    
    _dataArr = [[NSMutableArray alloc]init];
}

- (void)loadData{
    
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    self.user = [User shareUser];
    //    dic[@"user_id"] = self.user.userId;
    //    dic[@"sid"] = self.user.sid;
    dic[@"user_id"] = @"1";
    dic[@"sid"] = @"1";
    dic[@"skip"] = @"0";
    dic[@"limit"] = @"10";
    self.url = kFavoriteUrl_list;
    [_fmManager POST:self.url
          parameters:dic
            progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         if (_dataArr.count) {
             [_dataArr removeAllObjects];
         }
         // 解析数据
         NSArray *favArr =  [responseObject[@"msg"][@"favorites"] mutableCopy];
         // 没有收藏文章时，显示空白页
         if (favArr.count == 0) {
             UIImageView *bgImageView = [FMUtil createImageViewFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) imageName:@"collection_white"];
             [self.view addSubview:bgImageView];
             return ;
         }
         for (NSDictionary * dic in favArr)
         {
             NSMutableArray * array = [[NSMutableArray alloc]init];
             array = [FavoriteModel mj_objectArrayWithKeyValuesArray:dic[@"list"]];
             [_titleArr addObject:dic[@"date"]];
             [_dataArr addObject:array];
         }

         // 刷新UI
         [_tableView reloadData];
         [_refresh endRefreshing];
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         NSLog(@"失败！！！");
         NSLog(@"%@",error);
     }];
    
}

//-(void)dea:(NSMutableArray *)dataArray
//{
//
//    NSMutableArray *array = [NSMutableArray arrayWithArray:dataArray];
//    _dataArray = [[NSMutableArray alloc]init];
//    for (int i = 0; i < array.count; i ++) {
//        FavoriteModel * model = array[i];
//        NSString *string = model.createtime;
//        NSString * dataStr = [[string componentsSeparatedByString:@" "]firstObject];
//
//        NSMutableArray *tempArray = [[NSMutableArray alloc]init];
//        [tempArray addObject:model];
//        for (int j = i+1; j < array.count; j ++)
//        {
//            FavoriteModel * model = array[j];
//            NSString *jstring = model.createtime;
//            NSString * jsStr = [[jstring componentsSeparatedByString:@" "]firstObject];
//            if([jsStr isEqualToString:dataStr]){
//
//                [tempArray addObject:model];
//                [array removeObjectAtIndex:j];
//                j -= 1;
//            }
//        }
//        [_dataArray addObject:tempArray];
//        [_titleArr addObject:dataStr];
//    }
//    NSLog(@"%@",_titleArr);
//
//}

-(void)createToolBarView
{
    _toolBarView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-49, SCREEN_WIDTH, 49)];
    _toolBarView.backgroundColor = [UIColor whiteColor];
    _toolBarView.alpha = 0.9;
    [self.view addSubview:_toolBarView];
    // 删除button
    deletebtn = [FMUtil createBtnFrame:CGRectZero
                                 title:DELETE
                               bgImage:NULL
                                target:self
                                action:@selector(deletebtnClick)];
    deletebtn.enabled = NO;
    [_toolBarView addSubview:deletebtn];
    [deletebtn mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.width.offset(60);
         make.top.equalTo(_toolBarView).with.offset(10);
         make.height.offset(29);
         make.right.equalTo(_toolBarView).with.offset(-10);
     }];
    // 添加button
    addbtn = [FMUtil createBtnFrame:CGRectZero
                              title:ADD
                            bgImage:NULL
                             target:self
                             action:@selector(addbtnClick)];
    
    [_toolBarView addSubview:addbtn];
    [addbtn mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.width.offset(60);
         make.top.equalTo(_toolBarView).with.offset(10);
         make.height.offset(29);
         make.right.equalTo(deletebtn.mas_left).with.offset(-10);
     }];
    _toolBarView.hidden = YES;
    
}
- (void)createTableView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView                                = [[UITableView alloc]initWithFrame:CGRectMake(10, 64, SCREEN_WIDTH - 20, SCREEN_HEIGHT  - 64) style:UITableViewStylePlain];
    
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate                       = self;
    _tableView.dataSource                     = self;
    _tableView.backgroundColor                = VcBgColor;
    [self.view addSubview:_tableView];
    
    [_tableView registerNib:[UINib nibWithNibName:@"FavoriteTableViewCell" bundle:nil] forCellReuseIdentifier:@"FAVORITE"];
    
    //下拉刷新控件
    _refresh = [[UIRefreshControl alloc]init];
    _refresh.tintColor = [UIColor greenColor];
    [_refresh setAttributedTitle:[[NSAttributedString alloc]initWithString:DOWN_REFRESH]];
    [_refresh addTarget:self action:@selector(dataRefresh) forControlEvents:UIControlEventValueChanged];
    [_tableView addSubview:_refresh];
    
    [_refresh beginRefreshing];
}

- (void)dataRefresh{
    [_refresh setAttributedTitle:[[NSAttributedString alloc]initWithString:REFRESH_ING]];
    [_dataArr removeAllObjects];
    [_articleArr removeAllObjects];
    [_titleArr removeAllObjects];
    [self loadData];
}

// 返回列表组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return _dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [_dataArr[section] count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FavoriteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FAVORITE" forIndexPath:indexPath];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"FavoriteTableViewCell" owner:self options:nil]lastObject];
        
    }
    
    if (_dataArr.count)
    {
        //显示内容
        FavoriteModel *model = _dataArr[indexPath.section][indexPath.row];
        [cell loadDataFromModel:model];
        //    [cell createIconFromModel:model];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40.0;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 155.0;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    // 自定制组头视图
    UIView * titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
    titleView.backgroundColor = VcBgColor;
    // 自定制组头上的文字
    // 日期字符串
    NSString * dataString = _titleArr[section];
    UILabel * label = [FMUtil createLabelFrame:CGRectMake(5, 5, 200, 30) attributeString:dataString];
    [titleView addSubview:label];
    return titleView;
}

//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//
//    DetailViewController *detail = [[DetailViewController alloc] init];
//    detail.hidesBottomBarWhenPushed = YES;
//    // 正向传值
//    FavoriteModel *model = _heroArr[indexPath.section][indexPath.row];
//    detail.heroID = model.ID;
//    [self.navigationController pushViewController:detail animated:YES];
//}

#pragma mark -删除
//设置编辑风格EditingStyle
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.tableView.editing)
    {
        //当表视图处于没有未编辑状态时选择多选删除
        return UITableViewCellEditingStyleDelete| UITableViewCellEditingStyleInsert;
    }
    else
    {
        //当表视图处于没有未编辑状态时选择左滑删除
        return UITableViewCellEditingStyleDelete;
    }
    
}

//设置滑动时显示多个按钮
- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    //添加一个删除按钮
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:(UITableViewRowActionStyleDestructive) title:@"        " handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        FavoriteModel * model = _dataArr[indexPath.section][indexPath.row];
        [self.dataArr[indexPath.section] removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [dataDic removeAllObjects];
        [dataDic setObject:model.favorite_id forKey:indexPath];
        [self deletebtnClick];
        
    }];
    deleteAction.backgroundColor = VcBgColor;
    return @[deleteAction];
}

//根据不同的editingstyle执行数据删除操作（点击左滑删除按钮的执行的方法）
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        
    }
    
}

//tableView的多选删除
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [dataDic removeObjectForKey:indexPath];
    if (dataDic.count == 0)
    {
        deletebtn.enabled = NO;
    }
    else
    {
        deletebtn.enabled = YES;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    FavoriteModel * model = _dataArr[indexPath.section][indexPath.row];
    [dataDic setObject:model.favorite_id forKey:indexPath];
    if (dataDic.count == 0) {
        deletebtn.enabled = NO;
    }
    else
    {
        deletebtn.enabled = YES;
    }
    
}

// 删除收藏
- (void)deletebtnClick
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    self.url = kFavoriteUrl_deleteall;
    dic[@"user_id"] = @"1";
    dic[@"sid"] = @"1";
    NSArray * array = [dataDic allValues];
    NSMutableString * favoriteStr = [[NSMutableString alloc] init];
    for (int i = 0 ; i< array.count; i++) {
        if (i == 0) {
            favoriteStr = [NSMutableString stringWithString:array[0]];
        }
        else
        {
            [favoriteStr appendFormat:@",%@", [array objectAtIndex:i]];
        }
    }
    dic[@"favorite_id"] = favoriteStr ;
    // 弱引用
    __weak typeof(self) weakSelf = self;
    [_fmManager POST:self.url parameters:dic
            progress:^(NSProgress * _Nonnull uploadProgress)
     {
         
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         //刷新UI
         [weakSelf loadData];
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         
         NSLog(@"%@",error);
     }];
    
    [self.navigationController setToolbarHidden:YES animated:YES];
    // 结束编辑
    [self.tableView setEditing:NO animated:YES];
    // 文字恢复
    self.navigationItem.rightBarButtonItem.title = EDIT;
    
}


#pragma mark -导航条样式设置
- (void)createMyNav{
    
    UILabel *titleLabel = [FMUtil addFMNavTitle:MY_COLLECTION];
    self.navigationItem.titleView = titleLabel;
    UIButton *leftBtn = [FMUtil addFMNavBtn:nil isLeft:YES target:self action:@selector(backAction) bgImageName:@"icon_nav_back"];
    leftBtn.frame = CGRectMake(0, 0, 12, 19);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithTitle:EDIT style:UIBarButtonItemStylePlain target:self action:@selector(editAction)];
    self.navigationItem.rightBarButtonItem = rightButton;
    
}

-(void)editAction{
    
    [self.tableView setEditing:!self.tableView.editing animated:YES];
    if (self.tableView.editing) {
        self.navigationItem.rightBarButtonItem.title = FINISH;
    }
    else
    {
        self.navigationItem.rightBarButtonItem.title = EDIT;
    }
    if (self.tableView.editing)
    {
        _toolBarView.hidden = NO;
        _toolBarView.userInteractionEnabled = YES;
    }
    else
    {
        _toolBarView.hidden = YES;
        _toolBarView.userInteractionEnabled = NO;
    }
    
}
-(void)addbtnClick
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    self.user = [User shareUser];
    dic[@"user_id"] = @"1";
    dic[@"sid"] = @"1";
    dic[@"content_id"] = [NSString stringWithFormat:@"%d",arc4random()%10];
    dic[@"block_id"] = [NSString stringWithFormat:@"%d",arc4random()%10];
    self.url = kFavoriteUrl_add;
    [_fmManager POST:self.url
          parameters:dic
            progress:^(NSProgress * _Nonnull uploadProgress)
     {
         
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSLog(@"%@",responseObject);
         [self loadData];
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         NSLog(@"失败！！！");
         NSLog(@"%@",error);
     }];
    
}
-(AFHTTPSessionManager *)manager {
    if (!_fmManager) {
        self.fmManager = [AFHTTPSessionManager manager];
    }
    return _fmManager;
}
- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
