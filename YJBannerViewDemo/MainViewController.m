//
//  MainViewController.m
//  YJBannerViewDemo
//
//  Created by YJHou on 2015/5/24.
//  Copyright © 2015年 地址:https://github.com/YJManager/YJBannerViewOC . All rights reserved.
//

#import "MainViewController.h"
#import "YJBannerView.h"
#import "HeadLinesCell.h"

static CGFloat const midMargin = 15.0f;

@interface MainViewController () <YJBannerViewDataSource, YJBannerViewDelegate>

@property (nonatomic, strong) NSMutableArray *imageDataSources; /**< 图片数据源 */
@property (nonatomic, strong) NSMutableArray *titlesDataSources; /**< 标题数据 */
@property (nonatomic, strong) YJBannerView *normalBannerView; /**< 普通的banner */
@property (nonatomic, strong) UILabel *headlinesLabel; /**< 头条tag*/
@property (nonatomic, strong) YJBannerView *headlinesBannerView; /**< 头条BannerView */
@property (nonatomic, strong) YJBannerView *goodDetailBannerView; /**< 商品详情 */
@property (nonatomic, strong) YJBannerView *customBannerView; /**< 自定义 */

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self _setUpMainView];
    [self _loadDataSources];
    
}

- (void)_setUpMainView{
    
    UIScrollView *containerScrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:containerScrollView];

    [containerScrollView addSubview:self.normalBannerView];
    [containerScrollView addSubview:self.headlinesLabel];
    [containerScrollView addSubview:self.headlinesBannerView];
    [containerScrollView addSubview:self.goodDetailBannerView];
    [containerScrollView addSubview:self.customBannerView];
    
    containerScrollView.contentSize = CGSizeMake(kSCREEN_WIDTH, CGRectGetMaxY(self.customBannerView.frame) + midMargin);
}

- (void)_loadDataSources{
    
    NSArray *imagesURLStrings = @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1495788490274&di=0b9453aab06d2ea5a77a47d0d78cfa83&imgtype=0&src=http%3A%2F%2Fwww.16sucai.com%2Fuploadfile%2F2013%2F0407%2F20130407085208429.jpg",
                                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1495788516621&di=4efa056fe4234193736eb7d4dd48a262&imgtype=0&src=http%3A%2F%2Fpic.58pic.com%2F58pic%2F15%2F87%2F10%2F42N58PICFdP_1024.jpg",
                                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1495788546756&di=2a5e74dcbf61882752005d729c07d39b&imgtype=0&src=http%3A%2F%2Fwww.djhnjllm.com%2Fstatic%2Fupload%2Fimage%2F2013%2F2%2F25%2F0039716899204936.jpg",
                                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1495788599948&di=d6cef2c314498aa0d78202753a6b2493&imgtype=0&src=http%3A%2F%2Fimg3.redocn.com%2Ftupian%2F20151216%2Fshishangnvzhuangwangzhanbanner_5607161.jpg",
                                  @"localImage01.jpeg"
                                  ];
    for (NSInteger i = 0; i < imagesURLStrings.count; i++) {
        [self.imageDataSources addObject:imagesURLStrings[i]];
    }
    
    for (NSInteger i = 0; i < imagesURLStrings.count; i++) {
        [self.titlesDataSources addObject:[NSString stringWithFormat:@"我是标题%ld", (long)i]];
    }

    // 刷新数据
    [self.normalBannerView reloadData];
    [self.headlinesBannerView reloadData];
    [self.goodDetailBannerView reloadData];
    [self.customBannerView reloadData];
}


#pragma mark - DataSources
- (NSArray *)bannerViewImages:(YJBannerView *)bannerView{
    return self.imageDataSources;
}

- (NSArray *)bannerViewTitles:(YJBannerView *)bannerView{
    return self.titlesDataSources;
}

- (Class)bannerViewCustomCellClass:(YJBannerView *)bannerView{
    if (bannerView == self.headlinesBannerView) {
        return [HeadLinesCell class];
    }
    return nil;
}

- (void)bannerView:(YJBannerView *)bannerView customCell:(UICollectionViewCell *)customCell index:(NSInteger)index{
    
    if (bannerView == self.headlinesBannerView) {
        HeadLinesCell *cell = (HeadLinesCell *)customCell;
        [cell cellWithHeadHotLineCellData:@"打折活动开始了~~快来抢购啊"];
    }else{
    
    }
}

