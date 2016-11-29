//
//  PersonalViewController.m
//  FM820
//
//  Created by 石芸蕾 on 16/10/16.
//  Copyright © 2016年 Shirley. All rights reserved.
//

#import "PersonalViewController.h"
#import "FavoriteViewController.h"
#import "User.h"

#import "FMpopView.h"
#import "SettingCell.h"

#import <UMSocialCore/UMSocialCore.h>
#import "ZFChart.h"

#import "AboutUsViewController.h"
#import "HelpViewController.h"

@interface PersonalViewController ()<UIGestureRecognizerDelegate,
                                     ZFGenericChartDataSource, ZFLineChartDelegate,
                                     UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) ZFLineChart   * lineChart;

@property (nonatomic,strong) UIImageView    * headImageView;
@property (nonatomic,strong) UILabel        * nameLabel;
@property (nonatomic,strong) UIImageView    * bgChartView;
@property (nonatomic,strong) UIView         * faLineView;

@property (nonatomic,strong) FMpopView      * popView;
@property (nonatomic,strong) UIButton       * closeBtn;
@property (nonatomic,strong) UIToolbar      * bar;
@property (nonatomic,strong) UITableView    * tableView;

@property (nonatomic,strong) UISwitch       * rightSwitch;
@property (nonatomic,strong) UILabel        * cashLabel;
@property (nonatomic,strong) UILabel        * updateLabel;

@end

@implementation PersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createMyNav];
    
    [self createUI];
    
    [self getUserInfo];
    
    [self createChart];
    
}

#pragma mark - 创建周阅读折线图
- (void)createChart{
    _lineChart = [[ZFLineChart alloc] initWithFrame:CGRectMake(-20, 0, SCREEN_WIDTH, SCREEN_HEIGHT/2)];
    
    self.lineChart.dataSource = self;
    self.lineChart.delegate = self;
    self.lineChart.topicLabel.text = @"本周阅读记录";
    self.lineChart.topicLabel.textColor = [UIColor grayColor];
    //    self.lineChart.unit = @"人";
    
    self.lineChart.isResetAxisLineMinValue = YES;
    //    self.lineChart.isAnimated = NO;
    //    self.lineChart.valueLabelPattern = kPopoverLabelPatternBlank;
    self.lineChart.isShowSeparate = YES;
    //    self.lineChart.isShowAxisLineValue = NO;
    //    lineChart.valueCenterToCircleCenterPadding = 0;
    
    self.lineChart.unitColor = ZFWhite;
    self.lineChart.backgroundColor = [UIColor clearColor];
    //    self.lineChart.axisColor = [UIColor clearColor];
    self.lineChart.axisLineNameColor = ZFWhite;
    self.lineChart.axisLineValueColor = [UIColor clearColor];
    
    [_faLineView addSubview:_lineChart];
    [self.lineChart strokePath];
    
}

#pragma mark - ZFGenericChartDataSource

- (NSArray *)valueArrayInGenericChart:(ZFGenericChart *)chart{
    return @[@"1", @"2", @"2", @"0", @"8", @"6",@"7"];
}

- (NSArray *)nameArrayInGenericChart:(ZFGenericChart *)chart{
    
    NSDictionary *dic = @{@"dataArr":@[@"18", @"19", @"20", @"21", @"22", @"23",@"24"]};
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"dataNoti" object:nil userInfo:dic];
    
    return @[@"SUN", @"MON", @"TUE", @"WEN", @"THU", @"FRI",@"SAT",];
    
}

//- (NSArray *)nameDateArrayInGenericChart:(ZFGenericChart *)chart{
//    return @[@"18", @"19", @"20", @"21", @"22", @"23",@"24"];
//
//}

- (NSArray *)colorArrayInGenericChart:(ZFGenericChart *)chart{
    return @[[UIColor blueColor]];
}

- (CGFloat)axisLineMaxValueInGenericChart:(ZFGenericChart *)chart{
    return 8;
}

- (CGFloat)axisLineMinValueInGenericChart:(ZFGenericChart *)chart{
    return 0;
}

