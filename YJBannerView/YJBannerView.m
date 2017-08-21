//
//  YJBannerView.m
//  YJBannerViewDemo
//
//  Created by YJHou on 2015/5/24.
//  Copyright © 2015年 地址:https://github.com/YJManager/YJBannerViewOC . All rights reserved.
//

#import "YJBannerView.h"
#import "YJBannerViewCell.h"
#import "UIView+YJBannerViewExt.h"
#import "YJHollowPageControl.h"
#import "YJBannerViewFooter.h"

static NSString *const bannerViewCellId = @"YJBannerView";
static NSString *const bannerViewFooterId = @"YJBannerViewFooter";
#define kPageControlDotDefaultSize CGSizeMake(8, 8)
#define BANNER_FOOTER_HEIGHT 49.0
static NSInteger const totalCollectionViewCellCount = 500; // 重复的次数

@interface YJBannerView () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout> {
    UICollectionView *_collectionView;
    UICollectionViewFlowLayout *_flowLayout;
}

@property (nonatomic, weak) UIControl *pageControl;                     /**< 分页指示器 */
@property (nonatomic, weak) NSTimer *timer;                             /**< 定时器 */
@property (nonatomic, assign) NSInteger totalItemsCount;                /**< 数量 */
@property (nonatomic, strong) UIImageView *backgroundImageView;         /**< 数据为空时的背景图 */
@property (nonatomic, strong) NSArray *saveScrollViewGestures;          /**< 保存手势 */
@property (nonatomic, strong) YJBannerViewFooter *bannerFooter;

@end

@implementation YJBannerView
@synthesize autoScroll = _autoScroll;
@synthesize cycleScrollEnable = _cycleScrollEnable;

#pragma mark - Public
+ (YJBannerView *)bannerViewWithFrame:(CGRect)frame
                           dataSource:(id<YJBannerViewDataSource>)dataSource
                             delegate:(id<YJBannerViewDelegate>)delegate
                 placeholderImageName:(NSString *)placeholderImageName
                       selectorString:(NSString *)selectorString{
    
    YJBannerView *bannerView = [[YJBannerView alloc] initWithFrame:frame];
    bannerView.dataSource = dataSource;
    bannerView.delegate = delegate;
    bannerView.bannerViewSelectorString = selectorString;
    if (placeholderImageName) {
        bannerView.placeholderImageName = placeholderImageName;
    }
    return bannerView;
}


- (void)reloadData{
    
    [self invalidateTimer];
    
    // 当数据源大于零时隐藏
    self.backgroundImageView.hidden = ([self _imageDataSources].count > 0);
    
    if ([self _imageDataSources].count > 1) {
        self.collectionView.scrollEnabled = YES;
        [self setAutoScroll:self.autoScroll];
    } else {
        
        if ([self _imageDataSources].count == 0) { self.showFooter = NO; }
        
        BOOL isCan = ([self _imageDataSources].count == 0)?NO:(self.showFooter?YES:NO);
        
        self.collectionView.scrollEnabled = isCan;
        [self setAutoScroll:NO];
        
    }
    
    [self _setupPageControl];
    
    // 注册自定义cell
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(bannerViewCustomCellClass:)] && [self.dataSource bannerViewCustomCellClass:self]) {
        [self.collectionView registerClass:[self.dataSource bannerViewCustomCellClass:self] forCellWithReuseIdentifier:bannerViewCellId];
    }
    
    [self.collectionView reloadData];
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self _initSetting];
        [self addSubview:self.collectionView];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self _initSetting];
        [self addSubview:self.collectionView];
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self _initSetting];
    [self addSubview:self.collectionView];
}

