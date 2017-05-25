//
//  MainViewController.m
//  YJBannerViewDemo
//
//  Created by YJHou on 2014/5/24.
//  Copyright © 2014年 地址:https://github.com/YJManager/YJBannerViewOC . All rights reserved.
//

#import "MainViewController.h"
#import "YJBannerView.h"

static CGFloat const midMargin = 15.0f;

@interface MainViewController () <YJBannerViewDataSource, YJBannerViewDelegate>

@property (nonatomic, strong) NSMutableArray *imageDataSources; /**< 图片数据源 */
@property (nonatomic, strong) NSMutableArray *titlesDataSources; /**< 标题数据 */
@property (nonatomic, strong) YJBannerView *defaultBannerView; /**< 默认设置banner */
@property (nonatomic, strong) YJBannerView *secondBannerView; /**< 演示banner */
@property (nonatomic, strong) YJBannerView *custompageControlBannerView; /**< 自定义pageControl样式演示banner */
@property (nonatomic, strong) YJBannerView *onlyShowTextBannerView; /**< 只显示文字演示banner */

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"YJBannerViewDemo";
    
    [self _setUpMainView];
    [self _loadDataSources];
    
}

- (void)_setUpMainView{
    
    UIScrollView *containerScrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:containerScrollView];

    [containerScrollView addSubview:self.defaultBannerView];
    [containerScrollView addSubview:self.secondBannerView];
    [containerScrollView addSubview:self.custompageControlBannerView];
    [containerScrollView addSubview:self.onlyShowTextBannerView];
    
    containerScrollView.contentSize = CGSizeMake(self.view.frame.size.width, CGRectGetMaxY(self.onlyShowTextBannerView.frame) + midMargin);
}

- (void)_loadDataSources{
    
    NSArray *imagesURLStrings = @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1495632076185&di=2e7f3813f688d7b9f936b21cc767392e&imgtype=0&src=http%3A%2F%2Fpic31.nipic.com%2F20130727%2F6949918_163332595163_2.jpg",
                                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1495632229617&di=f990b7e2d3da3b53e682f0582fbd1ed3&imgtype=0&src=http%3A%2F%2Fpic.58pic.com%2F58pic%2F15%2F03%2F52%2F38F58PICJKV_1024.jpg",
                                  
                                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1495632258681&di=ab24dd72e9d1a926a85c043777bcc773&imgtype=0&src=http%3A%2F%2Fpic15.nipic.com%2F20110812%2F5456365_114059382181_2.jpg",
                                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1495632303259&di=22f439df66883699a32125bc49d25bf5&imgtype=0&src=http%3A%2F%2Fpic.qiantucdn.com%2F58pic%2F17%2F89%2F25%2F55a5fd7fa6c16_1024.jpg",
                                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1495632321411&di=64bf3fc35875ec65793777c9aaeb2738&imgtype=0&src=http%3A%2F%2Fpic2.ooopic.com%2F11%2F71%2F39%2F42b1OOOPICe8.jpg",
                                  @"placeholder"
                                  ];
    
    NSArray *titles = @[@"我是一只小青蛙",
                        @"我的地址是"
                        ];
    
    for (NSInteger i = 0; i < imagesURLStrings.count; i++) {
        [self.imageDataSources addObject:imagesURLStrings[i]];
    }
    
    for (NSInteger i = 0; i < titles.count; i++) {
        [self.titlesDataSources addObject:titles[i]];
    }
    
    [self.defaultBannerView reloadData];
    [self.secondBannerView reloadData];
    [self.custompageControlBannerView reloadData];
    [self.onlyShowTextBannerView reloadData];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    MainViewController *main = [[MainViewController alloc] init];
    [self.navigationController pushViewController:main animated:YES];
}

#pragma mark - DataSources
- (NSArray *)bannerViewImages:(YJBannerView *)bannerView{
    return self.imageDataSources;
}

- (NSArray *)bannerViewTitles:(YJBannerView *)bannerView{
    return self.titlesDataSources;
}

#pragma mark - Delegate
-(void)bannerView:(YJBannerView *)bannerView didScroll2Index:(NSInteger)index{
//    NSLog(@"index-->%ld", index);
}

-(void)bannerView:(YJBannerView *)bannerView didSelectItemAtIndex:(NSInteger)index{
    NSLog(@"didSelectItemAtIndex-->%ld", index);
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

/** 第一个 默认 */
- (YJBannerView *)defaultBannerView{
    if (!_defaultBannerView) {
        _defaultBannerView = [YJBannerView bannerViewWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 200) dataSource:self delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
    }
    return _defaultBannerView;
}

- (YJBannerView *)secondBannerView{
    if (!_secondBannerView) {
        _secondBannerView = [YJBannerView bannerViewWithFrame:CGRectMake(0, CGRectGetMaxY(self.defaultBannerView.frame) + midMargin, kSCREEN_WIDTH, 200) dataSource:self delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
        _secondBannerView.pageControlStyle = YJBannerViewPageControlSystem;
        _secondBannerView.pageControlAliment = YJBannerViewPageControlAlimentCenter;
        _secondBannerView.autoDuration = 3.0f;
        _secondBannerView.bannerViewScrollDirection = YJBannerViewDirectionTop;
    }
    return _secondBannerView;
}

- (YJBannerView *)custompageControlBannerView{
    if (!_custompageControlBannerView) {
        _custompageControlBannerView = [YJBannerView bannerViewWithFrame:CGRectMake(0, CGRectGetMaxY(self.secondBannerView.frame) + midMargin, kSCREEN_WIDTH, 200) dataSource:self delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
        _custompageControlBannerView.pageControlHighlightImage = [UIImage imageNamed:@"pageControlCurrentDot"];
        _custompageControlBannerView.pageControlNormalImage = [UIImage imageNamed:@"pageControlDot"];
    }
    return _custompageControlBannerView;
}

- (YJBannerView *)onlyShowTextBannerView{
    if (!_onlyShowTextBannerView) {
        _onlyShowTextBannerView = [YJBannerView bannerViewWithFrame:CGRectMake(0, CGRectGetMaxY(self.custompageControlBannerView.frame) + midMargin, kSCREEN_WIDTH, 40) dataSource:self delegate:self placeholderImage:nil];
        _onlyShowTextBannerView.onlyDisplayText = YES;
        _onlyShowTextBannerView.bannerViewScrollDirection = YJBannerViewDirectionTop;
        _onlyShowTextBannerView.titleBackgroundColor = [UIColor orangeColor];
    }
    return _onlyShowTextBannerView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
