//
//  YJCustomView.m
//  YJBannerViewDemo
//
//  Created by YJHou on 2018/1/9.
//  Copyright © 2018年 Address:https://github.com/stackhou . All rights reserved.
//

#import "YJCustomView.h"
#import <AVKit/AVKit.h>
#import <UIImageView+WebCache.h>

@interface YJCustomView ()

@end

@implementation YJCustomView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        
        self.imgView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        [self.contentView addSubview:self.imgView];
        
        self.button.center = self.imgView.center;
        [self.imgView addSubview:self.button];
        
    }
    return self;
}

- (void)cellWithcoverForFeed:(NSString *)coverForFeed{
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:coverForFeed] placeholderImage:[UIImage imageNamed:@"vediobgImage"]];
}

#pragma mark - Action
- (void)buttonClickAction:(UIButton *)btn{
    if (self.playBlock) {
        self.playBlock(btn);
    }
}

#pragma mark - Lazy
- (UIButton *)button{
    if (!_button) {
        CGFloat buttonWH = 50;
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.frame = CGRectMake(0, 0, buttonWH, buttonWH);
        _button.backgroundColor = [UIColor clearColor];
        [_button setImage:[UIImage imageNamed:@"video_list_cell_big_icon"] forState:UIControlStateNormal];
        [_button setImage:[UIImage imageNamed:@"video_list_cell_big_icon"] forState:UIControlStateHighlighted];
        [_button addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

- (UIImageView *)imgView{
    if (!_imgView) {
        _imgView = [[UIImageView alloc] init];
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
        _imgView.tag = 100;
        _imgView.userInteractionEnabled = YES;
    }
    return _imgView;
}

@end