/**
- (UIView *)bannerView:(YJBannerView *)bannerView viewForItemAtIndex:(NSInteger)index{
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 100)];
    customView.backgroundColor = kRANDOM_COLOR;
    return customView;
}
 */

#pragma mark - Delegate
- (void)bannerView:(YJBannerView *)bannerView didSelectItemAtIndex:(NSInteger)index{
    NSString *titleString = @"";
    NSString *showMessage = [NSString stringWithFormat:@"点击了第%ld个", index];
    if (bannerView == self.normalBannerView) {
        titleString = @"第一个BannerView";
    }else if (bannerView == self.headlinesBannerView){
        titleString = @"今日头条";
    }else if (bannerView == self.goodDetailBannerView){
        titleString = @"商品详情";
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:titleString message:showMessage delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert show];
}

#pragma mark - lazy
- (NSMutableArray *)imageDataSources{
    if (!_imageDataSources) {
        _imageDataSources = [NSMutableArray array];
    }
    return _imageDataSources;
}

- (NSMutableArray *)titlesDataSources{
    if (!_titlesDataSources) {
        _titlesDataSources = [NSMutableArray array];
    }
    return _titlesDataSources;
}

-(YJBannerView *)normalBannerView{
    if (!_normalBannerView) {
        _normalBannerView = [YJBannerView bannerViewWithFrame:CGRectMake(0, 20, kSCREEN_WIDTH, 180) dataSource:self delegate:self placeholderImageName:@"placeholder" selectorString:@"sd_setImageWithURL:placeholderImage:"];
        _normalBannerView.pageControlAliment = PageControlAlimentRight;
        _normalBannerView.autoDuration = 2.5f;
    }
    return _normalBannerView;
}

- (UILabel *)headlinesLabel{
    if (!_headlinesLabel) {
        _headlinesLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.normalBannerView.frame) + 5, 70, 30)];
        _headlinesLabel.font = [UIFont boldSystemFontOfSize:15];
        _headlinesLabel.textAlignment = NSTextAlignmentLeft;
        _headlinesLabel.backgroundColor = [UIColor clearColor];
        _headlinesLabel.textColor = [UIColor redColor];
        _headlinesLabel.text = @" 今日头条 ";
        _headlinesLabel.layer.cornerRadius = 5.0f;
        _headlinesLabel.layer.borderWidth = 1.0f;
        _headlinesLabel.layer.borderColor = [UIColor redColor].CGColor;
    }
    return _headlinesLabel;
}

- (YJBannerView *)headlinesBannerView{
    if (!_headlinesBannerView) {
        _headlinesBannerView = [YJBannerView bannerViewWithFrame:CGRectMake(90, CGRectGetMaxY(self.normalBannerView.frame), kSCREEN_WIDTH - 60, 40) dataSource:self delegate:self placeholderImageName:nil selectorString:nil];
        _headlinesBannerView.bannerViewScrollDirection = BannerViewDirectionTop;
        _headlinesBannerView.bannerGestureEnable = NO;
        _headlinesBannerView.pageControlStyle = PageControlNone;
    }
    return _headlinesBannerView;
}

- (YJBannerView *)goodDetailBannerView{
    if (!_goodDetailBannerView) {
        _goodDetailBannerView = [YJBannerView bannerViewWithFrame:CGRectMake(0, CGRectGetMaxY(self.headlinesBannerView.frame), kSCREEN_WIDTH, 180) dataSource:self delegate:self placeholderImageName:@"placeholder" selectorString:@"sd_setImageWithURL:placeholderImage:"];
        _goodDetailBannerView.pageControlStyle = PageControlCustom;
        _goodDetailBannerView.customPageControlHighlightImage = [UIImage imageNamed:@"pageControlCurrentDot"];
        _goodDetailBannerView.customPageControlNormalImage = [UIImage imageNamed:@"pageControlDot"];
        _goodDetailBannerView.cycleScrollEnable = NO;
        _goodDetailBannerView.autoScroll = NO;
        
        
    }
    return _goodDetailBannerView;
}

- (YJBannerView *)customBannerView{
    if (!_customBannerView) {
        _customBannerView = [YJBannerView bannerViewWithFrame:CGRectMake(0, CGRectGetMaxY(self.goodDetailBannerView.frame) + 15, kSCREEN_WIDTH, 180) dataSource:self delegate:self placeholderImageName:@"placeholder" selectorString:@"sd_setImageWithURL:placeholderImage:"];
        _customBannerView.pageControlStyle = PageControlCustom;
    }
    return _customBannerView;
}

@end
