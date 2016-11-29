//
//  FMcolorEgg.m
//  
//
//  Created by garfie on 16/11/7.
//
//

#import "FMcolorEgg.h"

@interface FMcolorEgg ()
@property (nonatomic, strong) NSMutableDictionary *colorEggIconDic;
@property (nonatomic, strong) NSMutableArray *imvArray;
@property (nonatomic, strong) UIImageView *eachTick;
@end

@implementation FMcolorEgg

- (NSMutableDictionary *)colorEggIconDic {
    if (!_colorEggIconDic) {
         _colorEggIconDic = [NSMutableDictionary dictionary];
        for (int i = 0; i < 8; i++) {
            NSString *str = [NSString stringWithFormat:@"icon_finished%d", i+1];
            UIImage *iconImg = [UIImage imageNamed:str];
            NSString *key = [NSString stringWithFormat:@"%d", i];
            [_colorEggIconDic setObject:iconImg forKey:key];
        }
    }
    return _colorEggIconDic;
}

- (instancetype)initWithColorEggIconArray:(NSMutableArray *)colorEggIconArray{
    if (self = [super init]) {
        
        [self setupColorEggAndColorEggIconArray:colorEggIconArray];
    }
    return self;
}

- (void) setupColorEggAndColorEggIconArray:(NSMutableArray *)colorEggIconArray{
    UIView *colorEggbackView = [[UIView alloc] init];
    [self addSubview:colorEggbackView];
    [colorEggbackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(SCREEN_WIDTH - 10);
    }];
    
    self.backImv = [[UIImageView alloc] init];
    [colorEggbackView addSubview:self.backImv];
    [self.backImv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(colorEggbackView);
    }];
    
    
    UIView *upBackImgView = [[UIView alloc] init];
    [self.backImv addSubview:upBackImgView];
    [upBackImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.backImv);
    }];
    upBackImgView.backgroundColor = [UIColor colorWithHexStr:@"#000000" alpha:0.3];
    
    self.smallImv = [[UIImageView alloc] init];
    [self.backImv addSubview:self.smallImv];
    [self.smallImv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backImv.mas_top).offset(35);
        make.centerX.equalTo(self.backImv.mas_centerX);
        make.height.and.width.mas_equalTo(170);
    }];
    self.smallImv.alpha = 0.6;
    self.smallImv.layer.cornerRadius = 85;
    self.smallImv.layer.masksToBounds = YES;
    
    UIImageView *whiteImv = [[UIImageView alloc] init];
    [self.smallImv addSubview:whiteImv];
    [whiteImv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.and.right.equalTo(self.smallImv).insets(UIEdgeInsetsMake(15, 15, 15, 15));
    }];
    whiteImv.layer.cornerRadius = 70;
    whiteImv.layer.masksToBounds = YES;
    whiteImv.backgroundColor = [UIColor colorWithHexStr:@"#ffffff" alpha:0.9];
    
    
    self.currentLabel = [[UILabel alloc] init];
    [whiteImv addSubview:self.currentLabel];
    [self.currentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(whiteImv.mas_centerX).offset(-11);
        make.centerY.equalTo(whiteImv.mas_centerY);
    }];
    self.currentLabel.text = @"5";
    self.currentLabel.font = [UIFont systemFontOfSize:90.0];
    
    UILabel *allLabel = [[UILabel alloc] init];
    [whiteImv addSubview:allLabel];
    [allLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(whiteImv.mas_centerX).offset(24);
        make.centerY.equalTo(whiteImv.mas_centerY).offset(23);
    }];
    allLabel.text = @"/8";
    allLabel.font = TXT_SIZE_15;
    
#pragma mark - 打钩
    UIView *tickView = [[UIView alloc] init];
//    tickView.backgroundColor = [UIColor redColor];
    [self.backImv addSubview:tickView];
    [tickView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.smallImv.mas_bottom).offset(35);
        make.left.and.right.equalTo(self.backImv);
        make.height.mas_equalTo(61);
    }];
    
//    UIView *allLabelView = [[UIView alloc] init];
//    [tickView addSubview:allLabelView];
//    [allLabelView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.right.equalTo(tickView);
//        make.height.mas_equalTo(13);
//    }];
        self.imvArray = [NSMutableArray array];
    for (int i = 1; i <=8; i++) {
        self.readPointDayLabel = [[UILabel alloc] init];
        [tickView addSubview:self.readPointDayLabel];
        [self.readPointDayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(tickView);
            make.left.mas_equalTo((SCREEN_WIDTH - 20)  / 9 *i);
        }];
        self.readPointDayLabel.text = [NSString stringWithFormat:@"%d", i];
        self.readPointDayLabel.textColor = [UIColor whiteColor];
        
        self.eachTick = [[UIImageView alloc] init];
//        [self.imvArray addObject:eachTick];
        [tickView addSubview:self.eachTick];
        [_eachTick mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo((SCREEN_WIDTH - 20)  / 9 *i - 7);
            make.top.equalTo(self.readPointDayLabel.mas_bottom).offset(16);
            make.width.mas_equalTo(23);
            make.height.mas_equalTo(25);
        }];
        
        _eachTick.image = [UIImage imageNamed:@"icon_blank"];
        _eachTick.tag = i;
        [self.imvArray addObject:self.eachTick];
        
        for (int j = 0 ; j < colorEggIconArray.count; j++) {
            NSString *dicKeyString =[NSString stringWithFormat:@"%@", colorEggIconArray[j]];
            NSInteger dicKeyinteger = [dicKeyString integerValue];
            NSInteger lastDicKeyinteger = dicKeyinteger - 1;
            NSString *lastDicKeyString = [NSString stringWithFormat:@"%ld", (long)lastDicKeyinteger];
            if ((i-1) == lastDicKeyinteger) {
                _eachTick.image = [self.colorEggIconDic valueForKey:lastDicKeyString];
            }

        }
    }


//    NSLog(@"%@", self.imvArray);
    
    
    UIView *lineView = [[UIView alloc] init];
    [tickView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(tickView);
        make.height.mas_equalTo(0.5);
        make.top.equalTo(self.readPointDayLabel.mas_bottom).offset(5);
    }];
    lineView.backgroundColor = [UIColor colorWithHexStr:@"#ffffff"];
    
    self.haveReadCountLabel = [[UILabel alloc] init];
    [tickView addSubview:self.haveReadCountLabel];
    [self.haveReadCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(-22);
        make.centerX.equalTo(self.mas_centerX);
    }];
    self.haveReadCountLabel.font = TXT_SIZE_15;
    self.haveReadCountLabel.textColor = [UIColor colorWithHexStr:@"#ffffff"];
    self.haveReadCountLabel.text = @"今日2314人已读完";
}

@end
