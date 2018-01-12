//
//  YJCustomGapCell.m
//  YJBannerViewDemo
//
//  Created by YJHou on 2018/1/12.
//  Copyright © 2018年 Address:https://github.com/stackhou  . All rights reserved.
//

#import "YJCustomGapCell.h"
#import "UIImageView+YJBannerView.h"

@interface YJCustomGapCell ()

@property (nonatomic, strong) UIImageView *showImageView; /**< 显示图片 */

@end

@implementation YJCustomGapCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self _setUpMainView];
    }
    return self;
}

- (void)_setUpMainView{
    [self.contentView addSubview:self.showImageView];
}

- (void)cellWithImagePath:(NSString *)imagePath{
    [self.showImageView yj_setImageWithPath:imagePath placeholderImageName:@""];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat gap = 10.0f;
    self.showImageView.frame = CGRectMake(gap, gap, self.bounds.size.width - 2 * gap, self.bounds.size.height - 2 * gap);
}


#pragma mark - Lazy
- (UIImageView *)showImageView{
    if (!_showImageView) {
        _showImageView = [[UIImageView alloc] init];
    }
    return _showImageView;
}

@end
