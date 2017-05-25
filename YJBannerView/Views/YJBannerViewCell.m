//
//  YJBannerViewCell.m
//  YJBannerViewDemo
//
//  Created by YJHou on 2014/5/24.
//  Copyright © 2014年 地址:https://github.com/YJManager/YJBannerViewOC . All rights reserved.
//

#import "YJBannerViewCell.h"
#import "UIView+YJBannerViewExt.h"
#import <UIImageView+WebCache.h>

@interface YJBannerViewCell ()

@property (nonatomic, strong) UIImageView *showImageView; /**< 显示图片 */
@property (nonatomic, strong) UILabel *titleLabel; /**< 标题头 */

@end

@implementation YJBannerViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self _setUpMainView];
    }
    return self;
}

- (void)_setUpMainView{
    [self.contentView addSubview:self.showImageView];
    [self.contentView addSubview:self.titleLabel];
}

- (void)setTitleLabelBackgroundColor:(UIColor *)titleLabelBackgroundColor{
    _titleLabelBackgroundColor = titleLabelBackgroundColor;
    self.titleLabel.backgroundColor = titleLabelBackgroundColor;
}

- (void)setTitleLabelTextColor:(UIColor *)titleLabelTextColor{
    _titleLabelTextColor = titleLabelTextColor;
    self.titleLabel.textColor = titleLabelTextColor;
}

- (void)setTitleLabelTextFont:(UIFont *)titleLabelTextFont{
    _titleLabelTextFont = titleLabelTextFont;
    self.titleLabel.font = titleLabelTextFont;
}

-(void)setTitleLabelTextAlignment:(NSTextAlignment)titleLabelTextAlignment{
    _titleLabelTextAlignment = titleLabelTextAlignment;
    self.titleLabel.textAlignment = titleLabelTextAlignment;
}

- (void)setShowImageViewContentMode:(UIViewContentMode)showImageViewContentMode{
    _showImageViewContentMode = showImageViewContentMode;
    self.showImageView.contentMode = showImageViewContentMode;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    if (self.onlyDisplayText) {
        self.titleLabel.frame = self.bounds;
    } else {
        self.showImageView.frame = self.bounds;
        CGFloat titleLabelW = self.width_bannerView;
        CGFloat titleLabelH = self.titleLabelHeight;
        CGFloat titleLabelX = 0;
        CGFloat titleLabelY = self.height_bannerView - titleLabelH;
        _titleLabel.frame = CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH);
    }
}

#pragma mark - 刷新数据
- (void)cellWithBannerViewImagePath:(NSString *)imagePath placeholderImage:(UIImage *)placeholderImage title:(NSString *)title{

    if (imagePath) {
        self.showImageView.hidden = NO;
        if (!self.onlyDisplayText && [imagePath isKindOfClass:[NSString class]]) {
            if ([imagePath hasPrefix:@"http"]) {
                [self.showImageView sd_setImageWithURL:[NSURL URLWithString:imagePath] placeholderImage:placeholderImage];
            } else {
                UIImage *image = [UIImage imageNamed:imagePath];
                if (!image) {
                    image = [UIImage imageWithContentsOfFile:imagePath];
                }
                self.showImageView.image = image;
            }
        } else if (!self.onlyDisplayText && [imagePath isKindOfClass:[UIImage class]]) {
            self.showImageView.image = (UIImage *)imagePath;
        }else{
            self.showImageView.image = placeholderImage;
        }
    }else{
        self.showImageView.hidden = YES;
    }
    
    if (title.length > 0) {
        self.titleLabel.text = title;
        self.titleLabel.hidden = NO;
    }else{
        self.titleLabel.hidden = YES;
    }
}

#pragma mark - Lazy
- (UIImageView *)showImageView{
    if (!_showImageView) {
        _showImageView = [[UIImageView alloc] init];
    }
    return _showImageView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.hidden = YES;
    }
    return _titleLabel;
}


@end
