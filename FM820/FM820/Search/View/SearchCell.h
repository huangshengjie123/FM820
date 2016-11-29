//
//  SearchCell.h
//  FM820
//
//  Created by huangshengjie on 16/11/14.
//  Copyright © 2016年 Shirley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchModel.h"
@interface SearchCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *centryImageView;

@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) SearchModel *searchModel;
@end
