//
//  FMpopView.h
//  FM820
//
//  Created by 石芸蕾 on 16/11/7.
//  Copyright © 2016年 Shirley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FMpopView : UIView

@property (strong, nonatomic) UIView * fullView;
@property (strong, nonatomic) UIView * tableView;

-(void)show;

-(void)dismiss;

@end
