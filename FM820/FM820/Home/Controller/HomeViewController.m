//
//  HomeViewController.m
//  FM820
//
//  Created by 石芸蕾 on 16/10/16.
//  Copyright © 2016年 Shirley. All rights reserved.
//

#import "HomeViewController.h"
#import "FMHomeViewCell.h"
#import "HomePageCellModel.h"
#import "User.h"
#import "FMreferendum.h"
#import "FMSpitslot.h"
#import "FMcolorEgg.h"
#import "FMDetailVc.h"

// 设置颜色
#define MeeColor(r,g,b) [UIColor colorWithRed:(r)/255.0  green:(g)/255.0  blue:(b)/255.0  alpha:1.0]
#define MeeColorA(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]
// 设置随机颜色
#define MeeRandomColor MeeColor(arc4random_uniform(256),arc4random_uniform(256),arc4random_uniform(256))
// 设置灰色
#define MeeGreyColor(v) MeeColor(v,v,v)
// 设置背景颜色
#define MeeBgColor MeeGreyColor(206)

static NSString *const FMHomeViewCellID = @"FMHomeViewCellID";

@interface HomeViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak)IBOutlet UITableView *tableView;
@property (weak, nonatomic)IBOutlet  NSLayoutConstraint *imageHC;
@property (weak, nonatomic)IBOutlet  NSLayoutConstraint *imageTC;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UIView *headTopView;
@property (weak, nonatomic) IBOutlet UILabel *headViewBottomViewLabel;
@property (nonatomic, strong) AFHTTPSessionManager *fmManager;
@property (nonatomic, strong) FMHomeViewCell *tableViewCell;
@property (nonatomic, strong) User *user;
@property (nonatomic, strong) NSMutableArray *configArray;
@property (nonatomic, strong) NSMutableArray *ary;
@property (nonatomic, strong) FMreferendum *fMreferendum;
@property (nonatomic, strong) FMSpitslot *fMSpitslot;
@property (nonatomic, copy) NSString *special;
@property (nonatomic, strong) NSArray *colorArray;
@property (nonatomic, copy) NSString *voteid;
@property (nonatomic, copy) NSString *blockName;
@property (nonatomic, copy) NSString  *ivoteNumber;
@property (nonatomic, copy) NSString *searchTitle;
@property (nonatomic, copy) NSString *searchImgUrl;
@property (nonatomic, copy) NSString *readcount;
@property (nonatomic, strong) NSMutableArray *optionTitleArray1;
@property (nonatomic ,copy) NSString *seventhOption;
@property (nonatomic, copy) NSString *spitslotTitle;
@property (nonatomic, copy) NSString *spitslotDescs;
@property (nonatomic, copy) NSString *spitslotContent;
@property (nonatomic, copy) NSString *spitslotPost;
@property (nonatomic, copy) NSString *spitslotReadcount;
@property (nonatomic, strong) NSMutableArray *spitslotInformationArray;
@property (nonatomic, strong) NSMutableArray *spitslotAvatarArray;
@property (nonatomic, strong) UIView *colorEggView;
@property (nonatomic, copy) NSString *colorEggPost;
@property (nonatomic, copy) NSString *colorEggDescs;
@property (nonatomic, strong) NSMutableArray *colorEggReadCount;
@property (nonatomic, strong) NSMutableArray *colorEggDayorderArray;
@property (nonatomic, copy) NSString *colorEggAllReadPersonCount;
@property (nonatomic, strong) FMcolorEgg *fMcolorEgg;
@property (nonatomic, strong) UIView *bottomVc;
@end

@implementation HomeViewController


int num = 0;
-(AFHTTPSessionManager *)manager {
    if (!_fmManager) {
        self.fmManager = [AFHTTPSessionManager manager];
    }
    return _fmManager;
}


- (NSArray *)colorArray {
    if (!_colorArray) {
        self.colorArray = @[[UIColor colorWithHexStr:@"#1896d6"],
                            [UIColor colorWithHexStr:@"#44b272"],
                            [UIColor colorWithHexStr:@"#e8561f"],
                            [UIColor colorWithHexStr:@"#fbc72e"],
                            [UIColor colorWithHexStr:@"#874b96"],
                            [UIColor colorWithHexStr:@"#a06d5f"],
                            [UIColor colorWithHexStr:@"#e75666"],
                            [UIColor colorWithHexStr:@"#19a3ae"],
                            ];
    }
    return _colorArray;
}

