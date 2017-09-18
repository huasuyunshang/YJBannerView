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

@interface DetailViewController () <YJBannerViewDataSource, YJBannerViewDelegate>

@property (nonatomic, strong) YJBannerView *detailBannerView;
@property (nonatomic, strong) MainViewModel *viewModel;

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
}

- (void)closeCurrentController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)_setUpDetailMainView{
    
    [self.view addSubview:self.detailBannerView];
    
    [self.detailBannerView reloadData];
}

#pragma mark - DataSource
- (NSArray *)bannerViewImages:(YJBannerView *)bannerView{
    return self.viewModel.customBannerViewImages;
}

#pragma mark - Lazy
- (YJBannerView *)detailBannerView{
    if (!_detailBannerView) {
        _detailBannerView = [YJBannerView bannerViewWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 180) dataSource:self delegate:self placeholderImageName:@"placeholder" selectorString:@"sd_setImageWithURL:placeholderImage:"];
    }
    return _detailBannerView;
}

- (MainViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [[MainViewModel alloc] init];
    }
    return _viewModel;
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
