//
//  DynamicBgViewController.m
//  YJBannerViewDemo
//
//  Created by YJHou on 2017/11/7.
//  Copyright © 2017年 地址:https://github.com/stackhou/YJBannerViewOC . All rights reserved.
//

#import "DynamicBgViewController.h"
#import "YJBannerView.h"

@interface DynamicBgViewController () <YJBannerViewDataSource, YJBannerViewDelegate>

@property (nonatomic, strong) UIView *bannerBgView;
@property (nonatomic, strong) YJBannerView *bannerView; /**< banner */

@end

@implementation DynamicBgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self _setUpDynamicBgMainView];
}

- (void)_setUpDynamicBgMainView{
    
    [self.view addSubview:self.bannerBgView];
    [self.bannerView reloadData];
}

#pragma mark - DataSource
- (NSArray *)bannerViewImages:(YJBannerView *)bannerView{
    return @[@"http://img.zcool.cn/community/01430a572eaaf76ac7255f9ca95d2b.jpg",
             @"http://img.zcool.cn/community/0137e656cc5df16ac7252ce6828afb.jpg",
             @"http://img.zcool.cn/community/01e5445654513e32f87512f6f748f0.png@900w_1l_2o_100sh.jpg",
             @"http://www.aykj.net/front/images/subBanner/baiduV2.jpg"
             ];
}

- (void)bannerView:(YJBannerView *)bannerView didScroll2Index:(NSInteger)index{
    NSLog(@"-->%ld", index);
    
    [UIView animateWithDuration:0.5 animations:^{
        self.bannerBgView.backgroundColor = kRANDOM_COLOR;
    }];
    
}

#pragma mark - Lazy
- (UIView *)bannerBgView{
    if (!_bannerBgView) {
        _bannerBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 240)];
        [_bannerBgView addSubview:self.bannerView];
    }
    return _bannerBgView;
}

- (YJBannerView *)bannerView{
    if (!_bannerView) {
        _bannerView = [YJBannerView bannerViewWithFrame:CGRectMake(15, 40, kSCREEN_WIDTH - 30, 140) dataSource:self delegate:self emptyImage:[UIImage imageNamed:@"placeholder"] placeholderImage:[UIImage imageNamed:@"placeholder"] selectorString:@"sd_setImageWithURL:placeholderImage:"];
        _bannerView.layer.cornerRadius = 5.0f;
        _bannerView.layer.masksToBounds = YES;
    }
    return _bannerView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
