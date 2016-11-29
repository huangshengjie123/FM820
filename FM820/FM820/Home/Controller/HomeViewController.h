//
//  HomeViewController.h
//  FM820
//
//  Created by 石芸蕾 on 16/10/16.
//  Copyright © 2016年 Shirley. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HomePageCellModel;

@interface HomeViewController : UIViewController

@property (nonatomic, strong)NSMutableArray<HomePageCellModel *> *homePageCellModel;

@end
