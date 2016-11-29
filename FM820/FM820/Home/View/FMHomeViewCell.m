//
//  FMHomeViewCell.m
//  FM820
//
//  Created by garfie on 16/10/18.
//  Copyright © 2016年 Shirley. All rights reserved.
//

#import "FMHomeViewCell.h"
#import "HomePageCellModel.h"

@interface FMHomeViewCell ()

@end
@implementation FMHomeViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewRowAnimationNone;

// 背景view
        UIView *myView = [[UIView alloc] init];
        [self addSubview:myView];
        [myView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(10);
            make.left.equalTo(self.mas_left).offset(10);
            make.width.mas_equalTo(SCREEN_WIDTH - 20);
            make.bottom.equalTo(self.mas_bottom);
        }];

        // 顶部imgv
        [myView addSubview:self.topImage];
        [self.topImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(myView.mas_top).offset(0);
            make.left.and.right.equalTo(myView);
            make.height.mas_equalTo(266);
        }];

        // 小圆圈
        self.contentCellSmallImg = [[UIImageView alloc] init];
        [myView addSubview:self.contentCellSmallImg];
        [_contentCellSmallImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(_topImage.mas_leading).offset(10);
            make.top.equalTo(_topImage.mas_bottom).offset(15);
            make.size.mas_equalTo(CGSizeMake(15, 15));
        }];
        _contentCellSmallImg.image = [[UIImage imageNamed:@"icon_8_selected"] circleImage] ;

        // iGlobal
        self.contentCelliGlobal = [[UILabel alloc] init];
        [myView addSubview:self.contentCelliGlobal];
        [self.contentCelliGlobal mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_contentCellSmallImg.mas_right).offset(5);
            make.top.equalTo(_topImage.mas_bottom).offset(15);
            make.right.equalTo(_topImage.mas_right).offset(-10);
        }];
        self.contentCelliGlobal.font = TXT_SIZE_13;
        self.contentCelliGlobal.text = @"iGlobal";
        
        // 中间label
        self.contentCellTopBigLabel = [[UILabel alloc] init];
        [myView addSubview:_contentCellTopBigLabel];
        [_contentCellTopBigLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(_topImage.mas_leading).offset(10);
            make.top.equalTo(_contentCellSmallImg.mas_bottom).offset(5);
            make.trailing.equalTo(self.topImage.mas_trailing).offset(-10);
            
        }];
        self.contentCellTopBigLabel.numberOfLines = 0;
        self.contentCellTopBigLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _contentCellTopBigLabel.font = TXT_SIZE_18;
        _contentCellTopBigLabel.text = @"童年.暮年.夏爱了上架法拉盛解放了开发法拉盛减肥的案例三姐夫";
        
        self.contentTextLabel = [[UILabel alloc] init];
        [myView addSubview:self.contentTextLabel];
        [self.contentTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentCellTopBigLabel.mas_bottom).offset(10);
            make.left.equalTo(self.contentCellTopBigLabel);
            make.right.equalTo(self.topImage.mas_right).offset(-10);
        }];
        self.contentTextLabel.numberOfLines = 0;
        self.contentTextLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.contentTextLabel.font = TXT_SIZE_15;
        self.contentTextLabel.text = @"手机放拉萨积分拉丝机弗拉手机放拉萨积分拉丝机发牢骚积分 失联客机发牢骚积分";
        self.contentTextLabel.textColor = [UIColor colorWithHexStr:@"#666666"];
        
        UIView *lineView = [[UIView alloc] init];
        [myView addSubview: lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentTextLabel.mas_bottom).offset(15);
            make.left.equalTo(myView.mas_left).offset(10);
            make.right.equalTo(myView.mas_right).offset(-10);
            make.height.mas_equalTo(0.5);
        }];
        lineView.backgroundColor = [UIColor colorWithHexStr:@"#e5e5e5"];
        
            // readLabel
            UILabel *readLabel = [[UILabel alloc] init];
            [myView addSubview:readLabel];
            [readLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(lineView.mas_bottom).offset(10);
                make.left.equalTo(lineView.mas_left);
                
            }];
            readLabel.textColor = [UIColor colorWithHexStr:@"#6989AA"];
            readLabel.text = @"阅读";
            readLabel.font = TXT_SIZE_13;
        
            // readCountLabel
            self.readCount = [[UILabel alloc] init];
            [myView addSubview:self.readCount];
            [self.readCount mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(readLabel.mas_top);
                make.left.equalTo(readLabel.mas_right).offset(5);
            }];
            self.readCount.text = @"1234";
            self.readCount.textColor = [UIColor colorWithHexStr:@"#6989AA"];
            self.readCount.font = TXT_SIZE_13;
        
            // transfer
            UIButton *transferBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [myView addSubview:transferBtn];
            [transferBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(readLabel.mas_top);
                make.right.equalTo(myView.mas_right).offset(-45);
                make.size.mas_equalTo(CGSizeMake(14, 14));
            }];
            [transferBtn setImage:[UIImage imageNamed:@"icon_share1_normal"] forState:UIControlStateNormal];
            [transferBtn setImage:[UIImage imageNamed:@"icon_share1_hover"] forState:UIControlStateHighlighted];
        
            // comment
            UIButton *commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [myView addSubview:commentBtn];
            [commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(transferBtn.mas_top);
                make.right.equalTo(transferBtn.mas_left).offset(-42.5);
                make.size.mas_equalTo(CGSizeMake(13, 15));
            }];
            [commentBtn setImage:[UIImage imageNamed:@"icon_collect_normal"] forState:UIControlStateNormal];
            [commentBtn setImage:[UIImage imageNamed:@"icon_collect_selected"] forState:UIControlStateHighlighted];
        
        // line
            UIView *rightLineView = [[UIView alloc] init];
            [myView addSubview:rightLineView];
            [rightLineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_topImage.mas_bottom);
                make.right.equalTo(_topImage.mas_right);
                make.bottom.equalTo(self.mas_bottom);
                make.width.mas_equalTo(0.5);
            }];
            rightLineView.backgroundColor = [UIColor colorWithHexStr:@"#666666"];
        
            UIView *leftLineView = [[UIView alloc] init];
            [myView addSubview:leftLineView];
            [leftLineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_topImage.mas_bottom);
                make.left.equalTo(_topImage.mas_left);
                make.bottom.equalTo(self.mas_bottom);
                make.width.mas_equalTo(0.5);
            }];
            leftLineView.backgroundColor = [UIColor colorWithHexStr:@"#666666"];
        
            UIView *bottomLineView = [[UIView alloc] init];
            [myView addSubview:bottomLineView];
            [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(commentBtn.mas_bottom).offset(14);
                make.left.equalTo(_topImage.mas_left);
                make.right.equalTo(_topImage.mas_right);
                make.height.mas_equalTo(0.5);
            }];
            bottomLineView.backgroundColor = [UIColor colorWithHexStr:@"#666666"];

        
        [myView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(bottomLineView.mas_bottom);
        }];
        [self.superview layoutIfNeeded];

    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setHomePageCellModel:(HomePageCellModel *)homePageCellModel {
    _contentCellTopBigLabel.text = homePageCellModel.title;
    _contentTextLabel.text = homePageCellModel.descs;
    _readCount.text = homePageCellModel.readcount;
    _contentCelliGlobal.text = homePageCellModel.block_name;
    NSURL *logoURL = [NSURL URLWithString:homePageCellModel.post];
    [_topImage sd_setImageWithURL:logoURL placeholderImage:nil];
    NSURL *smalLogoURL = [NSURL URLWithString:homePageCellModel.optionURL];
    [_contentCellSmallImg sd_setImageWithURL:smalLogoURL placeholderImage:nil] ;
    _contentCellSmallImg.layer.cornerRadius = 8.5;
    _contentCellSmallImg.layer.masksToBounds = YES;
}

//@property (strong, nonatomic)  UIImageView *topImage;
//@property (strong, nonatomic)  UILabel *contentTextLabel;
//@property (strong, nonatomic)  UIImageView *contentCellSmallImg;
//@property (strong, nonatomic)  UILabel *contentCelliGlobal;
//@property (strong, nonatomic)  UILabel *contentCellTopBigLabel;
//@property (strong, nonatomic)  UILabel *readCount;
-(UIImageView *)topImage {
    if (!_topImage) {
        _topImage = [[UIImageView alloc] init];
    }
    
    return _topImage;
}
@end
