//
//  FMHomeViewCell.h
//  FM820
//
//  Created by garfie on 16/10/18.
//  Copyright © 2016年 Shirley. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HomePageCellModel;

@interface FMHomeViewCell : UITableViewCell

@property (strong, nonatomic)  UIImageView *topImage;
@property (strong, nonatomic)  UILabel *contentTextLabel;
@property (strong, nonatomic)  UIImageView *contentCellSmallImg;
@property (strong, nonatomic)  UILabel *contentCelliGlobal;
@property (strong, nonatomic)  UILabel *contentCellTopBigLabel;
@property (strong, nonatomic)  UILabel *readCount;

@property (nonatomic, strong) HomePageCellModel *homePageCellModel;


@end
