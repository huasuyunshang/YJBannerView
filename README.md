<!--&middot;--> 
[![Travis](https://img.shields.io/travis/stackhou/YJBannerViewOC.svg?style=flat)](https://github.com/stackhou/YJBannerViewOC.git)
[![Language](https://img.shields.io/badge/Language-Objective--C-FF7F24.svg?style=flat)](https://github.com/YJManager/YJBannerViewOC.git)
[![CocoaPods](https://img.shields.io/cocoapods/p/YJBannerView.svg)](https://github.com/stackhou/YJBannerViewOC.git)
[![CocoaPods](https://img.shields.io/cocoapods/v/YJBannerView.svg)](https://github.com/stackhou/YJBannerViewOC.git)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/stackhou/YJBannerViewOC.git)
<!-- [![CocoaPods](https://img.shields.io/cocoapods/at/YJBannerView.svg)](https://github.com/stackhou/YJBannerViewOC.git) -->

# YJBannerView 
- 使用简单、功能丰富的 `Objective-C版` 轮播控件,  基于 `UICollectionView` 实现, 多种场景均支持使用.

## 效果样例
<img src="https://github.com/YJManager/YJBannerViewOC/blob/master/YJBannerViewDemo/Resources/bannerView3.gif" width="300" height="563" />

## Features

- [x] 支持自带PageControl样式配置, 也支持自定义        
- [x] 支持上、下、左、右四个方向自动、手动动滚动
- [x] 支持自动滚动时间设置                               
- [x] 支持首尾循环滚动的开关
- [x] 支持滚动相关手势的开关                             
- [x] 支持ContentMode的设置                            
- [x] 支持Banner标题的设置自定义
- [x] 支持自定义UICollectionViewCell                    
- [x] 支持自定义 UIView 填充BannerView
- [x] 支持在Storyboard\xib中创建并配置其属性   
- [x] 支持非首尾循环的Footer样式和进入详情回调
- [x] 不依赖其他三方SDWebImage或者AFNetworking设置图片
- [x] 支持CocoaPods
- [x] 支持Carthage


## Installation

### Cocoapods

YJBannerView is available through [CocoaPods](http://cocoapods.org). To install it, simply add the following line to your Podfile:

```ruby
    pod 'YJBannerView'
```

### Carthage
```ruby
    github "stackhou/YJBannerViewOC"
```

## Usage

### 1.创建BannerView:
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
### 2.实现数据源方法和代理:
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

## 版本记录

   * 2015/5/10		版本1.0   生成静态库.a的方式，使用 Cocoapods 导入
   * 2016/10/17 	版本2.0   源码的方式使用 Cocoapods 导入
   * 2017/5/29   	版本2.1   默认自动滚动时间间隔调整为3s、动画变化比例调整为1.0、设置标题默认								边间距为10, 可任意设置, 支持Carthage
   *  2017/7/3    	版本2.1.1  通过传递UIImageView设置网络图片的方法给BannerView设置图片, 不再								依赖其他三方库，如: SDWebImage
   * 2017/7/14   	版本2.1.4  代码功能及结构优化
   * 2017/7/21   	版本2.1.5  代码功能优化
   * 2017/7/25   	版本2.1.6  1.新增cycleScrollEnable控制是否需要首尾相连; 2.新增								bannerGestureEnable 手势是否可用 3.新增bannerView:didScrollCurrentIndex:代理方法, 可以自定义PageControl
   * 2017/7/28   	版本2.1.7  1.新增FooterView 2.新增自定义View bannerView:viewForItemAtIndex: 方法
   * 2017/7/30   	版本2.2.0   调优、降低内存消耗
   *  2017/8/21  	版本2.2.1   当数据源不为零时, 隐藏背景图片
   *  2017/9/25       	版本2.2.2  当网络加载时间很长时 PlaceHolder 显示优化

## License

This code is distributed under the terms and conditions of the [MIT license](LICENSE).

## Change-log

A brief summary of each YJBannerView release can be found in the [CHANGELOG](CHANGELOG.mdown). 
