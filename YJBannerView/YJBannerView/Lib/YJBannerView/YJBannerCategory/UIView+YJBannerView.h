//
//  UIView+YJBannerView.h
//  YJBannerView
//
//  Created by YJHou on 2016/10/1.
//  Copyright © 2016年 YJHou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (YJBannerView)

@property (nonatomic, assign) CGFloat x_yj; /**< x */
@property (nonatomic, assign) CGFloat y_yj; /**< y */

@property (nonatomic, assign) CGFloat width_yj; /**< 宽 */
@property (nonatomic, assign) CGFloat height_yj; /**< 高 */

@property (nonatomic, assign) CGSize size_yj; /**< size大小 */
@property (nonatomic, assign) CGPoint origin_yj; /**< 起点 */

@end
