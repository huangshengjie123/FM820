//
//  FMDetailVc.m
//  FM820
//
//  Created by garfie on 16/11/10.
//  Copyright © 2016年 Shirley. All rights reserved.
//

#import "FMDetailVc.h"
#import "FMDetailVc.h"
#import "FMDetailContentView.h"
#import "FMCommentDetailViewCell.h"

@interface FMDetailVc ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) FMDetailContentView *fMDetailContentView ;
@property (nonatomic, strong) FMCommentDetailViewCell *fMCommentDetailViewCell;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation FMDetailVc
static NSString * const CellId = @"cellID";
static NSString * const HeaderId = @"header";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
    [self setupTableView];
    //    [self setupCommentTableView];
}

- (void)setupTableView {
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.fMDetailContentView = [[FMDetailContentView alloc] init];
    [self.tableView beginUpdates];
    [self.tableView setTableHeaderView:self.fMDetailContentView];
    [self.tableView endUpdates];
    
    [self.fMDetailContentView setNeedsLayout];
    [self.fMDetailContentView layoutIfNeeded];
    CGSize size = [self.fMDetailContentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    CGRect headerFrame = self.fMDetailContentView.frame;
    headerFrame.size.height = size.height + 40;
    self.fMDetailContentView.frame = headerFrame;
    self.tableView.tableHeaderView = self.fMDetailContentView;
//    self.tableView.tableHeaderView.backgroundColor = [UIColor greenColor];
    [self.tableView registerClass:[FMCommentDetailViewCell class] forCellReuseIdentifier:CellId];
//    self.automaticallyAdjustsScrollViewInsets = YES;
//    self.tableView.backgroundColor = [UIColor orangeColor];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
}



// 评论区域
//- (void)setupCommentTableView {
//
//}


- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FMCommentDetailViewCell *fMCommentDetailViewCell= [tableView dequeueReusableCellWithIdentifier:CellId];
    if (fMCommentDetailViewCell == nil) {
        fMCommentDetailViewCell = [[FMCommentDetailViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellId];
    }
    return fMCommentDetailViewCell;
    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
//    cell.textLabel.text = [NSString stringWithFormat:@"第%ld行", indexPath.row];
//    return cell;
}

- (CGFloat) tableView: (UITableView*) tableView heightForRowAtIndexPath: (NSIndexPath*) indexPath {
    return 50;
}



@end
