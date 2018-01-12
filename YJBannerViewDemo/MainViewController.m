//
//  MainViewController.m
//  YJBannerViewDemo
//
//  Created by YJHou on 2015/5/24.
//  Copyright © 2015年 Address:https://github.com/stackhou . All rights reserved.
//

#import "MainViewController.h"
#import "YJBannerView.h"
#import "HeadLinesCell.h"
#import "DetailViewController.h"
#import "MainViewModel.h"
#import "YJCustomView.h"
#import "YJCustomViewB.h"
#import <ZFPlayer.h>

static CGFloat const midMargin = 15.0f;

@interface MainViewController () <YJBannerViewDataSource, YJBannerViewDelegate, ZFPlayerDelegate>

@property (nonatomic, strong) MainViewModel *viewModel;
@property (nonatomic, strong) YJBannerView *normalBannerView; /**< 普通的banner */
@property (nonatomic, strong) UILabel *headlinesLabel; /**< 头条tag*/
@property (nonatomic, strong) YJBannerView *headlinesBannerView; /**< 头条BannerView */
@property (nonatomic, strong) YJBannerView *goodDetailBannerView; /**< 商品详情 */
@property (nonatomic, strong) YJBannerView *customBannerView; /**< 自定义 */

@property (nonatomic, strong) UIView *testCreateTimeView; /**< 创建View的时间测试 */
@property (nonatomic, strong) UILabel *testCreateTimeLabel; /**< 创建Label的时间测试 */
@property (nonatomic, strong) ZFPlayerView        *playerView;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self _setUpMainView];
    [self _loadDataSources];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.normalBannerView startTimerWhenAutoScroll];
    
    [self.normalBannerView adjustBannerViewWhenCardScreen];
    [self.headlinesBannerView adjustBannerViewWhenCardScreen];
    [self.goodDetailBannerView adjustBannerViewWhenCardScreen];
    [self.customBannerView adjustBannerViewWhenCardScreen];
}

// 页面消失时候
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.playerView resetPlayer];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.normalBannerView invalidateTimerWhenAutoScroll];
}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event{
}

- (void)_setUpMainView{
    
    UIScrollView *containerScrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:containerScrollView];
    
    // 创建测试View的时间
    CFAbsoluteTime testViewStartTime = CFAbsoluteTimeGetCurrent();
    [containerScrollView addSubview:self.testCreateTimeView];
    CFTimeInterval testViewTime = fabs((CFAbsoluteTimeGetCurrent() - testViewStartTime));
    NSLog(@"创建一个 UIView 时间 = %f 秒", testViewTime);
    
    // 创建测试Label的时间
    CFAbsoluteTime testLabelStartTime = CFAbsoluteTimeGetCurrent();
    [containerScrollView addSubview:self.testCreateTimeLabel];
    CFTimeInterval testLabelTime = fabs((CFAbsoluteTimeGetCurrent() - testLabelStartTime));
    NSLog(@"创建一个 UILabel 时间 = %f 秒", testLabelTime);

    CFAbsoluteTime normalBannerStartTime = CFAbsoluteTimeGetCurrent();
    [containerScrollView addSubview:self.normalBannerView];
    CFTimeInterval normalBannerTime = fabs((CFAbsoluteTimeGetCurrent() - normalBannerStartTime));
    NSLog(@"创建一个 YJBannerView 的时间 = %f 秒", normalBannerTime);
    
    [containerScrollView addSubview:self.headlinesLabel];
    [containerScrollView addSubview:self.headlinesBannerView];
    [containerScrollView addSubview:self.goodDetailBannerView];
    [containerScrollView addSubview:self.customBannerView];
    
    containerScrollView.contentSize = CGSizeMake(kSCREEN_WIDTH, CGRectGetMaxY(self.customBannerView.frame) + midMargin);
}

- (void)_loadDataSources{

    // 刷新数据
    [self.normalBannerView reloadData];
    [self.headlinesBannerView reloadData];
    [self.goodDetailBannerView reloadData];
    [self.customBannerView reloadData];
}


#pragma mark - DataSources
- (NSArray *)bannerViewImages:(YJBannerView *)bannerView{
    if (bannerView == self.normalBannerView) {
//        NSLog(@"-->%@", @"-------");
        return self.viewModel.normalBannerViewImages;
    }else if (bannerView == self.headlinesBannerView){
        return self.viewModel.hotTitles;
    }else if (bannerView == self.goodDetailBannerView){
        return self.viewModel.goodDetailBannerViewImages;
    }else if (bannerView == self.customBannerView){
        return self.viewModel.customBannerViewImages;
    }
    return nil;
}

- (NSArray *)bannerViewTitles:(YJBannerView *)bannerView{
    if (bannerView == self.normalBannerView) {
        return @[@"我是第一个标题"];
    }else if (bannerView == self.headlinesBannerView){
        return @[];
    }else if (bannerView == self.goodDetailBannerView){
        return @[];
    }else if (bannerView == self.customBannerView){
        return @[];
    }
    return nil;
}

