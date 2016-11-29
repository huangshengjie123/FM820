//
//  FMCommentDetailViewCell.m
//  FM820
//
//  Created by garfie on 16/11/11.
//  Copyright © 2016年 Shirley. All rights reserved.
//

#import "FMCommentDetailViewCell.h"

@interface FMCommentDetailViewCell ()
@property (nonatomic, strong) UIView *backgrdView;
@property (nonatomic, strong) UIImageView *iconImV;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *likeCountLabel;
@property (nonatomic, strong) UIButton *likeButton;
@end
@implementation FMCommentDetailViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews {
    // 自定义背景view
    self.backgrdView= [[UIView alloc] init];
    self.backgrdView.backgroundColor = [UIColor colorWithHexStr:@"#f5f8f9"];
    [self addSubview:self.backgrdView];
    [self.backgrdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(10, 20, 0, 20));
    }];
    self.backgrdView.layer.cornerRadius = 5.0;
    self.backgrdView.layer.masksToBounds = YES;
    
    // 头像
    self.iconImV = [FMUIHelper getImageViewImage:nil];
    [self.backgrdView addSubview:self.iconImV];
    [self.iconImV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backgrdView.mas_top).offset(10);
        make.left.equalTo(self.backgrdView.mas_left).offset(10);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    self.iconImV.backgroundColor = [UIColor blueColor];
    
//     nickName
    self.nameLabel = [FMUIHelper getLabel:TXT_SIZE_17 andTextColor:[UIColor colorWithHexStr:@"#6788A8"]];
    [self.backgrdView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backgrdView.mas_top).offset(12.5);
        make.left.equalTo(self.iconImV.mas_right).offset(10);
    }];
    self.nameLabel.text = @"Garfie";
    
    //timeLabel
    self.timeLabel = [FMUIHelper getLabel:@"5分钟前" andFont:TXT_SIZE_13 andTextColor:[UIColor colorWithHexStr:@"#999999"]];
    [self.backgrdView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).offset(-5);
        make.left.equalTo(self.nameLabel);
    }];
    
    //likeCount
    self.likeButton = [FMUIHelper getButtonWithImage:[UIImage imageNamed:@"icon_zan_normal"] selectImage:[UIImage imageNamed:@"icon_zan_selected"]];
    [self.backgrdView addSubview:self.likeButton];
    [self.likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.backgrdView.mas_right).offset(10);
        make.top.equalTo(self.backgrdView.mas_top).offset(20);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    
    // likeCountLabel
    self.likeCountLabel = [FMUIHelper getLabel:@"1234" andFont:TXT_SIZE_14 andTextColor:[UIColor colorWithHexStr:@"90A7BE"]];
    [self.backgrdView addSubview:self.likeCountLabel];
    [self.likeCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.likeButton.mas_left).offset(-5);
        make.bottom.equalTo(self.likeButton.mas_bottom);
    }];
    
    // message
    self.contentLabel = [FMUIHelper getLabel:@"奥斯卡法律是放假 撒娇法律是发动机阿斯利康加菲奥拉夫按时缴费" andFont:TXT_SIZE_15  andTextColor:[UIColor colorWithHexStr:@"#333333"]];
    [self.backgrdView addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImV.mas_left);
        make.top.equalTo(self.iconImV.mas_bottom).offset(-10);
        make.right.equalTo(self.backgrdView.mas_right).offset(-15);
        make.bottom.equalTo(self.backgrdView.mas_bottom).offset(10);
    }];
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    [self.backgrdView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentLabel.mas_bottom);
    }];
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
