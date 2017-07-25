//
//  YJBannerViewCell.h
//  YJBannerViewDemo
//
//  Created by YJHou on 2015/5/24.
//  Copyright © 2015年 地址:https://github.com/YJManager/YJBannerViewOC . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YJBannerViewCell : UICollectionViewCell

@property (nonatomic, strong) UIColor *titleLabelTextColor;
@property (nonatomic, strong) UIFont *titleLabelTextFont;
@property (nonatomic, strong) UIColor *titleLabelBackgroundColor;
@property (nonatomic, assign) CGFloat titleLabelHeight;
@property (nonatomic, assign) CGFloat titleLabelEdgeMargin;
@property (nonatomic, assign) NSTextAlignment titleLabelTextAlignment;
@property (nonatomic, assign) UIViewContentMode showImageViewContentMode; /**< 填充样式 默认UIViewContentModeScaleToFill */
@property (nonatomic, assign) BOOL isConfigured;
@property (nonatomic, strong) UIView *customView; /**< 自定义View */

- (void)cellWithSelectorString:(NSString *)selectorString imagePath:(NSString *)imagePath placeholderImageName:(NSString *)placeholderImageName title:(NSString *)title;

@end
