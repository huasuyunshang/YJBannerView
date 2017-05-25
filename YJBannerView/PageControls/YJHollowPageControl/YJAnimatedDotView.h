//
//  YJAnimatedDotView.h
//  YJBannerViewDemo
//
//  Created by YJHou on 2014/5/25.
//  Copyright © 2014年 地址:https://github.com/YJManager/YJBannerViewOC . All rights reserved.
//

#import "YJAbstractDotView.h"

@interface YJAnimatedDotView : YJAbstractDotView

@property (nonatomic, strong) UIColor *dotColor;
@property (nonatomic, strong) UIColor *currentDotColor;
@property (nonatomic, assign) CGFloat resizeScale; /**< 调整比例 */

@end