/** 初始化默认设置 */
- (void)_initSetting{
    
    self.backgroundColor = [UIColor whiteColor];
    _autoDuration = 3.0;
    _autoScroll = YES;
    _pageControlStyle = PageControlSystem;
    _pageControlAliment = PageControlAlimentCenter;
    _pageControlDotSize = kPageControlDotDefaultSize;
    _pageControlBottomMargin = 10.0f;
    _pageControlHorizontalEdgeMargin = 10.0f;
    _pageControlPadding = 5.0f;
    _pageControlNormalColor = [UIColor lightGrayColor];
    _pageControlHighlightColor = [UIColor whiteColor];
    _bannerImageViewContentMode = UIViewContentModeScaleToFill;
    
    _titleFont = [UIFont systemFontOfSize:14.0f];
    _titleTextColor = [UIColor whiteColor];
    _titleBackgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]; // 黑0.5
    _titleHeight = 30.0f;
    _titleEdgeMargin = 10.0f;
    _titleAlignment = NSTextAlignmentLeft;
    _bannerGestureEnable = YES;
    _saveScrollViewGestures = self.collectionView.gestureRecognizers;
    _cycleScrollEnable = YES;
    
    _showFooter = NO;
    _footerIndicateImageName = @"YJBannerView.bundle/yjbanner_arrow.png";
    _footerNormalTitle = @"拖动查看详情";
    _footerTriggerTitle = @"释放查看详情";
    _footerTitleFont = [UIFont systemFontOfSize:12.0f];
    _footerTitleColor = [UIColor darkGrayColor];
}

#pragma mark - Setter && Getter
- (void)setPlaceholderImageName:(NSString *)placeholderImageName{
    _placeholderImageName = placeholderImageName;
    self.backgroundImageView.image = [UIImage imageNamed:placeholderImageName];
}

- (void)setPageControlDotSize:(CGSize)pageControlDotSize{
    
    _pageControlDotSize = pageControlDotSize;
    
    [self _setupPageControl];
    if ([self.pageControl isKindOfClass:[YJHollowPageControl class]]) {
        YJHollowPageControl *pageContol = (YJHollowPageControl *)_pageControl;
        pageContol.dotSize = pageControlDotSize;
    }
}

- (void)setPageControlStyle:(PageControlStyle)pageControlStyle{
    
    _pageControlStyle = pageControlStyle;
    
    [self _setupPageControl];
}

- (void)setPageControlNormalColor:(UIColor *)pageControlNormalColor{
    
    _pageControlNormalColor = pageControlNormalColor;
    
    if ([self.pageControl isKindOfClass:[YJHollowPageControl class]]) {
        YJHollowPageControl *pageControl = (YJHollowPageControl *)_pageControl;
        pageControl.dotColor = pageControlNormalColor;
    }else if ([self.pageControl isKindOfClass:[UIPageControl class]]) {
        UIPageControl *pageControl = (UIPageControl *)_pageControl;
        pageControl.pageIndicatorTintColor = pageControlNormalColor;
    }
}

- (void)setPageControlHighlightColor:(UIColor *)pageControlHighlightColor{
    
    _pageControlHighlightColor = pageControlHighlightColor;
    
    if ([self.pageControl isKindOfClass:[YJHollowPageControl class]]) {
        YJHollowPageControl *pageControl = (YJHollowPageControl *)_pageControl;
        pageControl.currentDotColor = pageControlHighlightColor;
    } else if ([self.pageControl isKindOfClass:[UIPageControl class]]){
        UIPageControl *pageControl = (UIPageControl *)_pageControl;
        pageControl.currentPageIndicatorTintColor = pageControlHighlightColor;
    }
}

- (void)setCustomPageControlNormalImage:(UIImage *)customPageControlNormalImage{
    _customPageControlNormalImage = customPageControlNormalImage;
    [self setCustomPageControlDotImage:customPageControlNormalImage isCurrentPageDot:NO];
}

- (void)setCustomPageControlHighlightImage:(UIImage *)customPageControlHighlightImage{
    _customPageControlHighlightImage = customPageControlHighlightImage;
    [self setCustomPageControlDotImage:customPageControlHighlightImage isCurrentPageDot:YES];
}

- (void)setCustomPageControlDotImage:(UIImage *)image isCurrentPageDot:(BOOL)isCurrentPageDot{
    
    if (!image || !self.pageControl) return;
    
    if ([self.pageControl isKindOfClass:[YJHollowPageControl class]]) {
        YJHollowPageControl *pageControl = (YJHollowPageControl *)_pageControl;
        if (isCurrentPageDot) {
            pageControl.currentDotImage = image;
        } else {
            pageControl.dotImage = image;
        }
    }
}

- (void)setAutoScroll:(BOOL)autoScroll{
    
    _autoScroll = autoScroll;
    
    [self invalidateTimer];
    
    if (autoScroll) {
        [self _setupTimer];
    }
}

