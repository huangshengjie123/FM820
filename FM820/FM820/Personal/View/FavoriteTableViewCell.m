//
//  FavoriteTableViewCell.m
//  FM820
//
//  Created by 石芸蕾 on 16/11/2.
//  Copyright © 2016年 Shirley. All rights reserved.
//

#import "FavoriteTableViewCell.h"
#import "User.h"

#define MeeColor(r,g,b) [UIColor colorWithRed:(r)/255.0  green:(g)/255.0  blue:(b)/255.0  alpha:1.0]
#define MeeColorA(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]

@interface FavoriteTableViewCell ()

@property (weak, nonatomic) IBOutlet UIView *backView;

@property (weak, nonatomic) IBOutlet UIImageView *rightImageView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIImageView *optionImageView;
@property (weak, nonatomic) IBOutlet UILabel *sectionLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *readLabel;
@property (weak, nonatomic) IBOutlet UIImageView *collectImageView;
@property (weak, nonatomic) IBOutlet UILabel *readcountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *shareImageview;

//存储小图标数组
@property (nonatomic,strong) NSMutableArray *iconArr;
//存储颜色数组
@property (nonatomic, strong) NSArray *colorArray;


@property (nonatomic, strong) AFHTTPSessionManager *fmManager;

@property (nonatomic, strong) User *user;


@end

@implementation FavoriteTableViewCell

- (void)loadDataFromModel:(FavoriteModel *)model{
    //依次赋值
    
    
    _sectionLabel.text = model.block_name;
//    int j = [(model.dayorder) intValue];
//    _sectionLabel.textColor = self.colorArray[j-1];
    
    _titleLabel.text = model.title;
    // 调整行间距
    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:model.title];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:4];
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [model.title length])];
    [self.titleLabel setAttributedText:attributedString1];
    [self.titleLabel sizeToFit];
    
    [_rightImageView sd_setImageWithURL:[NSURL URLWithString:model.posturl]];
    _readcountLabel.text = [NSString stringWithFormat:@"%@",model.readcount];

}

-(AFHTTPSessionManager *)manager {
    if (!_fmManager) {
        self.fmManager = [AFHTTPSessionManager manager];
    }
    return _fmManager;
}

#pragma mark -获取小图标
- (void)createIconFromModel:(FavoriteModel *)model{
    
    _iconArr = [NSMutableArray array];
    
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    self.user = [User shareUser];
    //    dic[@"user_id"] = self.user.userId;
    //    dic[@"sid"] = self.user.sid;
    dic[@"user_id"] = @"1";
    dic[@"sid"] = @"1";
    
    [_fmManager POST:@"http://120.26.112.49:8000/config/list" parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *arr =  [responseObject[@"msg"][@"tag"] mutableCopy];

        for (NSDictionary *dict in arr) {
            if ([ dict[@"category"] isEqualToString:@"TAG" ]) {
                [self.iconArr addObject:dict[@"option"]];
                
            }
        }
        

        int i = [(model.dayorder) intValue];
        [_optionImageView sd_setImageWithURL:[NSURL URLWithString:self.iconArr[i-1]]];
     
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"error");
    }];
    
    
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

// 重写layoutSubviews方法，实现左滑删除按钮自定义
-(void)layoutSubviews
{
    [super layoutSubviews];
    for (UIView *subView in self.subviews)
    {
        if([subView isKindOfClass:NSClassFromString(@"UITableViewCellDeleteConfirmationView")])
        {

            UIView *shareConfirmationView = subView.subviews[0];
            shareConfirmationView.backgroundColor = VcBgColor;
            for (UIView *shareView in shareConfirmationView.subviews) {
                UIImageView *shareImage = [[UIImageView alloc] init];
                shareImage.contentMode = UIViewContentModeScaleAspectFit;
                shareImage.image = [UIImage imageNamed:@"buttn_delete_normal"];
                shareImage.frame = CGRectMake(0, -20, 40, 40);
                [shareView addSubview:shareImage];
            }
        }
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleDefault;
    [_rightImageView mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.width.offset(W(179));

     }];
    [_shareImageview mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(_collectImageView.mas_right).with.offset(W(30));
     }];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