- (UIView *)colorEggView {
    if (_colorEggView == nil) {
        self.colorEggView = [[UIView alloc] init];
    }
    return _colorEggView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    [self setupHeadImgProperties];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

#pragma mark - setUp tableView
- (void)setupTableView {
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.tableView.estimatedRowHeight = 44.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
//    [self.tableView registerNib:[UINib nibWithNibName:@"FMHomeViewCell" bundle:nil] forCellReuseIdentifier:FMHomeViewCellID];
    [_tableView registerClass:[FMHomeViewCell class] forCellReuseIdentifier:FMHomeViewCellID];
    [self.tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    self.tableView.contentInset = UIEdgeInsetsMake(SCREEN_HEIGHT-48, 0, 0, 0 );
    self.imageHC.constant = SCREEN_HEIGHT-48;
    
#pragma mark - tableView head refresg
    self.tableView.mj_header = [MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadTopic)];
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
}

- (void)loadTopic {
    self.colorEggDayorderArray = [NSMutableArray array];
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    self.user = [User shareUser];
    //    dic[@"user_id"] = self.user.userId;
    //    dic[@"sid"] = self.user.sid;
    dic[@"user_id"] = @"1";
    dic[@"sid"] = @"1";
    
#pragma mark - 首页初次显示
    [_fmManager POST:@"http://120.26.112.49:8000/content/list" parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.ary =  [responseObject[@"msg"][@"article"] mutableCopy];
        if (self.ary.count == 0) return ;
        
#pragma mark - config配置
        [_fmManager POST:@"http://120.26.112.49:8000/config/list" parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            self.special =  responseObject[@"msg"][@"special"];
            NSMutableArray *ary1 =  [responseObject[@"msg"][@"tag"] mutableCopy];
            NSMutableArray *dayorderArray = [NSMutableArray array];
            NSMutableArray *categoryArry = [NSMutableArray array];
            
            for (int i = 0; i < self.ary.count; i++) {
                if ([ary1[i][@"configid"] isEqual: self.ary[i][@"dayorder"]] && [ary1[i][@"category"]  isEqual: @"TAG"]) {
                    [dayorderArray addObject:ary1[i]];
                }
            }
            
            for (int i = 0; i < ary1.count; i++) {
                if ([ary1[i][@"category"]  isEqual: @"TAG"] ) {
                    [categoryArry addObject:ary1[i]];
                }
            }
            
            self.seventhOption =  categoryArry.lastObject [@"option"];
            num += 1;
            for (int i = 0; i < dayorderArray.count; i++) {
                NSMutableDictionary *str1 = [(NSMutableDictionary *)self.ary[i] mutableCopy];
                NSString *str2 = dayorderArray[i][@"option"];
                [str1 setValue:str2 forKey:@"optionURL" ];
                self.ary[i] = str1;
            }
            self.homePageCellModel = [HomePageCellModel mj_objectArrayWithKeyValuesArray:self.ary];
            [self.tableView reloadData];
            [self setupDownElement];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"error");
        }];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error");
    }];
    
    
#pragma mark - mark 关联投票接口
    [_fmManager POST:@"http://120.26.112.49:8000/fm820vote/query" parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        self.voteid = responseObject[@"msg"][@"vote_id"];
        self.blockName = responseObject[@"msg"][@"block_name"];
        NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
        self.readcount  = [numberFormatter stringFromNumber: responseObject[@"msg"][@"readcount"]];
        
#pragma mark - mark 首页投票接口
        NSMutableDictionary *searchDic = [NSMutableDictionary dictionary];
        searchDic[@"vote_id"] = self.voteid;
        //        searchDic[@"user_id"] = self.user.userId;
        searchDic[@"user_id"] = @"1";
        [_fmManager POST:@"http://120.26.112.49:8001/vote/search" parameters:searchDic progress:^(NSProgress * _Nonnull uploadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            num += 1;
            NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
            self.ivoteNumber = [numberFormatter stringFromNumber: responseObject[@"msg"][@"ivoted"]];
            
            self.searchTitle = responseObject[@"msg"][@"title"];
            self.searchImgUrl = responseObject[@"msg"][@"post"];
            NSMutableArray *optionTitleArray =[ responseObject[@"msg"][@"options"] mutableCopy];
            NSMutableArray *ory = [NSMutableArray array];
            self.optionTitleArray1 = ory;
            for (int i = 0; i < optionTitleArray.count; i++) {
                NSString *tit = optionTitleArray[i][@"option_title"];
                self.optionTitleArray1[i] = tit;
            }
            [self setupDownElement];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"error");
        }];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error");
    }];