-(void)setBannerViewScrollDirection:(BannerViewDirection)bannerViewScrollDirection{
    
    if (self.showFooter && bannerViewScrollDirection != BannerViewDirectionLeft) {
        bannerViewScrollDirection = BannerViewDirectionLeft;
    }

    _bannerViewScrollDirection = bannerViewScrollDirection;
    
    if (bannerViewScrollDirection == BannerViewDirectionLeft || bannerViewScrollDirection == BannerViewDirectionRight) {
        self.flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }else if (bannerViewScrollDirection == BannerViewDirectionTop || bannerViewScrollDirection == BannerViewDirectionBottom){
        self.flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    }
}

- (void)setAutoDuration:(CGFloat)autoDuration{
    
    _autoDuration = autoDuration;
    
    [self setAutoScroll:self.autoScroll];
}

- (void)setBannerGestureEnable:(BOOL)bannerGestureEnable{
    if (_bannerGestureEnable && bannerGestureEnable) { // 不操作
    }else if (!_bannerGestureEnable && bannerGestureEnable){
        self.collectionView.canCancelContentTouches = YES;
        for (NSInteger i = 0; i < self.saveScrollViewGestures.count; i++) {
            UIGestureRecognizer *gesture = self.saveScrollViewGestures[i];
            [self.collectionView addGestureRecognizer:gesture];
        }
    }else if (_bannerGestureEnable && !bannerGestureEnable){
        self.collectionView.canCancelContentTouches = NO;
        for (UIGestureRecognizer *gesture in self.collectionView.gestureRecognizers) {
            [self.collectionView removeGestureRecognizer:gesture];
        }
    }
    _bannerGestureEnable = bannerGestureEnable;
}

- (void)setBannerImageViewContentMode:(UIViewContentMode)bannerImageViewContentMode{
    _bannerImageViewContentMode = bannerImageViewContentMode;
    self.backgroundImageView.contentMode = bannerImageViewContentMode;
}

- (void)setShowFooter:(BOOL)showFooter{
    _showFooter = showFooter;
    
    if (_showFooter) {
        
        self.bannerViewScrollDirection = BannerViewDirectionLeft;
        self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, -[self _bannerViewFooterHeight]);
    }else{
        self.collectionView.contentInset = UIEdgeInsetsZero;
    }
    
    if (self.bannerViewScrollDirection == BannerViewDirectionLeft) {
        self.collectionView.alwaysBounceHorizontal = _showFooter;
    }else {
        self.collectionView.accessibilityViewIsModal = _showFooter;
    }
}

#pragma mark - Getter
- (NSInteger)totalItemsCount{
    return self.cycleScrollEnable?([self _imageDataSources].count * totalCollectionViewCellCount):([self _imageDataSources].count);
}

- (BOOL)autoScroll{
    if (self.showFooter) {
        return NO;
    }
    return _autoScroll;
}

- (BOOL)cycleScrollEnable{
    if (self.showFooter) {
        return NO;
    }
    return _cycleScrollEnable;
}

#pragma mark - layoutSubviews
- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.dataSource = self.dataSource;
    [super layoutSubviews];
    
    self.flowLayout.itemSize = self.frame.size;
    
    self.collectionView.frame = self.bounds;
    
    if (self.collectionView.contentOffset.x == 0 &&  self.totalItemsCount) {
        int targetIndex = self.cycleScrollEnable?(self.totalItemsCount * 0.5):(0);
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
    
    CGSize size = CGSizeZero;
    
    if ([self.pageControl isKindOfClass:[YJHollowPageControl class]]) {
        
        YJHollowPageControl *pageControl = (YJHollowPageControl *)_pageControl;
        
        if (!(self.customPageControlNormalImage && self.customPageControlHighlightImage && CGSizeEqualToSize(kPageControlDotDefaultSize, self.pageControlDotSize))) {
            pageControl.dotSize = self.pageControlDotSize;
        }
        
        size = [pageControl sizeForNumberOfPages:[self _imageDataSources].count];
    } else {
        size = CGSizeMake([self _imageDataSources].count * self.pageControlDotSize.width * 1.5, self.pageControlDotSize.height);
    }
    CGFloat x = (self.width_bannerView - size.width) * 0.5;
    if (self.pageControlAliment == PageControlAlimentLeft) { // 靠左
        
        x = 0.0f;
        
    }else if (self.pageControlAliment == PageControlAlimentCenter){ // 居中
    
    }else if (self.pageControlAliment == PageControlAlimentRight){ // 靠右
        
        x = self.collectionView.width_bannerView - size.width;
        
    }
    
    CGFloat y = self.collectionView.height_bannerView - size.height;
    
    if ([self.pageControl isKindOfClass:[YJHollowPageControl class]]) {
        
        YJHollowPageControl *pageControl = (YJHollowPageControl *)_pageControl;
        [pageControl sizeToFit];
    }
    
    CGRect pageControlFrame = CGRectMake(x, y, size.width, size.height);
    if (self.pageControlAliment == PageControlAlimentLeft) {
        pageControlFrame.origin.x += self.pageControlHorizontalEdgeMargin;
    }else if (self.pageControlAliment == PageControlAlimentRight){
        pageControlFrame.origin.x -= self.pageControlHorizontalEdgeMargin;
    }
    pageControlFrame.origin.y -= self.pageControlBottomMargin;
    self.pageControl.frame = pageControlFrame;
    
    self.pageControl.hidden = self.pageControlStyle == PageControlNone;
    
    if (self.backgroundImageView) {
        self.backgroundImageView.frame = self.bounds;
    }
}

