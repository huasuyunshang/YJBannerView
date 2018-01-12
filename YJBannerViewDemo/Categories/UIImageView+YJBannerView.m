//
//  UIImageView+YJBannerView.m
//  YJBannerViewDemo
//
//  Created by YJHou on 2018/1/12.
//  Copyright © 2018年 Address:https://github.com/stackhou  . All rights reserved.
//

#import "UIImageView+YJBannerView.h"
#import <UIImageView+WebCache.h>

@implementation UIImageView (YJBannerView)

- (void)yj_setImageWithPath:(NSString *)imagePath placeholderImageName:(NSString *)placeholderImageName{
    
    [self sd_setImageWithURL:[NSURL URLWithString:imagePath] placeholderImage:[UIImage imageNamed:placeholderImageName]];
}

@end
