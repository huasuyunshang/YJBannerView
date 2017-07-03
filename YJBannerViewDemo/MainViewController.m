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
    
    containerScrollView.contentSize = CGSizeMake(self.view.frame.size.width, CGRectGetMaxY(self.custompageControlBannerView.frame) + midMargin);
}

- (void)_loadDataSources{
    
    NSArray *imagesURLStrings = @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1495788490274&di=0b9453aab06d2ea5a77a47d0d78cfa83&imgtype=0&src=http%3A%2F%2Fwww.16sucai.com%2Fuploadfile%2F2013%2F0407%2F20130407085208429.jpg",
                                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1495788516621&di=4efa056fe4234193736eb7d4dd48a262&imgtype=0&src=http%3A%2F%2Fpic.58pic.com%2F58pic%2F15%2F87%2F10%2F42N58PICFdP_1024.jpg",
                                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1495788546756&di=2a5e74dcbf61882752005d729c07d39b&imgtype=0&src=http%3A%2F%2Fwww.djhnjllm.com%2Fstatic%2Fupload%2Fimage%2F2013%2F2%2F25%2F0039716899204936.jpg",
                                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1495788599948&di=d6cef2c314498aa0d78202753a6b2493&imgtype=0&src=http%3A%2F%2Fimg3.redocn.com%2Ftupian%2F20151216%2Fshishangnvzhuangwangzhanbanner_5607161.jpg",
                                  @"localImage01.jpeg"
                                  ];
    for (NSInteger i = 0; i < imagesURLStrings.count; i++) {
        [self.imageDataSources addObject:imagesURLStrings[i]];
    }
    
    for (NSInteger i = 0; i < imagesURLStrings.count; i++) {
        [self.titlesDataSources addObject:[NSString stringWithFormat:@"标题%ld", i]];
    }
    
    [self.defaultBannerView reloadData];
    [self.secondBannerView reloadData];
    [self.custompageControlBannerView reloadData];

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
-(void)bannerView:(YJBannerView *)bannerView didSelectItemAtIndex:(NSInteger)index{
    NSString *title = [self.titlesDataSources objectAtIndex:index];
    NSLog(@"当前%@-->%@", bannerView, title);
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

/** 第一个 默认 */ // @selector(sd_setImageWithURL:placeholderImage:)
- (YJBannerView *)defaultBannerView{
    if (!_defaultBannerView) {
        _defaultBannerView = [YJBannerView bannerViewWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 160) dataSource:self delegate:self selectorString:@"sd_setImageWithURL:placeholderImage:" placeholderImage:[UIImage imageNamed:@"placeholder"]];
    }
    return _defaultBannerView;
}

- (YJBannerView *)secondBannerView{
    if (!_secondBannerView) {
        _secondBannerView = [YJBannerView bannerViewWithFrame:CGRectMake(0, CGRectGetMaxY(self.defaultBannerView.frame) + midMargin, kSCREEN_WIDTH, 160) dataSource:self delegate:self selectorString:@"sd_setImageWithURL:placeholderImage:" placeholderImage:[UIImage imageNamed:@"placeholder"]];
        _secondBannerView.pageControlStyle = YJBannerViewPageControlSystem;   // PageControl 系统样式
        _secondBannerView.pageControlAliment = YJBannerViewPageControlAlimentRight;  // 位置居中
        _secondBannerView.autoDuration = 2.0f;    // 时间间隔
        _secondBannerView.bannerViewScrollDirection = YJBannerViewDirectionTop; // 向上滚动
        _secondBannerView.pageControlHighlightImage = [UIImage imageNamed:@"pageControlCurrentDot"];
        _secondBannerView.pageControlNormalImage = [UIImage imageNamed:@"pageControlDot"];
        _secondBannerView.titleAlignment = NSTextAlignmentLeft;
    }
    return _secondBannerView;
}

- (YJBannerView *)custompageControlBannerView{
    if (!_custompageControlBannerView) {
        _custompageControlBannerView = [YJBannerView bannerViewWithFrame:CGRectMake(0, CGRectGetMaxY(self.secondBannerView.frame) + midMargin, kSCREEN_WIDTH, 160) dataSource:self delegate:self selectorString:@"sd_setImageWithURL:placeholderImage:" placeholderImage:[UIImage imageNamed:@"placeholder"]];
        _custompageControlBannerView.bannerViewScrollDirection = YJBannerViewDirectionRight;
        _custompageControlBannerView.pageControlStyle = YJBannerViewPageControlAnimated;
        _custompageControlBannerView.pageControlNormalColor = [UIColor cyanColor];
        _custompageControlBannerView.pageControlHighlightColor = [UIColor redColor];
    }
    return _custompageControlBannerView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