#pragma mark - 解决兼容优化问题
- (void)willMoveToSuperview:(UIView *)newSuperview{
    
    if (!newSuperview) {
        [self invalidateTimer];
    }
}

- (void)adjustBannerViewWhenViewWillAppear{
    
    long targetIndex = [self _currentIndex];
    if (targetIndex < self.totalItemsCount) {
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.totalItemsCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    YJBannerViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:bannerViewCellId forIndexPath:indexPath];
    long itemIndex = [self _showIndexWithCurrentCellIndex:indexPath.item];
    
    // 自定义 Cell
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(bannerView:customCell:index:)] && [self.dataSource respondsToSelector:@selector(bannerViewCustomCellClass:)] && [self.dataSource bannerViewCustomCellClass:self]) {
        [self.dataSource bannerView:self customCell:cell index:itemIndex];
        return cell;
    }
    
    // 自定义 View
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(bannerView:viewForItemAtIndex:)] && [self.dataSource bannerView:self viewForItemAtIndex:itemIndex]) {
        cell.customView = [self.dataSource bannerView:self viewForItemAtIndex:itemIndex];
        return cell;
    }
    
    NSString *imagePath = (itemIndex < [self _imageDataSources].count)?[self _imageDataSources][itemIndex]:nil;
    NSString *title = (itemIndex < [self _titlesDataSources].count)?[self _titlesDataSources][itemIndex]:nil;
    
    if (!cell.isConfigured) {
        cell.titleLabelBackgroundColor = self.titleBackgroundColor;
        cell.titleLabelHeight = self.titleHeight;
        cell.titleLabelEdgeMargin = self.titleEdgeMargin;
        cell.titleLabelTextAlignment = self.titleAlignment;
        cell.titleLabelTextColor = self.titleTextColor;
        cell.titleLabelTextFont = self.titleFont;
        cell.isConfigured = YES;
        cell.showImageViewContentMode = self.bannerImageViewContentMode;
        cell.clipsToBounds = YES;
    }
    
    [cell cellWithSelectorString:self.bannerViewSelectorString imagePath:imagePath placeholderImageName:self.placeholderImageName title:title];

    return cell;
}

// 设置Footer的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake([self _bannerViewFooterHeight], self.frame.size.height);
}

// Footer
- (UICollectionReusableView *)collectionView:(UICollectionView *)theCollectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)theIndexPath{
    
    if(kind == UICollectionElementKindSectionFooter){
        
        YJBannerViewFooter *footer = [theCollectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:bannerViewFooterId forIndexPath:theIndexPath];
        self.bannerFooter = footer;
        
        footer.IndicateImageName = self.footerIndicateImageName;
        footer.footerTitleFont = self.footerTitleFont;
        footer.footerTitleColor = self.footerTitleColor;
        footer.idleTitle = self.footerNormalTitle;
        footer.triggerTitle = self.footerTriggerTitle;

        footer.hidden = !self.showFooter;
        
        return footer;
    }
    
    return nil;
}

