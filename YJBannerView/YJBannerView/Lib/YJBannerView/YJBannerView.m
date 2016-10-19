//
//  YJBannerView.m
//  YJBannerView
//
//  Created by YJHou on 2013/10/1.
//  Copyright © 2016年 YJHou. All rights reserved.
//

#import "YJBannerView.h"
#import "YJBannerViewCell.h"
#import "UIView+YJBannerView.h"

static NSString * const bannerViewCellID = @"bannerViewCellID";

@interface YJBannerView () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, weak) UICollectionViewFlowLayout * flowLayout;
@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, weak) UIControl * pageControl;

@property (nonatomic, strong) UIImageView * placeholderImageView;
@property (nonatomic, strong) UIImage * placeholderImage;

@property (nonatomic, weak) NSTimer * bannerTimer;

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

- (void)_setUpBannerMianView{
    
    [self addSubview:self.collectionView];
}

+ (instancetype)bannerViewWithFrame:(CGRect)frame placeholderImage:(UIImage *)placeholderImage{
    
    YJBannerView * bannerView = [[YJBannerView alloc] initWithFrame:frame];
    bannerView.placeholderImage = placeholderImage;
    return bannerView;
    
}

#pragma mark - Setter
- (void)setPlaceholderImage:(UIImage *)placeholderImage{
    _placeholderImage = placeholderImage;
    if (self.placeholderImageView == nil) {
        UIImageView *bgImageView = [UIImageView new];
        bgImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self insertSubview:bgImageView belowSubview:self.collectionView];
        self.placeholderImageView = bgImageView;
    }
    self.placeholderImageView.image = placeholderImage;
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

/** show Data */
- (NSArray <YJBannerViewModel *> *)_showDataSource{
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(bannerShowDataSourceWithBannerView:)]) {
        NSArray <YJBannerViewModel *> * dataSource = [self.dataSource bannerShowDataSourceWithBannerView:self];
        return dataSource;
    }
    return nil;
}

/** data Count */
- (NSInteger)_totalItemsCount{
    return [self _showDataSource].count;
}

