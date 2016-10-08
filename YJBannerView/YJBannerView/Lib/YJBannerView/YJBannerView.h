//
//  YJBannerView.h
//  YJBannerView
//
//  Created by YJHou on 2016/10/1.
//  Copyright © 2016年 YJHou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJBannerViewModel.h"

/** PageControl的位置 */
typedef NS_ENUM(NSInteger, YJBannerViewPageControlAliment) {
    YJBannerViewPageControlAlimentCenter,
    YJBannerViewPageControlAlimentRight,
};

/** PageControl的样式 */
typedef NS_ENUM(NSInteger, YJBannerViewPageControlStyle) {
    YJBannerViewPageControlStyleDefault,
    YJBannerViewPageControlStyleAnimated,
    YJBannerViewPageControlStyleNone
};


@class YJBannerView;
// >>>>>>>>>>>>>> YJBannerViewDataSource >>>>>>>>>>>>>>
@protocol YJBannerViewDataSource <NSObject>

@required
/** 显示数据源 */
- (NSArray <YJBannerViewModel *>*)bannerShowDataSourceWithBannerView:(YJBannerView *)bannerView;

@optional
/** isAuto */
- (BOOL)bannerAutoScrollWithBannerView:(YJBannerView *)bannerView;
/** InfiniteLoop */
- (BOOL)bannerInfiniteLoopWithBannerView:(YJBannerView *)bannerView;
/** Auto Scroll Time */
- (CGFloat)bannerAutoScrollTimeWithBannerView:(YJBannerView *)bannerView;
/** titleLabelHeight */
- (CGFloat)bannerTitleLabelHeightWithBannerView:(YJBannerView *)bannerView;
/** TitleTextColor */
- (UIColor *)bannerTitleTextColorWithBannerView:(YJBannerView *)bannerView;
/** TitleFont */
- (UIFont *)bannerTitleFontWithBannerView:(YJBannerView *)bannerView;
/** titleBackgroundColor */
- (UIColor *)bannerTitleBackgroundColorWithBannerView:(YJBannerView *)bannerView;

/** PageControl Dot Size */
- (CGSize)bannerPageControlDotSizeWithBannerView:(YJBannerView *)bannerView;
/** CurrentPageDotColor */
- (UIColor *)bannerCurrentPageDotColorWithBannerView:(YJBannerView *)bannerView;
/** PageDotColor */
- (UIColor *)bannerPageDotNormalColorWithBannerView:(YJBannerView *)bannerView;
/** PageControlBottomOffset */
- (CGFloat)bannerPageControlBottomOffsetWithBannerView:(YJBannerView *)bannerView;
/** PageControlRightOffset */
- (CGFloat)bannerPageControlRightOffsetWithBannerView:(YJBannerView *)bannerView;
/** HidesForSinglePage */
- (BOOL)bannerHidesForSinglePageWithBannerView:(YJBannerView *)bannerView;
/** BannerImageViewContentMode */
- (UIViewContentMode *)bannerImageViewContentModeWithBannerView:(YJBannerView *)bannerView;

@end

// >>>>>>>>>>>>>> YJBannerViewDelegate >>>>>>>>>>>>>>
@protocol YJBannerViewDelegate <NSObject>

@optional
- (void)bannerView:(YJBannerView *)bannerView didSelectIndex:(NSInteger)index;
- (void)bannerView:(YJBannerView *)bannerView didScrollToIndex:(NSInteger)index;

@end



@interface YJBannerView : UIView

/** PageControl的位置 Default is Center */
@property (nonatomic, assign) YJBannerViewPageControlAliment pageControlAliment;

/** PageControl的样式 Default is 经典 */
@property (nonatomic, assign) YJBannerViewPageControlStyle pageControlStyle;

/** DataSource */
@property (nonatomic, weak) id<YJBannerViewDataSource> dataSource;

/** Delegate */
@property (nonatomic, weak) id<YJBannerViewDelegate> delegate;




/** 初始化方法 */
+ (instancetype)bannerViewWithFrame:(CGRect)frame placeholderImage:(UIImage *)placeholderImage;








@end
