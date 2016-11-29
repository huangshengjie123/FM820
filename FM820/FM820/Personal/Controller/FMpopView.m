//
//  FMpopView.m
//  FM820
//
//  Created by 石芸蕾 on 16/11/7.
//  Copyright © 2016年 Shirley. All rights reserved.
//

#import "FMpopView.h"

@implementation FMpopView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.userInteractionEnabled = NO;
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        
        _fullView = [[UIView alloc] initWithFrame:self.frame];
        _fullView.backgroundColor = [UIColor redColor];
        _fullView.alpha = 0.0;
        [self addSubview:_fullView];
        //添加背景图片
        UIImageView *bgImageView = [FMUtil createImageViewFrame:self.frame imageName:@"bg_setup"];
        [_fullView addSubview:bgImageView];
       
        
       
        
    }
    return self;
}

-(void)show{
    [UIView animateWithDuration:0.2 animations:^{
        self.fullView.alpha = 0.9;
    } completion:^(BOOL finished) {
        self.userInteractionEnabled = YES;
    }];
}

-(void)dismiss{
    [UIView animateWithDuration:0.2 animations:^{
        self.fullView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)even{
//    [self dismiss];
//}


@end
