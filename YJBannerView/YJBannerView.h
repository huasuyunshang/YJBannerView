//
//  YJBannerView.h
//  YJBannerViewDemo
//
//  Created by YJHou on 2015/5/24.
//  Copyright © 2015年 地址:https://github.com/YJManager/YJBannerViewOC . All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 ********* 当前版本: 2.2.1 ********

版本记录:
    2015/5/10   版本1.0   是以静态库.a的方式使用 Cocoapods 引入功能
    2016/10/17  版本2.0   是以源码的方式使用 Cocoapods 引入功能
    2017/5/29   版本2.1   自动滚动时间间隔调整为3s、动画变化比例调整为1.0、设置标题默认边间距为10, 可任意设置, 支持Carthage
    2017/7/3    版本2.1.1  修改通过传递UIImageView设置网络图片的方法给BannerView设置图片, 不再依赖 SDWebImage
    2017/7/14   版本2.1.4  代码功能及结构优化
    2017/7/21   版本2.1.5  代码功能优化
    2017/7/25   版本2.1.6  1.新增cycleScrollEnable控制是否需要首尾相连; 2.新增bannerGestureEnable 手势是否可用 3.新增bannerView:didScrollCurrentIndex:代理方法, 可以自定义PageControl
    2017/7/28   版本2.1.7  1.新增FooterView 2.新增自定义View bannerView:viewForItemAtIndex: 方法
    2017/7/30   版本2.2.0   稳定版本
    2017/8/21   版本2.2.1   1. 当数据源不为零时, 隐藏背景图片
 */

/** 指示器的位置 */
typedef NS_ENUM(NSInteger, PageControlAliment) {
    PageControlAlimentLeft = 0,     // 居左
    PageControlAlimentCenter,       // 居中
    PageControlAlimentRight         // 居右
};

/** 指示器的样式 */
typedef NS_ENUM(NSInteger, PageControlStyle) {
    PageControlNone = 0,            // 无
    PageControlSystem,              // 系统自带
    PageControlHollow,              // 空心的
    PageControlCustom               // 自定义 需要图片Dot
};

/** 滚动方向   */
typedef NS_ENUM(NSInteger, BannerViewDirection) {
    BannerViewDirectionLeft = 0,    // 水平向左
    BannerViewDirectionRight,       // 水平向右
    BannerViewDirectionTop,         // 竖直向上
    BannerViewDirectionBottom       // 竖直向下
};


@class YJBannerView;
@protocol YJBannerViewDataSource, YJBannerViewDelegate;

@interface YJBannerView : UIView
    
@property (nonatomic, strong, readonly) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong, readonly) UICollectionView           *collectionView;

@property (nonatomic, weak) IBOutlet id<YJBannerViewDataSource> dataSource;         /**< 数据源代理 */
@property (nonatomic, weak) IBOutlet id<YJBannerViewDelegate> delegate;             /**< 代理      */


//////////// 动态控制部分 //////////////////
@property (nonatomic, assign) IBInspectable BOOL autoScroll;                        /**< 是否自动 默认YES */

@property (nonatomic, assign) IBInspectable CGFloat autoDuration;                   /**< 自动滚动时间间隔 默认3s */

@property (nonatomic, assign) IBInspectable BOOL cycleScrollEnable;                 /**< 是否首尾循环 默认是YES */

@property (nonatomic, assign) BannerViewDirection bannerViewScrollDirection;        /**< 滚动方向 默认水平向左 */

@property (nonatomic, assign) BOOL bannerGestureEnable;                             /**< 手势是否可用 默认可用YES */

@property (nonatomic, assign) IBInspectable BOOL showFooter;                        /**< 显示footerView 默认是 NO 设置为YES 后将 autoScroll和cycleScrollEnable 自动置为NO 只支持水平向左 */

//////////////  自定义样式接口  //////////////////
@property (nonatomic, copy) NSString *placeholderImageName;                         /** 默认图片名 */

@property (nonatomic, copy) NSString *bannerViewSelectorString;                     /**< 自定义设置网络和默认图片的方法 */

@property (nonatomic, assign) UIViewContentMode bannerImageViewContentMode;         /**< 填充样式 默认UIViewContentModeScaleToFill */

@property (nonatomic, assign) PageControlAliment pageControlAliment;                /**< 分页控件的位置 默认是Center */

@property (nonatomic, assign) PageControlStyle pageControlStyle;                    /**< 分页控件样式 默认System */

@property (nonatomic, assign) CGFloat pageControlBottomMargin;                      /**< 分页控件距离底部的间距 默认10 */

@property (nonatomic, assign) CGFloat pageControlHorizontalEdgeMargin;              /**< 分页控件水平方向上的边缘间距 默认10 */

