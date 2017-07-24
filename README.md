# [YJBannerViewOC](https://github.com/YJManager/YJBannerViewOC) 

<!--&middot;--> 
[![Travis](https://img.shields.io/travis/YJManager/YJBannerViewOC.svg?style=flat)](https://github.com/YJManager/YJBannerViewOC.git)[![Language](https://img.shields.io/badge/Language-Objective--C-FF7F24.svg?style=flat)](https://github.com/YJManager/YJBannerViewOC.git)[![CocoaPods](https://img.shields.io/cocoapods/p/YJBannerView.svg?style=flat)](https://github.com/YJManager/YJBannerViewOC.git)[![CocoaPods](https://img.shields.io/cocoapods/v/YJBannerView.svg?style=flat)](https://github.com/YJManager/YJBannerViewOC.git)[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/YJManager/YJBannerViewOC.git)[![GitHub tag](https://img.shields.io/github/tag/YJManager/YJBannerViewOC.svg?style=flat)](https://github.com/YJManager/YJBannerViewOC.git)[![license](https://img.shields.io/github/license/YJManager/YJBannerViewOC.svg?style=flat)](https://github.com/YJManager/YJBannerViewOC.git)

`YJBannerView` YJAutoScrollBanner. Objective-C版 无限循环Banner、文字轮播器。

## 效果
<img src="https://github.com/YJManager/YJBannerViewOC/blob/master/YJBannerViewDemo/Resources/bannerView.gif" width="300" height="533" />

## Adding YJBannerView to your project (添加 YJBannerView 到你的项目)

### CocoaPods

[CocoaPods](http://cocoapods.org) is the recommended way to add `YJBannerView` to your project.

1. Add a pod entry for `YJBannerView` to your Podfile </br>
```ruby
    pod 'YJBannerView'
```
2. Install the pod(s) by running </br>
```ruby
    pod install
```
3. Include `YJBannerView` wherever you need it with </br>
```ruby
    #import "YJBannerView.h"
```

### Carthage

1. Add YJBannerView to your Cartfile. </br>
```ruby
    github "YJManager/YJBannerViewOC"
```
2. Run 
```ruby
    carthage update
```
3. Follow the rest of the [standard Carthage installation instructions](https://github.com/Carthage/Carthage#adding-frameworks-to-an-application) to add YJBannerView to your project.

### 使用方法

#### 1.创建BannerView:
```objc
-(YJBannerView *)normalBannerView{
    if (!_normalBannerView) {
        _normalBannerView = [YJBannerView bannerViewWithFrame:CGRectMake(0, 20, kSCREEN_WIDTH, 180) dataSource:self delegate:self placeholderImageName:@"placeholder" selectorString:@"sd_setImageWithURL:placeholderImage:"];
        _normalBannerView.pageControlAliment = PageControlAlimentRight;
        _normalBannerView.autoDuration = 2.5f;
    }
    return _normalBannerView;
}
```
#### 2.实现数据源方法和代理:
```objc
// 将网络图片或者本地图片 或者混合数组
- (NSArray *)bannerViewImages:(YJBannerView *)bannerView{
    return self.imageDataSources;
}

// 将标题对应数组传递给bannerView 如果不需要, 可以不实现该方法
- (NSArray *)bannerViewTitles:(YJBannerView *)bannerView{
    return self.titlesDataSources;
}

// 代理方法 点击了哪个bannerView 的 第几个元素
-(void)bannerView:(YJBannerView *)bannerView didSelectItemAtIndex:(NSInteger)index{
    NSString *title = [self.titlesDataSources objectAtIndex:index];
    NSLog(@"当前%@-->%@", bannerView, title);
}
```

### 扩展自定义方法
```objc
// 自定义Cell方法
- (Class)bannerViewCustomCellClass:(YJBannerView *)bannerView{
    return [HeadLinesCell class];
}

// 自定义Cell的数据刷新方法
- (void)bannerView:(YJBannerView *)bannerView customCell:(UICollectionViewCell *)customCell index:(NSInteger)index{

    HeadLinesCell *cell = (HeadLinesCell *)customCell;
    [cell cellWithHeadHotLineCellData:@"打折活动开始了~~快来抢购啊"];
}
```

## License

This code is distributed under the terms and conditions of the [MIT license](LICENSE).

## Change-log

A brief summary of each YJBannerView release can be found in the [CHANGELOG](CHANGELOG.mdown). 