#pragma mark - UIScrollViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.delegate && [self.delegate respondsToSelector:@selector(bannerView:didSelectItemAtIndex:)]) {
        [self.delegate bannerView:self didSelectItemAtIndex:[self _showIndexWithCurrentCellIndex:indexPath.item]];
    }
    if (self.didSelectItemAtIndexBlock) {
        self.didSelectItemAtIndexBlock([self _showIndexWithCurrentCellIndex:indexPath.item]);
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (![self _imageDataSources].count) return;
    int itemIndex = [self _currentIndex];
    int indexOnPageControl = [self _showIndexWithCurrentCellIndex:itemIndex];
    
    if ([self.pageControl isKindOfClass:[YJHollowPageControl class]]) {
        YJHollowPageControl *pageControl = (YJHollowPageControl *)_pageControl;
        pageControl.currentPage = indexOnPageControl;
    } else {
        UIPageControl *pageControl = (UIPageControl *)_pageControl;
        pageControl.currentPage = indexOnPageControl;
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(bannerView:didScrollCurrentIndex:)]) {
        [self.delegate bannerView:self didScrollCurrentIndex:indexOnPageControl];
    }
    
    // Footer
    if (self.showFooter) {
        static CGFloat lastOffset;
        CGFloat footerDisplayOffset = (self.collectionView.contentOffset.x - (self.flowLayout.itemSize.width * (self.totalItemsCount - 1)));
        
        if (footerDisplayOffset > 0){
            if (footerDisplayOffset > [self _bannerViewFooterHeight]) {
                if (lastOffset > 0) return;
                self.bannerFooter.state = YJBannerViewStatusTrigger;
            } else {
                if (lastOffset < 0) return;
                self.bannerFooter.state = YJBannerViewStatusIdle;
            }
            lastOffset = footerDisplayOffset - [self _bannerViewFooterHeight];
        }
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (self.autoScroll) {
        [self invalidateTimer];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (self.autoScroll) {
        [self _setupTimer];
    }
    
    if (self.showFooter) {
        CGFloat footerDisplayOffset = (self.collectionView.contentOffset.x - (self.flowLayout.itemSize.width * (self.totalItemsCount - 1)));
        
        if (footerDisplayOffset > [self _bannerViewFooterHeight]) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(bannerViewFooterDidEndTrigger:)]) {
                [self.delegate bannerViewFooterDidEndTrigger:self];
            }
            
            if (self.didEndTriggerFooterBlock) {
                self.didEndTriggerFooterBlock();
            }
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self scrollViewDidEndScrollingAnimation:self.collectionView];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    if (![self _imageDataSources].count) return;
    int itemIndex = [self _currentIndex];
    int indexOnPageControl = [self _showIndexWithCurrentCellIndex:itemIndex];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(bannerView:didScroll2Index:)]) {
        [self.delegate bannerView:self didScroll2Index:indexOnPageControl];
    }
    if (self.didScroll2IndexBlock) {
        self.didScroll2IndexBlock(indexOnPageControl);
    }
}

#pragma mark - 私有功能方法
/** 安装PageControl */
- (void)_setupPageControl{
    
    if (_pageControl) [_pageControl removeFromSuperview];
    
    if ([self _imageDataSources].count == 0) {return;}
    
    if ([self _imageDataSources].count == 1) {return;}
    
    int indexOnPageControl = [self _showIndexWithCurrentCellIndex:[self _currentIndex]];
    
    switch (self.pageControlStyle) {
        case PageControlNone:{
            break;
        }
        case PageControlSystem:{
            UIPageControl *pageControl = [[UIPageControl alloc] init];
            pageControl.numberOfPages = [self _imageDataSources].count;
            pageControl.currentPageIndicatorTintColor = self.pageControlHighlightColor;
            pageControl.pageIndicatorTintColor = self.pageControlNormalColor;
            pageControl.userInteractionEnabled = NO;
            pageControl.currentPage = indexOnPageControl;
            [self addSubview:pageControl];
            _pageControl = pageControl;
            break;
        }
        case PageControlHollow:{
            YJHollowPageControl *pageControl = [[YJHollowPageControl alloc] init];
            pageControl.numberOfPages = [self _imageDataSources].count;
            pageControl.dotColor = self.pageControlNormalColor;
            pageControl.currentDotColor = self.pageControlHighlightColor;
            pageControl.userInteractionEnabled = NO;
            pageControl.resizeScale = 1.0;
            pageControl.spacing = self.pageControlPadding;
            pageControl.currentPage = indexOnPageControl;
            [self addSubview:pageControl];
            _pageControl = pageControl;
            break;
        }
        case PageControlCustom:{
            
            YJHollowPageControl *pageControl = [[YJHollowPageControl alloc] init];
            pageControl.numberOfPages = [self _imageDataSources].count;
            pageControl.dotColor = self.pageControlNormalColor;
            pageControl.currentDotColor = self.pageControlHighlightColor;
            pageControl.userInteractionEnabled = NO;
            pageControl.resizeScale = 1.0;
            pageControl.spacing = self.pageControlPadding;
            pageControl.currentPage = indexOnPageControl;
            [self addSubview:pageControl];
            _pageControl = pageControl;
            
            if (self.customPageControlNormalImage) {
                self.customPageControlNormalImage = self.customPageControlNormalImage;
            }
            
            if (self.customPageControlHighlightImage) {
                self.customPageControlHighlightImage = self.customPageControlHighlightImage;
            }
        }
        default:
            break;
    }
}

