//
//  FavoriteTableViewCell.h
//  FM820
//
//  Created by 石芸蕾 on 16/11/2.
//  Copyright © 2016年 Shirley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FavoriteModel.h"

@interface FavoriteTableViewCell : UITableViewCell

- (void)loadDataFromModel:(FavoriteModel *)model;

- (void)createIconFromModel:(FavoriteModel *)model;




@end
