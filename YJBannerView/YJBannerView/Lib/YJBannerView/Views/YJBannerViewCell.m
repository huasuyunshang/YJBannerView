//
//  YJBannerViewCell.m
//  YJBannerView
//
//  Created by YJHou on 16/10/8.
//  Copyright © 2016年 YJHou. All rights reserved.
//

#import "YJBannerViewCell.h"
#import "YJBannerViewModel.h"

@interface YJBannerViewCell ()

@property (nonatomic, strong) UIImageView * imgView;

@end

@implementation YJBannerViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self _setUpBannerViewCellMian];
    }
    return self;
}

- (void)_setUpBannerViewCellMian{
    
    [self.contentView addSubview:self.imgView];

}

- (void)bannerViewCellWithDataSource:(YJBannerViewModel *)model{
    self.imgView.image = [UIImage imageNamed:model.localImageName];
}


#pragma mark - Lazy
- (UIImageView *)imgView{
    if (_imgView == nil) {
        _imgView = [[UIImageView alloc] init];
    }
    return _imgView;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.imgView.frame = self.bounds;
}


@end
