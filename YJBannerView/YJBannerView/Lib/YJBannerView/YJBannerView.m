//
//  YJBannerView.m
//  YJBannerView
//
//  Created by YJHou on 2016/10/1.
//  Copyright © 2016年 YJHou. All rights reserved.
//

#import "YJBannerView.h"
#import "YJBannerViewCell.h"

static NSString * const bannerViewCellID = @"bannerViewCellID";

@interface YJBannerView () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, weak) UICollectionViewFlowLayout * flowLayout;
@property (nonatomic, strong) UIImageView * placeholderImageView;
@property (nonatomic, strong) UIImage * placeholderImage;

@end

@implementation YJBannerView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self _initialization];
        [self _setUpBannerMianView];
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self _initialization];
    [self _setUpBannerMianView];
}


- (void)_initialization{
    
    _pageControlAliment = YJBannerViewPageControlAlimentCenter;
    _pageControlStyle = YJBannerViewPageControlStyleDefault;
    self.backgroundColor = [UIColor lightGrayColor];
}


+ (instancetype)bannerViewWithFrame:(CGRect)frame placeholderImage:(UIImage *)placeholderImage{
    
    YJBannerView * bannerView = [[YJBannerView alloc] initWithFrame:frame];
    bannerView.placeholderImage = placeholderImage;
    return bannerView;
    
}

- (void)_setUpBannerMianView{
    
    [self addSubview:self.collectionView];


}

#pragma mark - 数据设置Getter
/** isAuto Scroll Default is YES */
- (BOOL)_isAutoScroll{
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(bannerAutoScrollWithBannerView:)]) {
        BOOL isAutoScroll = [self.dataSource bannerAutoScrollWithBannerView:self];
        return isAutoScroll;
    }
    return YES;
}

/** infiniteLoop Default is YES */
- (BOOL)_isInfiniteLoop{
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(bannerInfiniteLoopWithBannerView:)]) {
        BOOL isInfiniteLoop = [self.dataSource bannerInfiniteLoopWithBannerView:self];
        return isInfiniteLoop;
    }
    return YES;
}

/** AutoTime Default is 2s */
- (CGFloat)_autoScrollTimeInterval{
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(bannerAutoScrollTimeWithBannerView:)]) {
        CGFloat autoScrollTimeInterval = [self.dataSource bannerAutoScrollTimeWithBannerView:self];
        return autoScrollTimeInterval;
    }
    return 2.0f;
}

/** titleLabelHeight */
- (CGFloat)_titleLabelHeight{
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(bannerTitleLabelHeightWithBannerView:)]) {
        CGFloat titleLabelHeight = [self.dataSource bannerTitleLabelHeightWithBannerView:self];
        return titleLabelHeight;
    }
    return 30.0f;
}

/** titleTextColor */
- (UIColor *)_titleTextColor{
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(bannerTitleTextColorWithBannerView:)]) {
        UIColor * titleTextColor = [self.dataSource bannerTitleTextColorWithBannerView:self];
        if (titleTextColor) NSAssert([titleTextColor isKindOfClass:[UIColor class]], @"You must return a valid UIColor object for -bannerTitleTextColorWithBannerView:");
        return titleTextColor;
    }
    return [UIColor whiteColor];
}

/** titleFont */
- (UIFont *)_titleFont{
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(bannerTitleFontWithBannerView:)]) {
        UIFont * titleFont = [self.dataSource bannerTitleFontWithBannerView:self];
        if (titleFont) NSAssert([titleFont isKindOfClass:[UIFont class]], @"You must return a valid UIFont object for -bannerTitleFontWithBannerView:");
        return titleFont;
    }
    return [UIFont systemFontOfSize:14];
}

/** titleBackgroundColor */
- (UIColor *)_titleBackgroundColor{
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(bannerTitleBackgroundColorWithBannerView:)]) {
        UIColor * titleBackgroundColor = [self.dataSource bannerTitleBackgroundColorWithBannerView:self];
        if (titleBackgroundColor) NSAssert([titleBackgroundColor isKindOfClass:[UIColor class]], @"You must return a valid UIColor object for -bannerTitleBackgroundColorWithBannerView:");
        return titleBackgroundColor;
    }
    return [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
}

/** pageControl Size */
- (CGSize)_pageControlDotSize{
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(bannerPageControlDotSizeWithBannerView:)]) {
        CGSize pageControlDotSize = [self.dataSource bannerPageControlDotSizeWithBannerView:self];
        return pageControlDotSize;
    }
    return CGSizeMake(10, 10);
}

/** _currentPageDotColor */
- (UIColor *)_currentPageDotColor{
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(bannerCurrentPageDotColorWithBannerView:)]) {
        UIColor * currentPageDotColor =  [self.dataSource bannerCurrentPageDotColorWithBannerView:self];
        if (currentPageDotColor) NSAssert([currentPageDotColor isKindOfClass:[UIColor class]], @"You must return a valid UIColor object for -bannerCurrentPageDotColorWithBannerView:");
        return currentPageDotColor;
    }
    return [UIColor whiteColor];
}

/** _pageDotNormalColor */
- (UIColor *)_pageNormalDotColor{
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(bannerPageDotNormalColorWithBannerView:)]) {
        UIColor * pageNormalDotColor = [self.dataSource bannerPageDotNormalColorWithBannerView:self];
        if (pageNormalDotColor) NSAssert([pageNormalDotColor isKindOfClass:[UIColor class]], @"You must return a valid UIColor object for -bannerPageDotNormalColorWithBannerView:");
        return pageNormalDotColor;
    }
    return [UIColor lightGrayColor];
}

/** _pageControlBottomOffset */
- (CGFloat)_pageControlBottomOffset{
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(bannerPageControlBottomOffsetWithBannerView:)]) {
        return [self.dataSource bannerPageControlBottomOffsetWithBannerView:self];
    }
    return 0.0f;
}

/** PageControlRightOffset */
- (CGFloat)_pageControlRightOffset{
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(bannerPageControlRightOffsetWithBannerView:)]) {
        return [self.dataSource bannerPageControlRightOffsetWithBannerView:self];
    }
    return 0.0f;
}

/** hidesForSinglePage */
- (BOOL)_hidesForSinglePage{
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(bannerHidesForSinglePageWithBannerView:)]) {
        return [self.dataSource bannerHidesForSinglePageWithBannerView:self];
    }
    return YES;
}

/** _bannerImageViewContentMode */
- (UIViewContentMode *)_bannerImageViewContentMode{
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(bannerImageViewContentModeWithBannerView:)]) {
        return [self.dataSource bannerImageViewContentModeWithBannerView:self];
    }
    return UIViewContentModeScaleToFill;
}




#pragma mark - Lazy
- (UICollectionView *)collectionView{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 0.0f;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _flowLayout = flowLayout;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.pagingEnabled = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        [_collectionView registerClass:[YJBannerViewCell class] forCellWithReuseIdentifier:bannerViewCellID];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.scrollsToTop = NO;
    }
    return _collectionView;
}


@end