#pragma mark - 吐槽
    NSMutableDictionary *spitslotDic = [NSMutableDictionary dictionary];
    self.user = [User shareUser];
    //    dic[@"user_id"] = self.user.userId;
    spitslotDic[@"user_id"] = @"1";
    
    [_fmManager POST:@"http://120.26.112.49:8000/spit/list" parameters:spitslotDic progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        num += 1;
        NSMutableDictionary *spitslotDic =  responseObject[@"msg"];
        self.spitslotTitle = spitslotDic[@"title"];
        self.spitslotDescs = spitslotDic[@"descs"];
        self.spitslotPost = spitslotDic[@"post"];
        NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
        self.spitslotReadcount  = [numberFormatter stringFromNumber:spitslotDic[@"readcount"]];
        NSMutableArray *spitslotArray = responseObject[@"msg"][@"comments"][@"hotcomments"];
        self.spitslotInformationArray = [NSMutableArray array];
        self.spitslotAvatarArray = [NSMutableArray array];
        for (int i = 0; i < spitslotArray.count; i++) {
            self.spitslotAvatarArray[i] = [spitslotArray[i][@"avatar"] mutableCopy];
            self.spitslotInformationArray[i] = spitslotArray[i][@"informations"];
        }
        [self setupDownElement];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error");
    }];
#pragma mark - 彩蛋网络请求
    [_fmManager POST:@"http://120.26.112.49:8000/paintedegg/show" parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        num += 1;
        self.colorEggPost = responseObject[@"msg"][@"post"];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error");
    }];
    
#pragma mark - 周阅读统计接口
    [_fmManager POST:@"http://120.26.112.49:8000/read/record" parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        num += 1;
        int responseInt = [responseObject[@"errno"] intValue];
        if (responseInt == 1142) return;
        self.colorEggReadCount = [responseObject[@"msg"][@"read"] mutableCopy];
        for (int i = 0; i < self.colorEggReadCount.count; i++) {
            self.colorEggDayorderArray[i] = self.colorEggReadCount[i][@"dayorder"];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error");
    }];
    
#pragma mark - 今日文章多少人读完总数
    [_fmManager POST:@"http://120.26.112.49:8000/read/summary" parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        num += 1;
        NSNumber *colorEggAllReadPersonCountNum = responseObject[@"msg"][@"sum"];
        NSString *colorEggAllReadPersonCountSring = [NSString stringWithFormat:@"%@", colorEggAllReadPersonCountNum];
        self.colorEggAllReadPersonCount = colorEggAllReadPersonCountSring;

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error");
    }];

}

- (void)setupHeadImgProperties {
    
    
}