#pragma mark - SetUp
- (void)_setupTimer{
    NSTimer * timer = [NSTimer scheduledTimerWithTimeInterval:[self _autoScrollTimeInterval] target:self selector:@selector(autoScrollTimerAction) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    _bannerTimer = timer;
}

- (void)_invalidateTimer{
    if (_bannerTimer) {
        [_bannerTimer invalidate];
        _bannerTimer = nil;
    }
}

- (void)autoScrollTimerAction{
    if ([self _totalItemsCount] == 0) return;
    
    int currentIndex = [self currentIndex];
    int targetIndex = currentIndex + 1;
    [self scrollToIndex:targetIndex];
}

- (void)scrollToIndex:(int)targetIndex{
    if (targetIndex >= [self _totalItemsCount]) {
        if ([self _isInfiniteLoop]) {
            targetIndex = [self _totalItemsCount] * 0.5;
            [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        }
        return;
    }
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
}

- (int)currentIndex{
    
    if (self.collectionView.width_yj == 0 || self.collectionView.height_yj == 0) {
        return 0;
    }
    
    int index = 0;
    if (_flowLayout.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
        index = (self.collectionView.contentOffset.x + _flowLayout.itemSize.width * 0.5) / _flowLayout.itemSize.width;
    } else {
        index = (self.collectionView.contentOffset.y + _flowLayout.itemSize.height * 0.5) / _flowLayout.itemSize.height;
    }
    return MAX(0, index);
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
//        _collectionView.showsHorizontalScrollIndicator = NO;
//        _collectionView.showsVerticalScrollIndicator = NO;
        [_collectionView registerClass:[YJBannerViewCell class] forCellWithReuseIdentifier:bannerViewCellID];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.scrollsToTop = NO;
    }
    return _collectionView;
}

#pragma mark - layoutSubviews
- (void)layoutSubviews{
    [super layoutSubviews];
    
    _flowLayout.itemSize = self.frame.size;
    
    self.collectionView.frame = self.bounds;
    if (self.collectionView.contentOffset.x == 0 &&  [self _totalItemsCount]) {
        int targetIndex = 0;
        if ([self _isInfiniteLoop]) {
            targetIndex = [self _totalItemsCount] * 0.5;
        }else{
            targetIndex = 0;
        }
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
    
    CGSize size = CGSizeZero;
//    if ([self.pageControl isKindOfClass:[TAPageControl class]]) {
//        TAPageControl *pageControl = (TAPageControl *)_pageControl;
//        if (!(self.pageDotImage && self.currentPageDotImage && CGSizeEqualToSize(kCycleScrollViewInitialPageControlDotSize, self.pageControlDotSize))) {
//            pageControl.dotSize = self.pageControlDotSize;
//        }
//        size = [pageControl sizeForNumberOfPages:self.imagePathsGroup.count];
//    } else {
//        size = CGSizeMake(self.imagePathsGroup.count * self.pageControlDotSize.width * 1.5, self.pageControlDotSize.height);
//    }
//    CGFloat x = (self.sd_width - size.width) * 0.5;
//    if (self.pageControlAliment == SDCycleScrollViewPageContolAlimentRight) {
//        x = self.mainView.sd_width - size.width - 10;
//    }
//    CGFloat y = self.mainView.sd_height - size.height - 10;
//    
//    if ([self.pageControl isKindOfClass:[TAPageControl class]]) {
//        TAPageControl *pageControl = (TAPageControl *)_pageControl;
//        [pageControl sizeToFit];
//    }
    
//    CGRect pageControlFrame = CGRectMake(x, y, size.width, size.height);
//    pageControlFrame.origin.y -= self.pageControlBottomOffset;
//    pageControlFrame.origin.x -= self.pageControlRightOffset;
//    self.pageControl.frame = pageControlFrame;
//    self.pageControl.hidden = !_showPageControl;
    
    if (self.placeholderImageView) {
        self.placeholderImageView.frame = self.bounds;
    }
    
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self _showDataSource].count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    YJBannerViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:bannerViewCellID forIndexPath:indexPath];
    
//    long itemIndex = [self pageControlIndexWithCurrentCellIndex:indexPath.item];
    
//    NSString *imagePath = self.imagePathsGroup[itemIndex];
//    
//    if (!self.onlyDisplayText && [imagePath isKindOfClass:[NSString class]]) {
//        if ([imagePath hasPrefix:@"http"]) {
//            [cell.imageView sd_setImageWithURL:[NSURL URLWithString:imagePath] placeholderImage:self.placeholderImage];
//        } else {
//            UIImage *image = [UIImage imageNamed:imagePath];
//            if (!image) {
//                [UIImage imageWithContentsOfFile:imagePath];
//            }
//            cell.imageView.image = image;
//        }
//    } else if (!self.onlyDisplayText && [imagePath isKindOfClass:[UIImage class]]) {
//        cell.imageView.image = (UIImage *)imagePath;
//    }
//    
//    if (_titlesGroup.count && itemIndex < _titlesGroup.count) {
//        cell.title = _titlesGroup[itemIndex];
//    }
    
//    if (!cell.hasConfigured) {
//        cell.titleLabelBackgroundColor = self.titleLabelBackgroundColor;
//        cell.titleLabelHeight = self.titleLabelHeight;
//        cell.titleLabelTextColor = self.titleLabelTextColor;
//        cell.titleLabelTextFont = self.titleLabelTextFont;
//        cell.hasConfigured = YES;
//        cell.imageView.contentMode = self.bannerImageViewContentMode;
//        cell.clipsToBounds = YES;
//        cell.onlyDisplayText = self.onlyDisplayText;
//    }
//
    YJBannerViewModel * model = [self _showDataSource][indexPath.item];
    [cell bannerViewCellWithDataSource:model];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.delegate && [self.delegate respondsToSelector:@selector(bannerView:didSelectIndex:)]) {
        [self.delegate bannerView:self didSelectIndex:indexPath.item];
    }
//    if (self.clickItemOperationBlock) {
//        self.clickItemOperationBlock([self pageControlIndexWithCurrentCellIndex:indexPath.item]);
//    }
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    if (!self.imagePathsGroup.count) return; // 解决清除timer时偶尔会出现的问题
    int itemIndex = [self currentIndex];
    int indexOnPageControl = [self pageControlIndexWithCurrentCellIndex:itemIndex];
    
//    if ([self.pageControl isKindOfClass:[TAPageControl class]]) {
//        TAPageControl *pageControl = (TAPageControl *)_pageControl;
//        pageControl.currentPage = indexOnPageControl;
//    } else {
//        UIPageControl *pageControl = (UIPageControl *)_pageControl;
//        pageControl.currentPage = indexOnPageControl;
//    }
    UIPageControl *pageControl = (UIPageControl *)_pageControl;
    pageControl.currentPage = indexOnPageControl;

}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if ([self _isAutoScroll]) {
        [self _invalidateTimer];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if ([self _isAutoScroll]) {
        [self _setupTimer];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self scrollViewDidEndScrollingAnimation:self.collectionView];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    if ([self _showDataSource].count == 0) return; // 解决清除timer时偶尔会出现的问题
    int itemIndex = [self currentIndex];
    int indexOnPageControl = [self pageControlIndexWithCurrentCellIndex:itemIndex];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(bannerView:didScrollToIndex:)]) {
        [self.delegate bannerView:self didScrollToIndex:indexOnPageControl];
    }
}

- (int)pageControlIndexWithCurrentCellIndex:(NSInteger)index{
    return (int)index % [self _showDataSource].count;
}



@end
