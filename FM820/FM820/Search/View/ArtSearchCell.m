//
//  ArtSearchCell.m
//  FM820
//
//  Created by huangshengjie on 16/11/15.
//  Copyright © 2016年 Shirley. All rights reserved.
//

#import "ArtSearchCell.h"

@interface ArtSearchCell()

@property (weak, nonatomic) IBOutlet UIImageView *topImageView;
@property (weak, nonatomic) IBOutlet UILabel *weakLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UILabel *readLabel;
@property (weak, nonatomic) IBOutlet UILabel *readCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *collectBtn;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet UIView *backView;



@end
@implementation ArtSearchCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _backView.layer.borderWidth = 0.4;
    _backView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
}

-(void)setArtSearchModel:(ArtSearchModel *)artSearchModel
{
    // 图片
    [_topImageView sd_setImageWithURL:[NSURL URLWithString:artSearchModel.post] placeholderImage:nil];
    // 主标题
    _titleLabel.text = artSearchModel.block_name;
    // 内容
    _detailLabel.text = artSearchModel.descs;
    // 阅读次数
    _readCountLabel.text = [artSearchModel.readcount stringValue];
    // 日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSDate* inputDate = [dateFormatter dateFromString:artSearchModel.publishtime];
    // 日期
    NSDateFormatter *outputFormatter= [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"yyyy.MM.dd"];
    NSString *str1 = [outputFormatter stringFromDate:inputDate];
    _dateLabel.text = str1;
    // 星期（英文）
    [outputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [outputFormatter setDateFormat:@"EEEE"];
    NSString *str2 = [outputFormatter stringFromDate:inputDate];
    _weakLabel.text = str2;
    
    
}
- (IBAction)collectBtn:(id)sender
{
    _collectBtn.selected = !_collectBtn.selected;
}
- (IBAction)shareBtn:(id)sender
{
    _shareBtn.selected = !_shareBtn.selected;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];


}

@end
