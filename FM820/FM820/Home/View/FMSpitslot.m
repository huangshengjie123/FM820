//
//  FMSpitslot.m
//  FM820
//
//  Created by garfie on 16/10/26.
//  Copyright © 2016年 Shirley. All rights reserved.
//

#import "FMSpitslot.h"

@interface FMSpitslot ()
@property (nonatomic, strong)UIView *fsView;
@property (nonatomic, strong)UIView *spitspotView;

@end
@implementation FMSpitslot
- (instancetype)initWithSpitslotAvatarArray:(NSMutableArray *)avatarArray andSpitslotInformationArray:(NSMutableArray *)informationArray{
    if (self = [super init]) {
        [self createUIandAvatarArray: avatarArray informationArray: informationArray];
    }
         return self;
}

- (void)createUIandAvatarArray:(NSMutableArray *)avatarArray informationArray:(NSMutableArray *)informationArray {
    // 背景view
    UIView *myView = [[UIView alloc] init];
    [self addSubview:myView];
    [myView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(10, 10, 0, 10));
    }];
    
    // 顶部imgv
    self.topImgV = [[UIImageView alloc] init];
    [myView addSubview:self.topImgV];
    [self.topImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(myView.mas_top).offset(0);
        make.left.and.right.equalTo(myView);
        make.height.mas_equalTo(266);
    }];
    self.topImgV.backgroundColor = [UIColor greenColor];
    self.topImgV.image = [UIImage imageNamed:@"testImage1"];
    
    // 投票imv
    self.spitslotImv = [[UIImageView alloc] init];
    [self.topImgV addSubview:_spitslotImv];
    [_spitslotImv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topImgV.mas_top).offset(30);
        make.right.equalTo(self.topImgV.mas_right).offset(0);
        make.size.mas_equalTo(CGSizeMake(84, 35));
    }];
    _spitslotImv.image = [UIImage imageNamed:@"icon_tucao_normal copy"];
    
    // 小圆圈
    self.circleImgV = [[UIImageView alloc] init];
    [myView addSubview:_circleImgV];
    [_circleImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(_topImgV.mas_leading).offset(10);
        make.top.equalTo(_topImgV.mas_bottom).offset(15);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    _circleImgV.image = [[UIImage imageNamed:@"icon_8_selected"] circleImage] ;
    
    // iGlobal
    self.smallLabel = [[UILabel alloc] init];
    [myView addSubview:self.smallLabel];
    [self.smallLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_circleImgV.mas_right).offset(5);
        make.top.equalTo(_topImgV.mas_bottom).offset(15);
    }];
    self.smallLabel.font = TXT_SIZE_13;
    self.smallLabel.text = @"iGlobal";
    
    // 中间label
    self.middleLabel = [[UILabel alloc] init];
    [myView addSubview:_middleLabel];
    [_middleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(_topImgV.mas_leading).offset(10);
        make.top.equalTo(_circleImgV.mas_bottom).offset(5);
        make.trailing.equalTo(self.topImgV.mas_trailing).offset(-10);

    }];
    
    self.middleLabel.numberOfLines = 0;
    self.middleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _middleLabel.font = TXT_SIZE_18;
    _middleLabel.text = @"童年.暮年.夏";
    
    // 评论背景
    UIView *spitspotView = [[UIView alloc] init];
    self.spitspotView = spitspotView;
    [myView addSubview:spitspotView];
    [spitspotView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_middleLabel.mas_bottom).offset(10);
        make.left.equalTo(_topImgV.mas_left).offset(10);
        make.right.equalTo(_topImgV.mas_right).offset(-10);
        //假高度
        //            make.height.mas_equalTo(300);
    }];
    spitspotView.backgroundColor = [UIColor colorWithHexStr:@"#f5f8f9" ];
    spitspotView.layer.cornerRadius = 4.0;
    spitspotView.layer.masksToBounds = YES;
    
    // 承接View
    UIView *catchView = [[UIView alloc] init];
    [spitspotView addSubview:catchView];
    [catchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_middleLabel.mas_bottom);
        make.left.equalTo(_topImgV.mas_left).offset(0);
        make.right.equalTo(_topImgV.mas_right).offset(0);
        //假高度
        make.bottom.equalTo(spitspotView.mas_bottom);
    }];
    //        catchView.backgroundColor = [UIColor blueColor];
    NSUInteger underFourCount = avatarArray.count;
    if (underFourCount > 4) {
        underFourCount = 4;
    }
    // 服务器返回的label数据做出相对应个数的处理
    for (int i = 1; i <= underFourCount; i++) {
        self.fsView = [[UIView alloc] init];
        [catchView addSubview:self.fsView];
        [self.fsView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(catchView.mas_top).offset(30 * i);
            make.left.equalTo(catchView.mas_left).offset(10);
            make.right.equalTo(catchView.mas_right);
            make.height.mas_equalTo(20);
        }];
        //            self.fsView.backgroundColor = [UIColor redColor];
        // 评论用户头像
        UIImageView *userImv = [[UIImageView alloc] init];
        [self.fsView addSubview:userImv];
        [userImv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.fsView.mas_left).offset(7);
            make.top.equalTo(self.fsView.mas_top);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
        userImv.layer.cornerRadius = 10;
        userImv.layer.masksToBounds = YES;
        NSURL *spitslotUserImgUrl = [NSURL URLWithString:avatarArray[i]];
        [userImv sd_setImageWithURL:spitslotUserImgUrl placeholderImage:nil];
        
        // User comment message
        self.userCommentLabel = [[UILabel alloc] init];
        [self.fsView addSubview:_userCommentLabel];
        [_userCommentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(userImv.mas_right).offset(5);
            make.centerY.equalTo(userImv.mas_centerY);
            make.right.equalTo(self.fsView).offset(-15);
        }];
        _userCommentLabel.text = informationArray[i];
        _userCommentLabel.font = TXT_SIZE_15;
        _userCommentLabel.textColor = [UIColor colorWithHexStr:@"#666666"];
    }
    
    // imvLine
    UIImageView *imvLine = [[UIImageView alloc] init];
    [catchView addSubview:imvLine];
    [imvLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.fsView.mas_bottom).offset(7.5);
        make.right.and.left.equalTo(catchView);
        make.height.mas_equalTo(1);
    }];
    imvLine.image = [UIImage imageNamed:@"home_Line"];
    
    // 查看全部
    UIButton *checkAllBtn = [[UIButton alloc] init];
    [catchView addSubview:checkAllBtn];
    [checkAllBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(catchView.mas_centerX);
        make.top.equalTo(imvLine.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(60, 25));
    }];
    [checkAllBtn setTitle:@"查看全部" forState:UIControlStateNormal];
    [checkAllBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    checkAllBtn.titleLabel.font = TXT_SIZE_14;
    
    [spitspotView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(checkAllBtn.mas_bottom).offset(12.5);
    }];
    [spitspotView.superview layoutIfNeeded];
    
    // readLabel
    UILabel *readLabel = [[UILabel alloc] init];
    [self addSubview:readLabel];
    [readLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(spitspotView.mas_bottom).offset(15);
        make.left.equalTo(spitspotView.mas_left);
    }];
    readLabel.textColor = [UIColor colorWithHexStr:@"#6989AA"];
    readLabel.text = @"阅读";
    readLabel.font = TXT_SIZE_13;
    
    // readCountLabel
    UILabel *readCountLabel = [[UILabel alloc] init];
    self.readCountLabel = readCountLabel;
    [myView addSubview:readCountLabel];
    [readCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(readLabel.mas_top);
        make.left.equalTo(readLabel.mas_right).offset(5);
    }];
    readCountLabel.text = @"1234";
    readCountLabel.textColor = [UIColor colorWithHexStr:@"#6989AA"];
    readCountLabel.font = TXT_SIZE_13;
    
    // transfer
    UIButton *transferBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:transferBtn];
    [transferBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(readLabel.mas_top);
        make.right.equalTo(self.mas_right).offset(-45);
        make.size.mas_equalTo(CGSizeMake(14, 14));
    }];
    [transferBtn setImage:[UIImage imageNamed:@"icon_share1_normal"] forState:UIControlStateNormal];
    [transferBtn setImage:[UIImage imageNamed:@"icon_share1_hover"] forState:UIControlStateHighlighted];
    
    // comment
    UIButton *commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:commentBtn];
    [commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(transferBtn.mas_top);
        make.right.equalTo(transferBtn.mas_left).offset(-42.5);
        make.size.mas_equalTo(CGSizeMake(13, 15));
    }];
    [commentBtn setImage:[UIImage imageNamed:@"icon_collect_normal"] forState:UIControlStateNormal];
    [commentBtn setImage:[UIImage imageNamed:@"icon_collect_selected"] forState:UIControlStateHighlighted];
    
    UIView *rightLineView = [[UIView alloc] init];
    [myView addSubview:rightLineView];
    [rightLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topImgV.mas_bottom);
        make.right.equalTo(_topImgV.mas_right);
        make.bottom.equalTo(self.mas_bottom);
        make.width.mas_equalTo(0.5);
    }];
    rightLineView.backgroundColor = [UIColor colorWithHexStr:@"#666666"];
    
    UIView *leftLineView = [[UIView alloc] init];
    [myView addSubview:leftLineView];
    [leftLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topImgV.mas_bottom);
        make.left.equalTo(_topImgV.mas_left);
        make.bottom.equalTo(self.mas_bottom);
        make.width.mas_equalTo(0.5);
    }];
    leftLineView.backgroundColor = [UIColor colorWithHexStr:@"#666666"];
    
    UIView *bottomLineView = [[UIView alloc] init];
    [myView addSubview:bottomLineView];
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_bottom);
        make.left.equalTo(_topImgV.mas_left);
        make.right.equalTo(_topImgV.mas_right);
        make.height.mas_equalTo(0.5);
    }];
    bottomLineView.backgroundColor = [UIColor colorWithHexStr:@"#666666"];
}
@end