/** 安装定时器 */
- (void)_setupTimer{
    
    [self invalidateTimer];
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:self.autoDuration target:self selector:@selector(_automaticScrollAction) userInfo:nil repeats:YES];
    _timer = timer;
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

/** 停止定时器 */
- (void)invalidateTimer{
    
    [_timer invalidate];
    _timer = nil;
}

- (void)_automaticScrollAction{
    
    if (self.totalItemsCount == 0) return;
    int currentIndex = [self _currentIndex];
    if (self.bannerViewScrollDirection == BannerViewDirectionLeft || self.bannerViewScrollDirection == BannerViewDirectionTop) {
        [self _scrollToIndex:currentIndex + 1];
    }else if (self.bannerViewScrollDirection == BannerViewDirectionRight || self.bannerViewScrollDirection == BannerViewDirectionBottom){
        if ((currentIndex - 1) < 0) { // 小于零
            currentIndex = self.cycleScrollEnable?(self.totalItemsCount * 0.5):(0);
            [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:(currentIndex - 1) inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        }else{
            [self _scrollToIndex:currentIndex - 1];
        }
    }
}

- (void)_scrollToIndex:(int)targetIndex{
    
    if (targetIndex >= self.totalItemsCount) {  // 超过最大
        targetIndex = self.cycleScrollEnable?(self.totalItemsCount * 0.5):(0);
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }else{
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    }
}

/** 当前的页数 */
- (int)_currentIndex{
    
    if (self.collectionView.width_bannerView == 0 || self.collectionView.height_bannerView == 0) {return 0;}
    int index = 0;
    if (self.flowLayout.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
        index = (self.collectionView.contentOffset.x + self.flowLayout.itemSize.width * 0.5) / self.flowLayout.itemSize.width;
    } else {
        index = (self.collectionView.contentOffset.y + self.flowLayout.itemSize.height * 0.5) / self.flowLayout.itemSize.height;
    }
    return MAX(0, index);
}

/** 当前是排第几个 */
- (int)_showIndexWithCurrentCellIndex:(NSInteger)cellIndex{
    return (int)cellIndex % [self _imageDataSources].count;
}

/** 显示图片的数组 */
- (NSArray *)_imageDataSources{
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(bannerViewImages:)]) {
        return [self.dataSource bannerViewImages:self];
    }
    return @[];
}

/** 显示的标题数组 */
- (NSArray *)_titlesDataSources{
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(bannerViewTitles:)]) {
        return [self.dataSource bannerViewTitles:self];
    }
    return @[];
}

/** Footer Height */
- (CGFloat)_bannerViewFooterHeight{
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(bannerViewFooterViewHeight:)]) {
        return [self.dataSource bannerViewFooterViewHeight:self];
    }
    return BANNER_FOOTER_HEIGHT;
}

#pragma mark - Lazy
- (UIImageView *)backgroundImageView{
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _backgroundImageView.contentMode = self.bannerImageViewContentMode;
        _backgroundImageView.hidden = YES;
        [self insertSubview:_backgroundImageView belowSubview:self.collectionView];
    }
    return _backgroundImageView;
}

- (UICollectionViewFlowLayout *)flowLayout{
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.minimumLineSpacing = 0.0f;
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return _flowLayout;
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:self.flowLayout];
        _collectionView.pagingEnabled = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor clearColor];

        [_collectionView registerClass:[YJBannerViewCell class] forCellWithReuseIdentifier:bannerViewCellId];
        [_collectionView registerClass:[YJBannerViewFooter class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:bannerViewFooterId];
        
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.scrollsToTop = NO;
    }
    return _collectionView;
}

- (void)dealloc {
    self.collectionView.delegate = nil;
    self.collectionView.dataSource = nil;
}

@end