#pragma mark - footer View
- (void)setupDownElement {
    if (num <=5) {
        return;
    }
    NSURL *circleImvURL = [NSURL URLWithString:self.seventhOption];
    self.bottomVc = [[UIView alloc] init];
    self.bottomVc.x = 0;
    self.bottomVc.y =  0;
    self.bottomVc.width = SCREEN_WIDTH;
#warning  bottomVc高度暂时写死
    self.bottomVc.height = 1063;
    self.tableView.tableFooterView = self.bottomVc;
    
#pragma mark - spitslot or referendum
    if ([self.special isEqualToString:@"1"]) {
        if ([self.ivoteNumber isEqualToString:@"1"]) {
            self.fMreferendum = [[FMreferendum alloc] initWiReferendumArray:self.optionTitleArray1];
            [self.bottomVc addSubview:self.fMreferendum];
            
            [self.fMreferendum mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.bottomVc.mas_left).offset(0);
                make.top.equalTo(self.bottomVc.mas_top).offset(13);
                make.right.equalTo(self.bottomVc.mas_right).offset(0);
                make.bottom.equalTo(self.fMreferendum.readCountLabel).offset(15);
            }];
            
            NSURL *topImURl = [NSURL URLWithString:self.searchImgUrl];
            [self.fMreferendum.topImgV sd_setImageWithURL:topImURl placeholderImage:nil];
            self.fMreferendum.smallLabel.text = self.blockName;
            self.fMreferendum.middleLabel.text = self.searchTitle;
            self.fMreferendum.readCountLabel.text = self.readcount;
            self.fMreferendum.smallLabel.textColor = self.colorArray.lastObject;
            [self.fMreferendum.circleImgV sd_setImageWithURL:circleImvURL placeholderImage:nil];
            
#pragma mark - 首页彩蛋
            self.fMcolorEgg = [[FMcolorEgg alloc] initWithColorEggIconArray:self.colorEggDayorderArray];
            [self.bottomVc addSubview:self.fMcolorEgg];
            [self.fMcolorEgg mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.fMreferendum.mas_left).offset(10);
                make.top.equalTo(self.fMreferendum.mas_bottom).offset(10);
                make.height.and.width.mas_equalTo(SCREEN_WIDTH - 20);
            }];
           self. fMcolorEgg.haveReadCountLabel.text = [NSString stringWithFormat:@"今日%@人已读完", self.colorEggAllReadPersonCount];
            self.fMcolorEgg.currentLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)self.colorEggReadCount.count];
#warning 需要替换的url
//                NSURL *topImURlR = [NSURL URLWithString:self.colorEggPost];
            NSURL *topImURlR = [NSURL URLWithString:self.searchImgUrl];
            [self.fMcolorEgg.backImv sd_setImageWithURL:topImURlR placeholderImage:nil];
            [self.fMcolorEgg.smallImv sd_setImageWithURL:topImURlR placeholderImage:nil];
            
            [self setUpLastBottomView];
        } else {
            NSLog(@"6666666666666");
        }
    } else {
        self.fMSpitslot = [[FMSpitslot alloc] initWithSpitslotAvatarArray:self.spitslotAvatarArray andSpitslotInformationArray:self.spitslotInformationArray];
        [self.bottomVc addSubview:self.fMSpitslot];
        [self.fMSpitslot mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bottomVc.mas_left).offset(0);
            make.top.equalTo(self.bottomVc.mas_top).offset(0);
            make.right.equalTo(self.bottomVc.mas_right).offset(0);
            make.bottom.equalTo(self.fMSpitslot.readCountLabel).offset(15);
        }];
        
        NSURL *spitslotTopImvUrl = [NSURL URLWithString:self.spitslotPost];
        [self.fMSpitslot.topImgV sd_setImageWithURL:spitslotTopImvUrl placeholderImage:nil];
        self.fMSpitslot.smallLabel.text = self.spitslotTitle;
        self.fMSpitslot.middleLabel.text = self.spitslotDescs;
        self.fMSpitslot.readCountLabel.text = self.spitslotReadcount;
        self.fMSpitslot.smallLabel.textColor = self.colorArray.lastObject;
        [self.fMSpitslot.circleImgV sd_setImageWithURL:circleImvURL placeholderImage:nil];
        
#pragma mark - 首页彩蛋
        FMcolorEgg *fMcolorEgg = [[FMcolorEgg alloc] initWithColorEggIconArray:self.colorEggDayorderArray];
        [self.bottomVc addSubview:fMcolorEgg];
        [fMcolorEgg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.fMSpitslot.mas_left).offset(10);
            make.top.equalTo(self.fMSpitslot.mas_bottom).offset(10);
            make.height.and.width.mas_equalTo(SCREEN_WIDTH - 20);
        }];
        fMcolorEgg.haveReadCountLabel.text = [NSString stringWithFormat:@"今日%@人已读完", self.colorEggAllReadPersonCount];
        fMcolorEgg.currentLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)self.colorEggReadCount.count];
