//
//  YJDotView.m
//  YJBannerViewDemo
//
//  Created by YJHou on 2015/5/24.
//  Copyright © 2015年 地址:https://github.com/YJManager/YJBannerViewOC . All rights reserved.
//

#import "YJDotView.h"

@implementation YJDotView

- (instancetype)init{
    self = [super init];
    if (self) {
        [self _initializationSetting];
    }
    
    return self;
}


- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self _initializationSetting];
    }
    return self;
}


- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self _initializationSetting];
    }
    
    return self;
}

- (void)_initializationSetting{
    self.backgroundColor    = [UIColor clearColor];
    self.layer.cornerRadius = CGRectGetWidth(self.frame) * 0.5;
    self.layer.borderColor  = [UIColor whiteColor].CGColor;
    self.layer.borderWidth  = 2;
}


- (void)changeActivityState:(BOOL)active{
    if (active) {
        self.backgroundColor = [UIColor whiteColor];
    } else {
        self.backgroundColor = [UIColor clearColor];
    }
}


@end
