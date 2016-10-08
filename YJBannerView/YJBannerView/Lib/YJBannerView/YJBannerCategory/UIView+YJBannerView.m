//
//  UIView+YJBannerView.m
//  YJBannerView
//
//  Created by YJHou on 2016/10/1.
//  Copyright © 2016年 YJHou. All rights reserved.
//

#import "UIView+YJBannerView.h"

@implementation UIView (YJBannerView)

- (void)setX_yj:(CGFloat)x_yj{
    CGRect frame = self.frame;
    frame.origin.x = x_yj;
    self.frame = frame;
}

- (CGFloat)x_yj{
    return self.frame.origin.x;
}

- (void)setY_yj:(CGFloat)y_yj{
    CGRect frame = self.frame;
    frame.origin.y = y_yj;
    self.frame = frame;
}

- (CGFloat)y_yj{
    return self.frame.origin.y;
}

- (void)setWidth_yj:(CGFloat)width_yj{
    CGRect frame = self.frame;
    frame.size.width = width_yj;
    self.frame = frame;
}

- (CGFloat)width_yj{
    return self.frame.size.width;
}

- (void)setHeight_yj:(CGFloat)height_yj{
    CGRect frame = self.frame;
    frame.size.height = height_yj;
    self.frame = frame;
}

- (CGFloat)height_yj{
    return self.frame.size.height;
}

- (void)setSize_yj:(CGSize)size_yj{
    CGRect frame = self.frame;
    frame.size = size_yj;
    self.frame = frame;
}

- (CGSize)size_yj{
    return self.frame.size;
}

- (void)setOrigin_yj:(CGPoint)origin_yj{
    CGRect frame = self.frame;
    frame.origin = origin_yj;
    self.frame = frame;
}
- (CGPoint)origin_yj{
    return self.frame.origin;
}

@end
