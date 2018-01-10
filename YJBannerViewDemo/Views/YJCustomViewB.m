//
//  YJCustomViewB.m
//  YJBannerViewDemo
//
//  Created by YJHou on 2018/1/9.
//  Copyright © 2018年 Address:https://github.com/stackhou  . All rights reserved.
//

#import "YJCustomViewB.h"

@interface YJCustomViewB ()

@property (nonatomic, strong) UIButton *button; /**< 按钮 */

@end

@implementation YJCustomViewB

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blueColor];
        [self.contentView addSubview:self.button];
    }
    return self;
}

#pragma mark - Action
- (void)buttonClickAction:(UIButton *)btn{
    NSLog(@"-->%@", @"我bubububuuuuuu~~~~~~~~");
}

#pragma mark - Lazy
- (UIButton *)button{
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.frame = CGRectMake(100, 50, 100, 40);
        _button.backgroundColor = [UIColor orangeColor];
        [_button setTitle:@"按钮" forState:UIControlStateNormal];
        [_button setTitle:@"按钮" forState:UIControlStateHighlighted];
        [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [_button addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}


@end
