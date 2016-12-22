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
    for (NSInteger i = 0; i < 4; i++) {
        YJBannerViewModel * model = [[YJBannerViewModel alloc] init];
        model.localImageName = [NSString stringWithFormat:@"h%ld.jpg", i + 1];
        [array addObject:model];
    }
    return array;
}

@end