#warning 需要替换的url
//            NSURL *topImURl = [NSURL URLWithString:self.colorEggPost];
        NSURL *topImURl = [NSURL URLWithString:self.searchImgUrl];
        [fMcolorEgg.backImv sd_setImageWithURL:topImURl placeholderImage:nil];
        [fMcolorEgg.smallImv sd_setImageWithURL:topImURl placeholderImage:nil];
        
        [self setUpLastBottomView];
    }

    num = 0;
}

- (void)setUpLastBottomView {
// 承接view
    UIView *watchBeforeContentView = [[UIView alloc] init];
//    watchBeforeContentView.backgroundColor = [UIColor redColor];
    [self.bottomVc addSubview:watchBeforeContentView];
    [watchBeforeContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.fMcolorEgg.mas_bottom).offset(12);
        make.left.and.right.equalTo(self.view);
        make.height.mas_equalTo(69);
    }];
    UIView *leftLineView = [[UIView alloc] init];
    leftLineView.backgroundColor = [UIColor colorWithHexStr:@"#69899aa"];
    [watchBeforeContentView addSubview:leftLineView];
    [leftLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(watchBeforeContentView);
        make.top.equalTo(watchBeforeContentView.mas_top).offset(33);
        make.width.mas_equalTo(24);
        make.height.mas_equalTo(1);
    }];
    UIImageView *signImv = [[UIImageView alloc] init];
    [self.bottomVc addSubview:signImv];
    [signImv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftLineView.mas_right).offset(-2);
        make.centerY.equalTo(leftLineView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(22, 28));
    }];
    signImv.image = [UIImage imageNamed:@"icon_separative sign"];
    
    UIView *rightLineView = [[UIView alloc] init];
    rightLineView.backgroundColor = [UIColor colorWithHexStr:@"#69899aa"];
    [watchBeforeContentView addSubview:rightLineView];
    [rightLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view);
        make.top.equalTo(watchBeforeContentView.mas_top).offset(33);
        make.left.equalTo(signImv.mas_right).offset(-5);
        make.height.mas_equalTo(1);
    }];
    // 查看往日内容label
    UILabel *watchBeforLabel = [[UILabel alloc] init];
    [watchBeforeContentView addSubview:watchBeforLabel];
    [watchBeforLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(watchBeforeContentView.mas_centerX);
        make.top.equalTo(rightLineView.mas_bottom).offset(19);
    }];
    watchBeforLabel.text = @"看看往日内容";
    watchBeforLabel.textColor = [UIColor colorWithHexStr:@"#6788A8"];
    watchBeforLabel.font = TXT_SIZE_15;
}

#pragma mark - 监听change变化
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    NSValue *point = change[@"new"];
    if (-point.CGPointValue.y > 150) {
        self.imageHC.constant = -point.CGPointValue.y;
        self.imageTC.constant = 0;
    } else {
        self.imageHC.constant = 150;
        self.imageTC.constant = -150 - point.CGPointValue.y;
    }
}

#pragma mark - 顶部状态栏状态栏
- (BOOL)prefersStatusBarHidden {
    return YES;
}

#pragma - mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (_homePageCellModel) {
        return 7;
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.tableViewCell = [tableView dequeueReusableCellWithIdentifier:FMHomeViewCellID forIndexPath:indexPath];
    if (self.tableViewCell == nil) {
        self.tableViewCell = [[FMHomeViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:FMHomeViewCellID];
    }
    if (_homePageCellModel) {
        self.tableViewCell.homePageCellModel = _homePageCellModel[indexPath.row];
    }
    if (indexPath.row <= 7) {
        self.tableViewCell.contentCelliGlobal.textColor = self.colorArray[indexPath.row];
    }
    return self.tableViewCell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    FMDetailVc *fMDetailVc = [[FMDetailVc alloc] init];
    [self.navigationController pushViewController:fMDetailVc animated:YES];
}

// hi ,it is just test

//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
//
//
//        UIView *bottomVc = [[UIView alloc] init];
//    bottomVc.frame = CGRectMake(10, 15, self.view.width - 10 *2, 100);
//        bottomVc.backgroundColor = [UIColor redColor];
//
//    [self.tableView.tableFooterView addSubview:bottomVc];
//       return bottomVc;
//}

@end
