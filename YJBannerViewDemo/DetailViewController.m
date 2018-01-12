//
//  DetailViewController.m
//  YJBannerViewDemo
//
//  Created by YJHou on 2015/5/24.
//  Copyright © 2015年 Address:https://github.com/stackhou . All rights reserved.
//

#import "DetailViewController.h"
#import "YJBannerView.h"
#import "MainViewModel.h"
#import "NSArray+YJBannerView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "DynamicBgViewController.h"
#import "YJCustomGapCell.h"

@interface DetailViewController () <YJBannerViewDataSource, YJBannerViewDelegate>

@property (nonatomic, strong) YJBannerView *detailBannerView;
@property (nonatomic, strong) MainViewModel *viewModel;
@property (nonatomic, strong) YJBannerView *customBannerView; /**< 自定义View 适用于不同尺寸的显示 */

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"详情页";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(closeCurrentController)];
    [self _setUpDetailMainView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[self createImageWithColor:[self colorFromHexRGB:@"2fbff7"] alpha:1] forBarMetrics:UIBarMetricsDefault];

    [self.detailBannerView adjustBannerViewWhenCardScreen];
    [self.customBannerView adjustBannerViewWhenCardScreen];
}

- (void)closeCurrentController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)_setUpDetailMainView{
    
    [self.view addSubview:self.detailBannerView];
    [self.view addSubview:self.customBannerView];
    
    [self.detailBannerView reloadData];
    
    // 每次刷新前清空自定义View
    [self.customBannerView reloadData];
}

#pragma mark - DataSource
- (NSArray *)bannerViewImages:(YJBannerView *)bannerView{
    if (bannerView == self.detailBannerView) {
        return self.viewModel.customBannerViewImages;
    }else{
        return nil;
    }
}

- (NSArray *)bannerViewRegistCustomCellClass:(YJBannerView *)bannerView{
    if (bannerView == self.detailBannerView) {
        return @[[YJCustomGapCell class]];
    }
    return nil;
}

- (Class)bannerView:(YJBannerView *)bannerView reuseIdentifierForIndex:(NSInteger)index{
    if (bannerView == self.detailBannerView) {
        return [YJCustomGapCell class];
    }
    return nil;
}

- (UICollectionViewCell *)bannerView:(YJBannerView *)bannerView customCell:(UICollectionViewCell *)customCell index:(NSInteger)index{
    if (bannerView == self.detailBannerView) {
        YJCustomGapCell *cell = (YJCustomGapCell *)customCell;
        
        [cell cellWithImagePath:self.viewModel.customBannerViewImages[index]];
        
        if (index == 0 || index == 2) {
            return cell;
        }
        return nil;
    }
    return nil;
}

- (void)bannerView:(YJBannerView *)bannerView didSelectItemAtIndex:(NSInteger)index{
    
    DynamicBgViewController *vc = [[DynamicBgViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)bannerView:(YJBannerView *)bannerView didScrollCurrentIndex:(NSInteger)currentIndex contentOffset:(CGFloat)contentOffset{
    
    
}

#pragma mark - Lazy
- (YJBannerView *)detailBannerView{
    if (!_detailBannerView) {
        _detailBannerView = [YJBannerView bannerViewWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 180) dataSource:self delegate:self emptyImage:[UIImage imageNamed:@"placeholder"] placeholderImage:[UIImage imageNamed:@"placeholder"] selectorString:@"sd_setImageWithURL:placeholderImage:"];
        _detailBannerView.autoScroll = NO;
        _detailBannerView.repeatCount = 10;
    }
    return _detailBannerView;
}

- (MainViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [[MainViewModel alloc] init];
    }
    return _viewModel;
}

- (YJBannerView *)customBannerView{
    if (!_customBannerView) {
        _customBannerView = [YJBannerView bannerViewWithFrame:CGRectMake(0, 190, kSCREEN_WIDTH, 180) dataSource:self delegate:self emptyImage:[UIImage imageNamed:@"placeholder"] placeholderImage:[UIImage imageNamed:@"placeholder"] selectorString:@"sd_setImageWithURL:placeholderImage:"];
        _customBannerView.pageControlStyle = PageControlCustom;
        _customBannerView.customPageControlHighlightImage = [UIImage imageNamed:@"pageControlCurrentDot"];
        _customBannerView.customPageControlNormalImage = [UIImage imageNamed:@"pageControlDot"];
    }
    return _customBannerView;
}

- (UIImage *)createImageWithColor:(UIColor *)color alpha:(CGFloat)alpha{
    
    UIColor *drewColor = nil;
    if (alpha == 0) {
        drewColor = [UIColor clearColor];
    }else{
        drewColor = [color colorWithAlphaComponent:alpha];
    }
    
    CGSize colorSize = CGSizeMake(1, 1);
    UIGraphicsBeginImageContext(colorSize);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, drewColor.CGColor);
    CGContextFillRect(context, CGRectMake(0, 0, 1, 1));
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

- (UIColor *)colorFromHexRGB:(NSString *)inColorString{
    UIColor *result = nil;
    unsigned int colorCode = 0;
    unsigned char redByte, greenByte, blueByte;
    
    if (nil != inColorString){
        NSScanner *scanner = [NSScanner scannerWithString:inColorString];
        (void) [scanner scanHexInt:&colorCode];
    }
    redByte = (unsigned char) (colorCode >> 16);
    greenByte = (unsigned char) (colorCode >> 8);
    blueByte = (unsigned char) (colorCode);
    result = [UIColor colorWithRed: (float)redByte / 0xff green: (float)greenByte/ 0xff blue: (float)blueByte / 0xff alpha:1.0];
    return result;
}

@end
