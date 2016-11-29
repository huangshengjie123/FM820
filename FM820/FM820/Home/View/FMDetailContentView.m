//
//  FMDetailContentView.m
//  FM820
//
//  Created by garfie on 16/11/9.
//  Copyright © 2016年 Shirley. All rights reserved.
//

#import "FMDetailContentView.h"
#import <WebKit/WebKit.h>

@interface FMDetailContentView () <UIWebViewDelegate>
@property (nonatomic, strong) UIImageView *topImv;
@property (nonatomic, strong) UIImageView *circleImgV;
@property (nonatomic, strong) UILabel *smallLabel;
@property (nonatomic, strong) UILabel *middleLabel;
@property (nonatomic, assign) CGFloat webViewHeight;


@end

@implementation FMDetailContentView

//- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
//    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        [self createSubView];
//        [self layoutView];
//    }
//    return self;
//}

//- (void)layoutSubviews {
//            [self createSubView];
//            [self layoutView];
//}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
                    [self createSubView];
                    [self layoutView];
    }
    return self;
}

- (void)createSubView {
     [self addSubview:self.topImv];
     [self addSubview:self.circleImgV];
     [self addSubview:self.smallLabel];
     [self addSubview:self.middleLabel];
     [self addSubview:self.introduceLabel];
     [self addSubview:self.iconImv];
     [self addSubview:self.webView];
     [self addSubview:self.lineView];
}

#pragma mark - 布局子控件

- (void)layoutView {
    [self.topImv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.top.equalTo(self.mas_top);
        make.height.mas_equalTo(281);
    }];
    
    [_circleImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topImv.mas_left).offset(20);
        make.top.equalTo(self.topImv.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    
    [self.smallLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.circleImgV.mas_right).offset(5);
        make.top.equalTo(self.topImv.mas_bottom).offset(10);
    }];
    


    [_middleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topImv.mas_left).offset(20);
        make.top.equalTo(self.circleImgV.mas_bottom).offset(10);
        make.right.equalTo(_topImv.mas_right).offset(-20);
    }];
    
    [_introduceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topImv.mas_left).offset(20);
        make.top.equalTo(self.middleLabel.mas_bottom).offset(10);
        make.right.equalTo(self.middleLabel.mas_right);
    }];
    
    [_iconImv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.introduceLabel.mas_bottom).offset(25);
        make.left.equalTo(self.introduceLabel);
        make.size.mas_equalTo(CGSizeMake(150, 4));
    }];
    

    [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconImv.mas_bottom).offset(25);
        make.left.equalTo(self.introduceLabel.mas_left);
        make.right.equalTo(self.introduceLabel.mas_right);
        make.height.mas_equalTo(110);
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.webView.mas_bottom).offset(-15);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(0.5);
    }];
    
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.lineView.mas_bottom).offset(-1);
    }];
    [self.superview layoutIfNeeded];

}


#pragma mark - 懒加载视图控件

- (UIImageView *)topImv {
    if (!_topImv) {
        _topImv = [FMUIHelper getImageViewImage:nil];
        self.topImv.image = [UIImage imageNamed:@"testImage1"];
    }
    return _topImv;
}

// 小圆圈
- (UIImageView *)circleImgV {
    if (!_circleImgV) {
        _circleImgV = [FMUIHelper getImageViewImage:nil];
        _circleImgV.image = [[UIImage imageNamed:@"icon_2_selected"] circleImage] ;
    }
    return _circleImgV;
}
    // iGlobal
- (UILabel *)smallLabel {
    if (!_smallLabel) {
        _smallLabel = [FMUIHelper getLabel:TXT_SIZE_14 andTextColor:[UIColor blackColor]];
        self.smallLabel.text = @"iGlobal";
    }
    return _smallLabel;
}

 // 中间label
- (UILabel *)middleLabel {
    if (!_middleLabel) {
        _middleLabel = [FMUIHelper getLabel:@"童年.暮年.夏" andFont:TXT_SIZE_24 andTextColor: [UIColor blackColor]];
    }
    return _middleLabel;
}

    // 文章介绍
-(UILabel *)introduceLabel {
    if (!_introduceLabel) {
        _introduceLabel = [FMUIHelper getLabel:@"阿斯兰的进口方来刷卡缴费了上架法拉盛就交罚款了是解放啦asljdf lasjf lalsjf元帅死垃圾开发拉克丝" andFont:TXT_SIZE_15 andTextColor: [UIColor colorWithHexStr:@"#999999"]];
        self.introduceLabel.numberOfLines = 0;
        self.introduceLabel.lineBreakMode = NSLineBreakByWordWrapping;
    }
    return _introduceLabel;
}

// 横条icon
- (UIImageView *)iconImv {
    if (!_iconImv) {
        _iconImv = [FMUIHelper getImageViewImage:[UIImage imageNamed:@"image_essay line"]];
    }
    return _iconImv;
}

// labelView
-(UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] init];
        _webView.delegate = self;
        //        NSString *webURLString = @"http://121.41.73.190/?r=h5/h5protocol";
        //        NSString * htmlcontent = [NSString stringWithFormat:@"<div id=\"webview_content_wrapper\">%@</div>", webURLString];
        //        [_webView loadHTMLString:htmlcontent baseURL:nil];
        //
        NSURL *webURL = [NSURL URLWithString:@"http://121.41.73.190/?r=h5/h5protocol"];
        NSData *data = [[NSData alloc] initWithContentsOfURL:webURL options:0 error:nil];
        [self.webView loadData:data MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:webURL];
        //        _webView.scrollView.bounces = NO;
        //        _webView.scrollView.showsHorizontalScrollIndicator = NO;
        //        _webView.scrollView.scrollEnabled = NO;
    }
    return _webView;
}

- (UIView *)lineView {
    if (!_lineView) {
        self.lineView = [[UIView alloc] init];
        self.lineView.backgroundColor = [UIColor colorWithHexStr:@"#E5E5E5"];
    }
    return _lineView;
}


- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    //    CGRect newFrame = webView.frame;
    //    newFrame.size.height = self.webViewHeight;
    //    webView.frame = newFrame;
    [webView mas_updateConstraints:^(MASConstraintMaker *make) {
        self.webViewHeight = [webView.scrollView contentSize].height;
    }];
    [webView.superview layoutIfNeeded];
}


@end
