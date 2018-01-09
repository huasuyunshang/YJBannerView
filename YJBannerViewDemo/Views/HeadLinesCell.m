//
//  HeadLinesCell.m
//  YJBannerViewDemo
//
//  Created by YJHou on 2017/7/4.
//  Copyright © 2017年 Address:https://github.com/stackhou . All rights reserved.
//

#import "HeadLinesCell.h"

@interface HeadLinesCell ()

@property (nonatomic, strong) UILabel *headTagLabel;
@property (nonatomic, strong) UILabel *contentLabel; /**< 内容 */

@end

@implementation HeadLinesCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    
    [self.contentView addSubview:self.headTagLabel];
    [self.contentView addSubview:self.contentLabel];

}

- (void)cellWithHeadHotLineCellData:(NSString *)string{
    self.contentLabel.text = string;
}

#pragma mark - Lazy
- (UILabel *)headTagLabel{
    if (!_headTagLabel) {
        _headTagLabel = [[UILabel alloc] init];
        _headTagLabel.font = [UIFont boldSystemFontOfSize:12];
        _headTagLabel.textAlignment = NSTextAlignmentCenter;
        _headTagLabel.backgroundColor = [UIColor orangeColor];
        _headTagLabel.textColor = [UIColor whiteColor];
        _headTagLabel.text = @"打折";
        [_headTagLabel.layer setCornerRadius:8.0f];
        _headTagLabel.layer.masksToBounds = YES;
    }
    return _headTagLabel;
}

- (UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = [UIFont systemFontOfSize:13];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.backgroundColor = [UIColor clearColor];
        _contentLabel.textColor = [UIColor blackColor];
    }
    return _contentLabel;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.headTagLabel.frame = CGRectMake(0, 10, 40, 20);
    
    self.contentLabel.frame = CGRectMake(45, 0, self.bounds.size.width - 50, 40);
}

@end
