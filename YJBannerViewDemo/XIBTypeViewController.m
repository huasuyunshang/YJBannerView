//
//  XIBTypeViewController.m
//  YJBannerViewDemo
//
//  Created by YJHou on 2018/3/26.
//  Copyright © 2018年 Address:https://github.com/stackhou  . All rights reserved.
//

#import "XIBTypeViewController.h"
#import "YJBannerView.h"

@interface XIBTypeViewController () <UITableViewDataSource, UITableViewDelegate, YJBannerViewDataSource, YJBannerViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet YJBannerView *bannerView;

@end

@implementation XIBTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置必须参数
    self.bannerView.placeholderImage = [UIImage imageNamed:@"placeholder"];
    self.bannerView.bannerViewSelectorString = @"sd_setImageWithURL:placeholderImage:";
    
    // 设置可选参数
    self.bannerView.pageControlStyle = PageControlCustom;
    self.bannerView.customPageControlNormalImage = [UIImage imageNamed:@"pageControlN"];
    self.bannerView.customPageControlHighlightImage = [UIImage imageNamed:@"pageControlS"];
    self.bannerView.pageControlPadding = 8.0f;
    
    // 模拟数据加载完毕
    [self.bannerView reloadData];
    
    self.tableView.tableHeaderView = self.bannerView;
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"XIBTypeViewController";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"-- %ld", (long)indexPath.row];
    
    return cell;
}

#pragma mark - YJBannerViewDataSource
- (NSArray *)bannerViewImages:(YJBannerView *)bannerView{
    
    return @[@"http://img.zcool.cn/community/01430a572eaaf76ac7255f9ca95d2b.jpg",
             @"http://img.zcool.cn/community/0137e656cc5df16ac7252ce6828afb.jpg",
             @"http://img.zcool.cn/community/01e5445654513e32f87512f6f748f0.png@900w_1l_2o_100sh.jpg",
             @"http://www.aykj.net/front/images/subBanner/baiduV2.jpg"
             ];
}

#pragma mark - YJBannerViewDelegate
- (void)bannerView:(YJBannerView *)bannerView didSelectItemAtIndex:(NSInteger)index{
    
    NSLog(@"bannerView-->%ld", (long)index);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
