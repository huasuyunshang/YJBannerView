//
//  YJBannerViewCell.m
//  YJBannerViewDemo
//
//  Created by YJHou on 2014/5/24.
//  Copyright © 2014年 地址:https://github.com/YJManager/YJBannerViewOC . All rights reserved.
//

#import "YJBannerViewCell.h"
#import "UIView+YJBannerViewExt.h"

@implementation YJBannerViewCell{
    __weak UILabel *_titleLabel;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupImageView];
        [self setupTitleLabel];
    }
    
    return self;
}

- (void)setTitleLabelBackgroundColor:(UIColor *)titleLabelBackgroundColor{
    _titleLabelBackgroundColor = titleLabelBackgroundColor;
    _titleLabel.backgroundColor = titleLabelBackgroundColor;
}

- (void)setTitleLabelTextColor:(UIColor *)titleLabelTextColor{
    _titleLabelTextColor = titleLabelTextColor;
    _titleLabel.textColor = titleLabelTextColor;
}

- (void)setTitleLabelTextFont:(UIFont *)titleLabelTextFont{
    _titleLabelTextFont = titleLabelTextFont;
    _titleLabel.font = titleLabelTextFont;
}

- (void)setupImageView{
    UIImageView *imageView = [[UIImageView alloc] init];
    _imageView = imageView;
    [self.contentView addSubview:imageView];
}

- (void)setupTitleLabel{
    UILabel *titleLabel = [[UILabel alloc] init];
    _titleLabel = titleLabel;
    _titleLabel.hidden = YES;
    [self.contentView addSubview:titleLabel];
}

- (void)setTitle:(NSString *)title{
    if (title) {
        _title = [title copy];
        _titleLabel.text = [NSString stringWithFormat:@"   %@", title];
        if (_titleLabel.hidden) {
            _titleLabel.hidden = NO;
        }
    }else{
        _titleLabel.hidden = YES;
    }
}

-(void)setTitleLabelTextAlignment:(NSTextAlignment)titleLabelTextAlignment{
    _titleLabelTextAlignment = titleLabelTextAlignment;
    _titleLabel.textAlignment = titleLabelTextAlignment;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    if (self.onlyDisplayText) {
        _titleLabel.frame = self.bounds;
    } else {
        _imageView.frame = self.bounds;
        CGFloat titleLabelW = self.width_bannerView;
        CGFloat titleLabelH = _titleLabelHeight;
        CGFloat titleLabelX = 0;
        CGFloat titleLabelY = self.height_bannerView - titleLabelH;
        _titleLabel.frame = CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH);
    }
}


@end