- (NSArray *)bannerViewRegistCustomCellClass:(YJBannerView *)bannerView{
    if (bannerView == self.headlinesBannerView) {
        return @[[HeadLinesCell class]];
    }
    
    if (bannerView == self.goodDetailBannerView) {
        return @[[YJCustomView class], [YJCustomViewB class]];
    }
    return nil;
}

- (Class)bannerView:(YJBannerView *)bannerView reuseIdentifierForIndex:(NSInteger)index{
    if (bannerView == self.headlinesBannerView) {
        return [HeadLinesCell class];
    }else if (bannerView == self.goodDetailBannerView){
        if (index == 0) {
            return [YJCustomView class];
        }else if (index == 1){
            return [YJCustomViewB class];
        }
    }
    return nil;
}

- (UICollectionViewCell *)bannerView:(YJBannerView *)bannerView customCell:(UICollectionViewCell *)customCell index:(NSInteger)index{
    __weak typeof(self) weakSelf = self;
    if (bannerView == self.headlinesBannerView) {
        HeadLinesCell *cell = (HeadLinesCell *)customCell;
        [cell cellWithHeadHotLineCellData:self.viewModel.hotTitles[index]];
        return cell;
    }
    
    if (bannerView == self.goodDetailBannerView) {
        if (index == 0) {
            
            // 分辨率字典（key:分辨率名称，value：分辨率url)
//            NSMutableDictionary *dic = @{}.mutableCopy;
            YJCustomView *cell = (YJCustomView *)customCell;
            [cell cellWithcoverForFeed:@""];
            
            __weak typeof(cell) weakCell = cell;
            cell.playBlock = ^(UIButton *btn) {
                NSLog(@"-->%@", @"开始播放");
                ZFPlayerModel *playerModel = [[ZFPlayerModel alloc] init];
                playerModel.title            = @"";
                NSString *locaPath = [[NSBundle mainBundle] pathForResource:@"avdemo01" ofType:@"mp4"];
                playerModel.videoURL         = [NSURL fileURLWithPath:locaPath];
//                playerModel.videoURL         = [NSURL URLWithString:@"http://120.25.226.186:32812/resources/videos/minion_01.mp4"];
                playerModel.placeholderImageURLString = @"";
                playerModel.scrollView       = bannerView.collectionView;
                playerModel.indexPath        = [NSIndexPath indexPathForRow:index inSection:0];
                // 赋值分辨率字典
//                playerModel.resolutionDic    = dic;
                // player的父视图tag
                playerModel.fatherViewTag    = weakCell.imgView.tag;
                
                // 设置播放控制层和model
                [weakSelf.playerView playerControlView:nil playerModel:playerModel];
                // 下载功能
                weakSelf.playerView.hasDownload = NO;
                // 自动播放
                [weakSelf.playerView autoPlayTheVideo];
            };
            
            return cell;
        }else{
            return nil;
        }
    }
    return nil;
}

#pragma mark - Delegate
- (void)bannerView:(YJBannerView *)bannerView didSelectItemAtIndex:(NSInteger)index{
    
//    [self.normalBannerView reloadData];
//
//    return;
    
//    [self.normalBannerView adjustBannerViewScrollToIndex:3 animated:NO];
//
//    return;
    
    if (bannerView == self.goodDetailBannerView) {
        return;
    }
    
    NSString *titleString = @"";
    NSString *showMessage = [NSString stringWithFormat:@"点击了第%ld个", (long)index];
    if (bannerView == self.normalBannerView) {
        titleString = @"第一个BannerView";
    }else if (bannerView == self.headlinesBannerView){
        titleString = @"今日头条";
    }else if (bannerView == self.goodDetailBannerView){
        titleString = @"商品详情";
    }else if (bannerView == self.customBannerView){
        titleString = @"自定义类型";
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:titleString message:showMessage delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert show];
}

- (void)bannerViewFooterDidEndTrigger:(YJBannerView *)bannerView{
    DetailViewController *vc = [[DetailViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
}

#pragma mark - lazy
-(YJBannerView *)normalBannerView{
    if (!_normalBannerView) {
        
//        _normalBannerView = [[YJBannerView alloc] initWithFrame:CGRectMake(10, 20, 30, 40)];
        
        _normalBannerView = [YJBannerView bannerViewWithFrame:CGRectMake(0, 20, kSCREEN_WIDTH, 180) dataSource:self delegate:self emptyImage:[UIImage imageNamed:@"placeholder"] placeholderImage:[UIImage imageNamed:@"placeholder"] selectorString:@"sd_setImageWithURL:placeholderImage:"];
        _normalBannerView.autoDuration = 2.5f;
        _normalBannerView.titleFont = [UIFont systemFontOfSize:20];
//        _normalBannerView.repeatCount = 2;
    }
    return _normalBannerView;
}

- (UILabel *)headlinesLabel{
    if (!_headlinesLabel) {
        _headlinesLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.normalBannerView.frame) + 8, 70, 24)];
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
        _headlinesBannerView = [YJBannerView bannerViewWithFrame:CGRectMake(90, CGRectGetMaxY(self.normalBannerView.frame), kSCREEN_WIDTH - 60, 40) dataSource:self delegate:self emptyImage:[UIImage imageNamed:@"placeholder"] placeholderImage:[UIImage imageNamed:@"placeholder"] selectorString:nil];
        _headlinesBannerView.bannerViewScrollDirection = BannerViewDirectionTop;
        _headlinesBannerView.bannerGestureEnable = NO;
        _headlinesBannerView.pageControlStyle = PageControlNone;
    }
    return _headlinesBannerView;
}

