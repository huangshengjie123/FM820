//
//  SaySomethingCell.m
//  FM820
//
//  Created by huangshengjie on 16/11/15.
//  Copyright © 2016年 Shirley. All rights reserved.
//

#import "SaySomethingCell.h"

@interface SaySomethingCell ()
@property (weak, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UIImageView *topImageView;
@property (weak, nonatomic) IBOutlet UIButton *digitBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *rightImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@property (weak, nonatomic) IBOutlet UIImageView *imageView3;
@property (weak, nonatomic) IBOutlet UIImageView *imageView4;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label4;
@property (weak, nonatomic) IBOutlet UILabel *readLabel;
@property (weak, nonatomic) IBOutlet UILabel *readCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *collectBtn;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIView *smallLineView;
@property (nonatomic, strong) NSMutableArray * commentArray;
@property (nonatomic, strong) NSMutableArray * optionArray;
@end
@implementation SaySomethingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _view.layer.borderWidth = 0.4;
    _view.layer.borderColor = [UIColor lightGrayColor].CGColor;
    if (_commentArray == nil)
    {
        _commentArray = [[NSMutableArray alloc]init];
    }
    if (_optionArray == nil)
    {
        _optionArray = [[NSMutableArray alloc]init];
    }
    
}

-(void)setArtSearchModel:(ArtSearchModel *)artSearchModel
{
    _artSearchModel = artSearchModel;
    // 图片
    [_topImageView sd_setImageWithURL:[NSURL URLWithString:artSearchModel.post] placeholderImage:nil];
    // 主标题
    _titleLabel.text = artSearchModel.block_name;

    // 内容
    _nameLabel.text = artSearchModel.descs;
    // 阅读次数
    _readCountLabel.text = [artSearchModel.readcount stringValue];
    // 评论区
    if (artSearchModel.comments.count > 0 )
    {
        _smallLineView.hidden = YES;
        _commentArray = [CommentModel mj_objectArrayWithKeyValuesArray:artSearchModel.comments];
        for (int i = 0; i < _commentArray.count; i++)
        {
            CommentModel * model =_commentArray[i];
            if (i==0)
            {
                _label1.text = model.informations;
                _imageView1.image = [UIImage imageNamed:@"icon_2_normal"];
            }
            if (i==1)
            {
                _label2.text = model.informations;
                _imageView2.image = [UIImage imageNamed:@"icon_2_normal"];
            }
            if (i==2)
            {
                _label3.text = model.informations;
                _imageView3.image = [UIImage imageNamed:@"icon_2_normal"];
            }
            if (i==3)
            {
                _label4.text = model.informations;
                _imageView4.image = [UIImage imageNamed:@"icon_2_normal"];
            }
            if (_commentArray.count < 4) {
                [_backView mas_makeConstraints:^(MASConstraintMaker *make)
                 {
                     make.height.offset(180 - 30 * (4 - _commentArray.count));
                     
                 }];

                
            }


        }
    
    }
    
    // 投票单独的
    else if (artSearchModel.options.count > 0)
    {
        _titleLabel.text = artSearchModel.content;
         _nameLabel.text = artSearchModel.title;
        _rightImageView.image = [UIImage imageNamed:@"icon_toupiao_normal"];
        _smallLineView.hidden = YES;
        _optionArray = [OptionsModel mj_objectArrayWithKeyValuesArray:artSearchModel.options];
        for (int i = 0; i < artSearchModel.options.count; i++)
        {
            OptionsModel * model =_optionArray[i];
            if (i==0)
            {
                _label1.text = model.optiontitle;
                _imageView1.image = [UIImage imageNamed:@"icon_2_normal"];
            }
            if (i==1)
            {
                _label2.text = model.optiontitle;
                _imageView2.image = [UIImage imageNamed:@"icon_2_normal"];
            }
            if (i==2)
            {
                _label3.text = model.optiontitle;
                _imageView3.image = [UIImage imageNamed:@"icon_2_normal"];
            }
            if (i==3)
            {
                _label4.text = model.optiontitle;
                _imageView4.image = [UIImage imageNamed:@"icon_2_normal"];
            }
            if (_optionArray.count < 4) {
                [_backView mas_makeConstraints:^(MASConstraintMaker *make)
                 {
                     make.height.offset(180 - 30 * (4 - _commentArray.count));
                     
                 }];
                
                
            }
            

       }
    }
    else
    {
        _smallLineView.hidden = NO;
        for (UIView * view  in _backView.subviews)
        {
            [view removeFromSuperview];
        }
        [_backView mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.height.offset(0);
             
         }];
    }
    
}
- (IBAction)collectBtn:(id)sender {
}
- (IBAction)shareBtn:(id)sender {
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