- (NSUInteger)axisLineSectionCountInGenericChart:(ZFGenericChart *)chart{
    return 8;
}

#pragma mark - ZFLineChartDelegate

- (CGFloat)groupWidthInLineChart:(ZFLineChart *)lineChart{
    return 25.f;
}

- (CGFloat)paddingForGroupsInLineChart:(ZFLineChart *)lineChart{
    return 20.f;
}

- (CGFloat)circleRadiusInLineChart:(ZFLineChart *)lineChart{
    return 5.f;
}

- (CGFloat)lineWidthInLineChart:(ZFLineChart *)lineChart{
    return 1.f;
}

- (NSArray *)valuePositionInLineChart:(ZFLineChart *)lineChart{
    return @[@(kChartValuePositionOnTop)];
}

- (void)lineChart:(ZFLineChart *)lineChart didSelectCircleAtLineIndex:(NSInteger)lineIndex circleIndex:(NSInteger)circleIndex circle:(ZFCircle *)circle popoverLabel:(ZFPopoverLabel *)popoverLabel{
    NSLog(@"第%ld个", (long)circleIndex);
    
    //可在此处进行circle被点击后的自身部分属性设置,可修改的属性查看ZFCircle.h
    circle.circleColor = ZFRed;
    circle.isAnimated = YES;
    circle.opacity = 0.5;
    [circle strokePath];
    
    //可将isShowAxisLineValue设置为NO，然后执行下句代码进行点击才显示数值
    //    popoverLabel.hidden = NO;
}

- (void)lineChart:(ZFLineChart *)lineChart didSelectPopoverLabelAtLineIndex:(NSInteger)lineIndex circleIndex:(NSInteger)circleIndex popoverLabel:(ZFPopoverLabel *)popoverLabel{
    NSLog(@"第%ld个" ,(long)circleIndex);
    
    //可在此处进行popoverLabel被点击后的自身部分属性设置
    popoverLabel.textColor = ZFGold;
    [popoverLabel strokePath];
}








#pragma mark -UI搭建
- (void)createUI{
    
    //头像
    _headImageView = [FMUtil createImageViewFrame:CGRectMake(137.5, 85, 100, 100) imageName:@""];
    _headImageView.backgroundColor = [UIColor blackColor];
    _headImageView.layer.masksToBounds = YES;
    _headImageView.layer.cornerRadius = _headImageView.frame.size.width * 0.5;
    [self.view addSubview:_headImageView];
    //昵称
    _nameLabel = [FMUtil createLabelFrame:CGRectMake(100, 205, 175, 40) title:@"十五的糯米团子"];
    _nameLabel.font = TXT_SIZE_22;
    _nameLabel.textColor = [UIColor blackColor];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_nameLabel];
    //图表背景
    _bgChartView = [FMUtil createImageViewFrame:CGRectMake(-40, 267, SCREEN_WIDTH+40, 300) imageName:@"Bg"];
    [self.view addSubview:_bgChartView];
    //图表父视图，以便对图表做约束
    _faLineView = [[UIView alloc] init];
    //    _faLineView.backgroundColor = [UIColor redColor];
    //    _faLineView.alpha = 0.7;
    [self.view addSubview:_faLineView];
    
    
    [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(85);
        make.width.equalTo(@100);
        make.height.equalTo(@100);
    }];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(_headImageView.mas_bottom).offset(20);
        make.width.equalTo(@250);
        make.height.equalTo(@40);
    }];
    [_bgChartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(0);
        make.top.equalTo(_nameLabel.mas_bottom).offset(34);
        make.width.equalTo(self.view.mas_width);
        make.bottom.equalTo(self.view.mas_bottom).offset(40);
        
    }];
    [_faLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_bgChartView.mas_left).offset(0);
        make.top.equalTo(_bgChartView.mas_top).offset(0);
        make.width.equalTo(_bgChartView.mas_width);
        make.bottom.equalTo(self.view.mas_bottom).offset(-50);
        
    }];
    
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //隐藏导航栏底部的线条
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    

    
}

