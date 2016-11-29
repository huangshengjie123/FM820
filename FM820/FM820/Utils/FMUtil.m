//
//  FMUtil.m
//  FM820
//
//  Created by 石芸蕾 on 16/10/16.
//  Copyright © 2016年 Shirley. All rights reserved.
//

#import "FMUtil.h"

@implementation FMUtil

+(UILabel *)createLabelFrame:(CGRect)frame title:(NSString *)title
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = title;
    return label;
}

+ (UILabel *)createLabelFrame:(CGRect)frame attributeString:(NSString *)titleString
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate* inputDate = [dateFormatter dateFromString:titleString];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [dateFormatter setDateFormat:@"MMM. d  EEEE"];
    NSString *str = [dateFormatter stringFromDate:inputDate];
    NSDictionary *attributeDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                   
                                   [UIFont systemFontOfSize:17.0],NSFontAttributeName,
                                   
                                   RegisterNameColor,NSForegroundColorAttributeName,
                                   
                                   @0.1 ,NSObliquenessAttributeName
                                   ,nil];
    
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:str attributes:attributeDict];
    
    label.attributedText = AttributedStr;
    label.font = [UIFont fontWithName:@"Zapfino" size:11];
    return label;
}

+ (UIButton *)createBtnFrame:(CGRect)frame title:(NSString *)title bgImage:(NSString *)bgImage target:(id)target action:(SEL)action
{
    UIButton *btn = [[UIButton alloc]initWithFrame:frame];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    if (bgImage) {
        [btn setBackgroundImage:[UIImage imageNamed:bgImage] forState:UIControlStateNormal];
    }
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

+ (UIImageView *)createImageViewFrame:(CGRect)frame imageName:(NSString *)imageName
{
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:frame];
    if (imageName) {
        imgView.image = [UIImage imageNamed:imageName];
    }
    return imgView;
}




+ (UILabel *)addFMNavTitle:(NSString *)title
{
    UILabel *label = [FMUtil createLabelFrame:CGRectMake(100, 0, 175, 44) title:title];
    //居中对齐
    label.textAlignment = NSTextAlignmentCenter;
    label.font = TXT_SIZE_18;
    label.textColor = NavTitleColor;
    
    return label;
    
    //    self.navigationItem.titleView = label;
}

+ (UIButton *)addFMNavBtn:(NSString *)title isLeft:(BOOL)isLeft target:(id)target action:(SEL)action bgImageName:(NSString *)bgImageName
{
    //创建按钮
    UIButton *btn = [FMUtil createBtnFrame:CGRectMake(0, 0, 20, 20) title:title bgImage:bgImageName target:target action:action];
    
    //    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    //    if (isLeft) {
    //        //左边
    //        self.navigationItem.leftBarButtonItem = item;
    //    }else{
    //        //右边
    //        self.navigationItem.rightBarButtonItem = item;
    //    }
    
    return btn;
}


////返回按钮
//+ (UIButton *)addNavBackButtonTarget:(id)target action:(SEL)action
//{
//    [FMUtil addFMNavBtn:@"返回" isLeft:YES target:target action:action bgImageName:@"buttonbar_back"];
//}




@end
