//
//  CustomCollectionViewCell.m
//  YJBannerViewDemo
//
//  Created by YJHou on 2017/7/4.
//  Copyright © 2017年 地址:https://github.com/YJManager/YJBannerViewOC . All rights reserved.
//

#import "CustomCollectionViewCell.h"

@implementation CustomCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    _imageView = [UIImageView new];
    _imageView.layer.borderColor = [[UIColor redColor] CGColor];
    _imageView.layer.borderWidth = 2;
    [self.contentView addSubview:_imageView];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    _imageView.frame = self.bounds;
}


@end
