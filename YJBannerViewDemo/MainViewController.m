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
#import "DetailViewController.h"
#import "MainViewModel.h"

static CGFloat const midMargin = 15.0f;

@interface MainViewController () <YJBannerViewDataSource, YJBannerViewDelegate>

@property (nonatomic, strong) MainViewModel *viewModel;
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

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.normalBannerView adjustBannerViewWhenViewWillAppear];
    [self.headlinesBannerView adjustBannerViewWhenViewWillAppear];
    [self.goodDetailBannerView adjustBannerViewWhenViewWillAppear];
    [self.customBannerView adjustBannerViewWhenViewWillAppear];
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

    // 刷新数据
    [self.normalBannerView reloadData];
    [self.headlinesBannerView reloadData];
    [self.goodDetailBannerView reloadData];
    [self.customBannerView reloadData];
}


#pragma mark - DataSources
- (NSArray *)bannerViewImages:(YJBannerView *)bannerView{
    if (bannerView == self.normalBannerView) {
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

- (Class)bannerViewCustomCellClass:(YJBannerView *)bannerView{
    if (bannerView == self.headlinesBannerView) {
        return [HeadLinesCell class];
    }
    return nil;
}

- (void)bannerView:(YJBannerView *)bannerView customCell:(UICollectionViewCell *)customCell index:(NSInteger)index{
    
    if (bannerView == self.headlinesBannerView) {
        HeadLinesCell *cell = (HeadLinesCell *)customCell;
        [cell cellWithHeadHotLineCellData:self.viewModel.hotTitles[index]];
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
        _normalBannerView = [YJBannerView bannerViewWithFrame:CGRectMake(0, 20, kSCREEN_WIDTH, 180) dataSource:self delegate:self placeholderImageName:@"placeholder" selectorString:@"sd_setImageWithURL:placeholderImage:"];
        _normalBannerView.autoDuration = 2.5f;
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
        _goodDetailBannerView.showFooter = YES;
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

- (MainViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [[MainViewModel alloc] init];
    }
    return _viewModel;
}

@end