- (YJBannerView *)goodDetailBannerView{
    if (!_goodDetailBannerView) {
        _goodDetailBannerView = [YJBannerView bannerViewWithFrame:CGRectMake(0, CGRectGetMaxY(self.headlinesBannerView.frame), kSCREEN_WIDTH, 180) dataSource:self delegate:self emptyImage:[UIImage imageNamed:@"placeholder"] placeholderImage:[UIImage imageNamed:@"placeholder"] selectorString:@"sd_setImageWithURL:placeholderImage:"];
        _goodDetailBannerView.pageControlStyle = PageControlCustom;
        _goodDetailBannerView.customPageControlHighlightImage = [UIImage imageNamed:@"pageControlCurrentDot"];
        _goodDetailBannerView.customPageControlNormalImage = [UIImage imageNamed:@"pageControlDot"];
        _goodDetailBannerView.showFooter = YES;
        _goodDetailBannerView.pageControlBottomMargin = 5.0f;
    }
    return _goodDetailBannerView;
}

- (YJBannerView *)customBannerView{
    if (!_customBannerView) {
        _customBannerView = [YJBannerView bannerViewWithFrame:CGRectMake(0, CGRectGetMaxY(self.goodDetailBannerView.frame) + 15, kSCREEN_WIDTH, 180) dataSource:self delegate:self emptyImage:[UIImage imageNamed:@"placeholder"] placeholderImage:[UIImage imageNamed:@"placeholder"] selectorString:@"sd_setImageWithURL:placeholderImage:"];
        _customBannerView.pageControlStyle = PageControlCustom;
        _customBannerView.pageControlDotSize = CGSizeMake(10, 5);
//        _customBannerView.pageControlNormalColor = [UIColor orangeColor];
//        _customBannerView.pageControlHighlightColor = [UIColor redColor];
        _customBannerView.customPageControlHighlightImage = [UIImage imageNamed:@"pageControlN"];
        _customBannerView.customPageControlNormalImage = [UIImage imageNamed:@"pageControlS"];
        _customBannerView.pageControlPadding = 8;
        _customBannerView.pageControlAliment = PageControlAlimentRight;
        _customBannerView.pageControlBottomMargin = 6;
    }
    return _customBannerView;
}

#pragma mark - 两个测试View
- (UIView *)testCreateTimeView{
    if (!_testCreateTimeView) {
        _testCreateTimeView = [[UIView alloc] initWithFrame:CGRectMake(10, 20, 30, 40)];
    }
    return _testCreateTimeView;
}

- (UILabel *)testCreateTimeLabel{
    if (!_testCreateTimeLabel) {
        _testCreateTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 30, 40)];
        _testCreateTimeLabel.font = [UIFont systemFontOfSize:14];
    }
    return _testCreateTimeLabel;
}

- (MainViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [[MainViewModel alloc] init];
    }
    return _viewModel;
}

- (ZFPlayerView *)playerView {
    if (!_playerView) {
        _playerView = [ZFPlayerView sharedPlayerView];
        _playerView.delegate = self;
        _playerView.playerLayerGravity = ZFPlayerLayerGravityResizeAspectFill;
        // 当cell播放视频由全屏变为小屏时候，不回到中间位置
        _playerView.cellPlayerOnCenter = NO;
        
        // 当cell划出屏幕的时候停止播放
        // _playerView.stopPlayWhileCellNotVisable = YES;
        //（可选设置）可以设置视频的填充模式，默认为（等比例填充，直到一个维度到达区域边界）
        // _playerView.playerLayerGravity = ZFPlayerLayerGravityResizeAspect;
        // 静音
        // _playerView.mute = YES;
        // 移除屏幕移除player
        // _playerView.stopPlayWhileCellNotVisable = YES;
        ZFPlayerShared.isLockScreen = YES;
        ZFPlayerShared.isStatusBarHidden = NO;
    }
    return _playerView;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    // 这里设置横竖屏不同颜色的statusbar
    if (ZFPlayerShared.isLandscape) {
        return UIStatusBarStyleLightContent;
    }
    return UIStatusBarStyleDefault;
}

- (BOOL)prefersStatusBarHidden {
    return ZFPlayerShared.isStatusBarHidden;
}

@end
