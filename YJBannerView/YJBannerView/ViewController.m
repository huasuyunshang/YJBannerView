//
//  ViewController.m
//  YJBannerView
//
//  Created by YJHou on 16/9/30.
//  Copyright © 2016年 YJHou. All rights reserved.
//

#import "ViewController.h"
#import "YJBannerView.h"

@interface ViewController () <YJBannerViewDataSource, YJBannerViewDelegate>

@property (nonatomic, strong) YJBannerView * bannerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.bannerView];
}

#pragma mark - Lazy
- (YJBannerView *)bannerView{
    if (_bannerView == nil) {
        _bannerView = [YJBannerView bannerViewWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 200) placeholderImage:nil];
        _bannerView.dataSource = self;
        _bannerView.delegate = self;
    }
    return _bannerView;
}

- (NSArray<YJBannerViewModel *> *)bannerShowDataSourceWithBannerView:(YJBannerView *)bannerView{
    
    NSMutableArray * array = [NSMutableArray array];
    for (NSInteger i = 0; i < 5; i++) {
        YJBannerViewModel * model = [[YJBannerViewModel alloc] init];
        model.imageUrl = @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg";
        [array addObject:model];
    }
    return array;
}




@end
