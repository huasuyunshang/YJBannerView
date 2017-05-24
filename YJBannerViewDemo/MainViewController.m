//
//  MainViewController.m
//  YJBannerViewDemo
//
//  Created by YJHou on 2014/5/24.
//  Copyright © 2014年 地址:https://github.com/YJManager/YJBannerViewOC . All rights reserved.
//

#import "MainViewController.h"
#import "YJBannerView.h"

@interface MainViewController () <YJBannerViewDataSource, YJBannerViewDelegate>

@property (nonatomic, strong) NSMutableArray *imageDataSources; /**< 图片数据源 */
@property (nonatomic, strong) NSMutableArray *titlesDataSources; /**< 标题数据 */
@property (nonatomic, strong) YJBannerView *bannerView; /**< banner */

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self _setUpMainView];
    [self _loadDataSources];
    
}

- (void)_setUpMainView{
    
    [self.view addSubview:self.bannerView];

}

- (void)_loadDataSources{
    
    NSArray *imagesURLStrings = @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1495632076185&di=2e7f3813f688d7b9f936b21cc767392e&imgtype=0&src=http%3A%2F%2Fpic31.nipic.com%2F20130727%2F6949918_163332595163_2.jpg",
                                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1495632229617&di=f990b7e2d3da3b53e682f0582fbd1ed3&imgtype=0&src=http%3A%2F%2Fpic.58pic.com%2F58pic%2F15%2F03%2F52%2F38F58PICJKV_1024.jpg",
                                  
                                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1495632258681&di=ab24dd72e9d1a926a85c043777bcc773&imgtype=0&src=http%3A%2F%2Fpic15.nipic.com%2F20110812%2F5456365_114059382181_2.jpg",
                                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1495632303259&di=22f439df66883699a32125bc49d25bf5&imgtype=0&src=http%3A%2F%2Fpic.qiantucdn.com%2F58pic%2F17%2F89%2F25%2F55a5fd7fa6c16_1024.jpg",
                                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1495632321411&di=64bf3fc35875ec65793777c9aaeb2738&imgtype=0&src=http%3A%2F%2Fpic2.ooopic.com%2F11%2F71%2F39%2F42b1OOOPICe8.jpg"
                                  ];
    
    NSArray *titles = @[@"我是一只小青蛙",
                        @"我的地址是",
                        @"如果代码在使用过程中出现问题",
                        @"您可以发邮件到houmanager@hotamail.com"
                        ];
    
    for (NSInteger i = 0; i < imagesURLStrings.count; i++) {
        [self.imageDataSources addObject:imagesURLStrings[i]];
    }
    
    for (NSInteger i = 0; i < titles.count; i++) {
        [self.titlesDataSources addObject:titles[i]];
    }
    
    [self.bannerView reloadView];

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

- (YJBannerView *)bannerView{
    if (!_bannerView) {
        _bannerView = [YJBannerView bannerViewWithFrame:CGRectMake(0, 64, kSCREEN_WIDTH, 200) dataSource:self delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
        _bannerView.pageControlStyle = YJBannerViewPageControlAnimated;
        _bannerView.pageControlAliment = YJBannerViewPageControlAlimentRight;
    }
    return _bannerView;
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
