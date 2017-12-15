//
//  DetailViewController.m
//  YJBannerViewDemo
//
//  Created by YJHou on 2015/5/24.
//  Copyright © 2015年 地址:https://github.com/stackhou/YJBannerViewOC . All rights reserved.
//

#import "DetailViewController.h"
#import "YJBannerView.h"
#import "MainViewModel.h"
#import "NSArray+YJBannerView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "DynamicBgViewController.h"

@interface DetailViewController () <YJBannerViewDataSource, YJBannerViewDelegate>

@property (nonatomic, strong) YJBannerView *detailBannerView;
@property (nonatomic, strong) MainViewModel *viewModel;
@property (nonatomic, strong) YJBannerView *customBannerView; /**< 自定义View 适用于不同尺寸的显示 */
@property (nonatomic, strong) NSMutableArray *saveBannerCustomViews; /**< 保存自定义BannerView */

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

    [self.detailBannerView adjustBannerViewWhenViewWillAppear];
    [self.customBannerView adjustBannerViewWhenViewWillAppear];
}

- (void)closeCurrentController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)_setUpDetailMainView{
    
    [self.view addSubview:self.detailBannerView];
    [self.view addSubview:self.customBannerView];
    
    [self.detailBannerView reloadData];
    
    // 每次刷新前清空自定义View
    [self.saveBannerCustomViews removeAllObjects];
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

- (UIView *)bannerView:(YJBannerView *)bannerView viewForItemAtIndex:(NSInteger)index{
    
    if (bannerView == self.customBannerView) {
        
        UIImageView *itemView = [self.saveBannerCustomViews objectSafeAtIndex:index];
        if (!itemView) {
            itemView= [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 180)];
            itemView.backgroundColor = [UIColor orangeColor];
            [self.saveBannerCustomViews addObject:itemView];
        }
        
        if (index % 2 == 0) {
            itemView.frame = CGRectMake(0, -40, kSCREEN_WIDTH, 220);
            itemView.backgroundColor = [UIColor redColor];
        }
        
        NSString *imgPath = [self.viewModel.customBannerViewImages objectAtIndex:index];
        
        [itemView sd_setImageWithURL:[NSURL URLWithString:imgPath] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        
        return itemView;
    }
    
    return nil;
}

- (void)bannerView:(YJBannerView *)bannerView didSelectItemAtIndex:(NSInteger)index{
    
    DynamicBgViewController *vc = [[DynamicBgViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark - Lazy
- (YJBannerView *)detailBannerView{
    if (!_detailBannerView) {
        _detailBannerView = [YJBannerView bannerViewWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 180) dataSource:self delegate:self emptyImage:[UIImage imageNamed:@"placeholder"] placeholderImage:[UIImage imageNamed:@"placeholder"] selectorString:@"sd_setImageWithURL:placeholderImage:"];
        _detailBannerView.autoScroll = NO;
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

- (NSMutableArray *)saveBannerCustomViews{
    if (!_saveBannerCustomViews) {
        _saveBannerCustomViews = [NSMutableArray array];
    }
    return _saveBannerCustomViews;
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