@property (nonatomic, assign) CGFloat pageControlPadding;                           /**< 分页控件水平方向上间距 默认 5 系统样式无效 */

@property (nonatomic, assign) CGSize pageControlDotSize;                            /**< 分页控件小圆标大小 默认 8*8*/

@property (nonatomic, strong) UIColor *pageControlNormalColor;                      /**< 分页控件正常颜色 */

@property (nonatomic, strong) UIColor *pageControlHighlightColor;                   /**< 前分页控件小圆标颜色 */

@property (nonatomic, strong) UIImage *customPageControlNormalImage;                /**< 分页小圆点正常的图片 */

@property (nonatomic, strong) UIImage *customPageControlHighlightImage;             /**< 当前分页控件图片 */

@property (nonatomic, strong) UIFont *titleFont;                                    /**< 文字大小 */

@property (nonatomic, strong) UIColor *titleTextColor;                              /**< 文字颜色 */

@property (nonatomic, assign) NSTextAlignment titleAlignment;                       /**< 文字对齐方式 */

@property (nonatomic, strong) UIColor *titleBackgroundColor;                        /**< 文字背景颜色 */

@property (nonatomic, assign) CGFloat titleHeight;                                  /**< 文字高度 */

@property (nonatomic, assign) CGFloat titleEdgeMargin;                              /**< 文字边缘间距 默认是10 */

@property (nonatomic, copy) NSString *footerIndicateImageName;                      /**< footer 指示图片名字 默认是自带的 */

@property (nonatomic, copy) NSString *footerNormalTitle;                            /**< footer 常态Title 默认 "拖动查看详情" */

@property (nonatomic, copy) NSString *footerTriggerTitle;                           /**< footer Trigger Title 默认 "释放查看详情" */

@property (nonatomic, strong) UIFont *footerTitleFont;                              /**< footer Font 默认 12 */

@property (nonatomic, strong) UIColor *footerTitleColor;                            /**< footer TitleColoe 默认是 darkGrayColor */

@property (nonatomic, copy) void(^didScroll2IndexBlock)(NSInteger index);
@property (nonatomic, copy) void(^didSelectItemAtIndexBlock)(NSInteger index);
@property (nonatomic, copy) void(^didEndTriggerFooterBlock)();

/**
 创建bannerView实例的方法

 @param frame bannerView的Frame
 @param dataSource 数据源代理
 @param delegate 普通代理
 @param placeholderImageName 默认图片
 @param selectorString 必须是 UIImageView 设置图片和placeholderImage的方法 如: @"sd_setImageWithURL:placeholderImage:", 分别接收NSURL和UIImage两个参数
 @return YJBannerView 实例
 */
+ (YJBannerView *)bannerViewWithFrame:(CGRect)frame
                           dataSource:(id<YJBannerViewDataSource>)dataSource
                             delegate:(id<YJBannerViewDelegate>)delegate
                 placeholderImageName:(NSString *)placeholderImageName
                       selectorString:(NSString *)selectorString;

/**
 刷新BannerView数据
 */
- (void)reloadData;


/**
 解决卡屏问题, 在控制器viewWillAppear时调用此方法
 */
- (void)adjustBannerViewWhenViewWillAppear;

@end

#pragma mark - 协议部分
@protocol YJBannerViewDataSource <NSObject>

@required
/** 兼容 http(s):// 和 本地图片Name */
- (NSArray *)bannerViewImages:(YJBannerView *)bannerView;

@optional
/** 文字数据源 */
- (NSArray *)bannerViewTitles:(YJBannerView *)bannerView;

/** 自定义Cell */
- (Class)bannerViewCustomCellClass:(YJBannerView *)bannerView;

/** 自定义 Cell 方法传递 */
- (void)bannerView:(YJBannerView *)bannerView customCell:(UICollectionViewCell *)customCell index:(NSInteger)index;

/** 自定义 View */
- (UIView *)bannerView:(YJBannerView *)bannerView viewForItemAtIndex:(NSInteger)index;

/** Footer 高度 默认是 49.0 */
- (CGFloat)bannerViewFooterViewHeight:(YJBannerView *)bannerView;

@end

@protocol YJBannerViewDelegate <NSObject>

@optional
/** 正在滚动的位置 */
- (void)bannerView:(YJBannerView *)bannerView didScrollCurrentIndex:(NSInteger)currentIndex;

/** 滚动到 index */
- (void)bannerView:(YJBannerView *)bannerView didScroll2Index:(NSInteger)index;

/** 点击回调 */
- (void)bannerView:(YJBannerView *)bannerView didSelectItemAtIndex:(NSInteger)index;

/** BannerView Footer 回调 */
- (void)bannerViewFooterDidEndTrigger:(YJBannerView *)bannerView;

@end