- (void)getUserInfo{
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"KHaveLogin"] isEqualToString:@"YES"] ) {
        
        _nameLabel.text = [User userFromFile].userName;
        
        [_headImageView sd_setImageWithURL:[NSURL URLWithString:[User userFromFile].userHeadImgUrl]];
    }
    
    
}



#pragma mark -导航条样式设置
- (void)createMyNav{
    
    
    UILabel *titleLabel = [FMUtil addFMNavTitle:nil];
    self.navigationItem.titleView = titleLabel;
    UIButton *rightBtn = [FMUtil addFMNavBtn:nil isLeft:NO target:self action:@selector(popSettingPage) bgImageName:@"buttn_setting_normal"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    UIButton *leftBtn = [FMUtil addFMNavBtn:nil isLeft:YES target:self action:@selector(pushCollectPage) bgImageName:@"buttn_collection_normal"];
    leftBtn.frame = CGRectMake(0, 0, 16, 19);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}

#pragma mark -收藏页面跳转
- (void)pushCollectPage{
    FavoriteViewController *ctrl = [[FavoriteViewController alloc] init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:ctrl animated:YES];
    self.hidesBottomBarWhenPushed = NO;

}


//****************************设置页面**********************************
#pragma mark - 弹出设置页面
- (void)popSettingPage{
    
    //添加毛玻璃效果
    _bar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, SCREEN_HEIGHT)];
    _bar.barStyle = UIBarStyleDefault;
    _bar.alpha = 0.8;
    [self.view addSubview:self.bar];

    //popView
    [[UIApplication sharedApplication].keyWindow addSubview:self.popView];
    //x按钮，点击关闭
    _closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-20-18, 30, 18, 18)];
    [_closeBtn setImage:[UIImage imageNamed:@"icon_close_normal"] forState:UIControlStateNormal];
    [_closeBtn setImage:[UIImage imageNamed:@"icon_close_hover"] forState:UIControlStateSelected];
//    [_closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view.mas_top).offset(20);
//        make.right.equalTo(self.view.mas_right).offset(-20);
//        make.width.equalTo(@17.5);
//        make.height.equalTo(@18);
//    }];
    [_closeBtn addTarget:self action:@selector(closeClick) forControlEvents:UIControlEventTouchUpInside];
    [self.popView addSubview:self.closeBtn];
    //添加tableView
    [self createTableView];
    
    [self.popView show];
}

- (void)closeClick{
    [self.popView dismiss];
    [self.bar removeFromSuperview];
}

- (FMpopView *)popView {
    if(_popView == nil) {
        _popView = [[FMpopView alloc] init];
        _popView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    }
    return _popView;
}

#pragma mark -创建设置页面的tableView
- (void)createTableView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView                                = [[UITableView alloc]initWithFrame:CGRectMake(0, 273, SCREEN_WIDTH, 250) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor colorWithRed:0.99f green:0.99f blue:1.00f alpha:1.00f];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate                       = self;
    _tableView.dataSource                     = self;
    [self.popView addSubview:_tableView];
    
    [_tableView registerNib:[UINib nibWithNibName:@"SettingCell" bundle:nil] forCellReuseIdentifier:@"Setting"];
    
}

#pragma mark ----- UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
//            ModifyPwdVc * forgetPwdVc = kMain_storyVCName(@"ModifyPwdVc");
//            forgetPwdVc.navigationItem.title = @"修改密码";
//            [self.navigationController pushViewController:forgetPwdVc animated:YES];
            
        }
            break;
        case 1:
        {

            [self clearFile];
            
        }
            break;
        case 2:
        {
            AboutUsViewController *aboutVc = [[AboutUsViewController alloc] init];
//            aboutVc.hidesBottomBarWhenPushed = YES;
            [self.popView dismiss];
            [self.bar removeFromSuperview];
            [self.navigationController pushViewController:aboutVc animated:YES];
            
        }
            break;
        case 3:
        {
            HelpViewController *helpVc = [[HelpViewController alloc] init];
            [self.popView dismiss];
            [self.bar removeFromSuperview];
            helpVc.navigationItem.title = @"帮助与反馈";
            [self.navigationController pushViewController:helpVc animated:YES];
            
        }
            break;
    }
    
}

