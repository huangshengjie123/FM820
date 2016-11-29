//
//  FMcolorEgg.h
//  
//
//  Created by garfie on 16/11/7.
//
// 

#import <UIKit/UIKit.h>
@interface FMcolorEgg : UIView
@property (nonatomic, strong)UILabel *readPointDayLabel;
@property (nonatomic, strong)UIImageView *backImv;
@property (nonatomic, strong)UIImageView *smallImv;
@property (nonatomic, strong)UILabel *currentLabel;
@property (nonatomic, strong)UILabel *haveReadCountLabel;
- (instancetype)initWithColorEggIconArray:(NSMutableArray *)colorEggIconArray;
@end
