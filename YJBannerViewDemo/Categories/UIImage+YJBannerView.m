//
//  UIImage+YJBannerView.m
//  YJBannerViewDemo
//
//  Created by YJHou on 2017/9/30.
//  Copyright © 2017年 Address:https://github.com/stackhou . All rights reserved.
//

#import "UIImage+YJBannerView.h"

@implementation UIImage (YJBannerView)

+ (UIImage *)getImageWithSize:(CGSize)size logoWidth:(CGFloat)logoWidth bgColor:(UIColor *)color{
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    bgView.backgroundColor = color;
    CGFloat imgViewX = (size.width - logoWidth) * 0.5;
    CGFloat logoHeight = logoWidth;
    CGFloat imgViewY = (size.height - logoHeight) * 0.5;
    
    UILabel *showLabel = [[UILabel alloc] initWithFrame:CGRectMake(imgViewX, imgViewY, logoWidth, logoHeight)];
    showLabel.font = [UIFont systemFontOfSize:15];
    showLabel.textAlignment = NSTextAlignmentCenter;
    showLabel.backgroundColor = [UIColor orangeColor];
    showLabel.textColor = [UIColor whiteColor];
    [bgView addSubview:showLabel];
    
    CGSize drawSize = bgView.bounds.size;
    /** 1. 区域大小
     2. 是否是非透明的。如果需要显示半透明效果，需要传NO
     3. 屏幕密度
     */
    UIGraphicsBeginImageContextWithOptions(drawSize, NO, [UIScreen mainScreen].scale);
    [bgView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