#pragma mark -----UITableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
-
(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SettingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Setting"];
    cell.backgroundColor = [UIColor colorWithRed:0.99f green:0.99f blue:0.99f alpha:1.00f];
    switch (indexPath.row) {
        case 0:
        {
            cell.titleLabel.text = @"消息通知";
            cell.leftImageView.image = [UIImage imageNamed:@"icon_notice_normal"];
            //右边的UISwitch
            cell.rightImageView.hidden = YES;
            _rightSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-20-51, 11, 0, 0)];
            [cell addSubview:_rightSwitch];
//            cell.accessoryView = self.rightSwitch;
            //默认开启
            [_rightSwitch setOn:YES animated:YES];
            //开关开启时的颜色
            _rightSwitch.onTintColor = SwitchColor;
            // 开关事件切换通知
            [_rightSwitch addTarget:self action:@selector(switchAction) forControlEvents:UIControlEventValueChanged];

        }
            break;
        case 1:
        {
            cell.titleLabel.text = @"清理缓存";
            cell.leftImageView.image = [UIImage imageNamed:@"icon_clean_normal"];
            cell.rightImageView.hidden = YES;
            //右边label
            _cashLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-20-80, 23, 80, 17)];
            _cashLabel.textAlignment = NSTextAlignmentRight;
            _cashLabel.text = [NSString stringWithFormat:@"%.2fM", [self filePath]];;
            [cell addSubview:_cashLabel];
        }
            break;
        case 2:
        {
            cell.titleLabel.text = @"关于FM820";
            cell.leftImageView.image = [UIImage imageNamed:@"icon_about_normal"];
            cell.rightImageView.hidden = NO;
        }
            break;
        case 3:
        {
            cell.titleLabel.text = @"帮助与反馈";
            cell.leftImageView.image = [UIImage imageNamed:@"icon_help_normal"];
            cell.rightImageView.hidden = NO;
        }
            break;
        case 4:
        {
            cell.titleLabel.text = @"检查通知";
            cell.leftImageView.image = [UIImage imageNamed:@"icon_update_normal"];
            cell.rightImageView.hidden = YES;
            _updateLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-20-80, 23, 80, 17)];
            _updateLabel.textAlignment = NSTextAlignmentRight;
            _updateLabel.text = @"V2.0";
            [cell addSubview:_updateLabel];
        }
            break;
    }
    return cell;
}

-(void)switchAction
{
    BOOL isButtonOn = [_rightSwitch isOn];
    if (isButtonOn) {
        NSLog(@"开");
    }else {
        NSLog(@"关");
    }
}


#pragma mark - 清理缓存
//1:首先我们计算一下单个文件的大小
- (long long) fileSizeAtPath:(NSString*) filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}
//2:遍历文件夹获得文件夹大小，返回多少M（提示：你可以在工程界设置（)m）
- (float ) folderSizeAtPath:(NSString*) folderPath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize/(1024.0*1024.0);
}

//显示缓存大小
- (float)filePath
{
    NSString * cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    return [self folderSizeAtPath:cachPath];
}

//清理缓存
- (void)clearFile
{
    NSString * cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSArray * files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
    NSLog(@"cachpath = %@", cachPath);
    for (NSString * p in files) {
        NSError * error = nil;
        NSString * path = [cachPath stringByAppendingPathComponent:p];
        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
            [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
        }
    }
    [self performSelectorOnMainThread:@selector(clearCachSuccess) withObject:nil waitUntilDone:YES];
}

- (void)clearCachSuccess
{
    NSLog(@"清理成功");
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"缓存清理完毕" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alertView show];
    [_tableView reloadData];//清理完之后重新导入数据
    _cashLabel.text = [NSString stringWithFormat:@"%.2fM", [self filePath]];;

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
