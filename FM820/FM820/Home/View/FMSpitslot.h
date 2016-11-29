//
//  FMSpitslot.h
//  FM820
//
//  Created by garfie on 16/10/26.
//  Copyright © 2016年 Shirley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FMSpitslot : UIView
@property (nonatomic, strong)UILabel *readCountLabel;
@property (nonatomic, strong)UIImageView *topImgV;
@property (nonatomic, strong)UIImageView *spitslotImv;
@property (nonatomic, strong)UIImageView *circleImgV;
@property (nonatomic, strong) UILabel *smallLabel;
@property (nonatomic, strong) UILabel *middleLabel;
@property (nonatomic, strong) UILabel *userCommentLabel;
- (instancetype)initWithSpitslotAvatarArray:(NSMutableArray *)avatarArray andSpitslotInformationArray:(NSMutableArray *)informationArray;

@end
