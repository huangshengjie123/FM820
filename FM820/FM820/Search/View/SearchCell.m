//
//  SearchCell.m
//  FM820
//
//  Created by huangshengjie on 16/11/14.
//  Copyright © 2016年 Shirley. All rights reserved.
//

#import "SearchCell.h"

@implementation SearchCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // 关闭用户交互
    self.backImageView.userInteractionEnabled = NO;
    self.nameLabel.userInteractionEnabled = NO;
    self.centryImageView.userInteractionEnabled = NO;
    self.centryImageView.layer.cornerRadius = 55/2;
    self.centryImageView.clipsToBounds = YES;
}

-(void)setSearchModel:(SearchModel *)searchModel
{
    // 中间logo
    [self.centryImageView sd_setImageWithURL:[NSURL URLWithString:searchModel.iconurl] placeholderImage:nil];
    // 名字
    self.nameLabel.text = searchModel.name;
    if ([[searchModel.pid stringValue] isEqualToString:@"8"])
    {
        self.nameLabel.text = @"说点什么";
    }
    // 背景图片
    [self.backImageView sd_setImageWithURL:[NSURL URLWithString:searchModel.posturl] placeholderImage:nil];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
