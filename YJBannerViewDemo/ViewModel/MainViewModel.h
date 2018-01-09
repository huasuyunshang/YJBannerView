//
//  MainViewModel.h
//  YJBannerViewDemo
//
//  Created by YJHou on 2015/5/24.
//  Copyright © 2015年 Address:https://github.com/stackhou . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MainViewModel : NSObject

@property (nonatomic, strong) NSArray *normalBannerViewImages; /**< 一般 Banner 图片数据源 */

@property (nonatomic, strong) NSArray *hotTitles; /**< 头条 */

@property (nonatomic, strong) NSArray *goodDetailBannerViewImages; /**< 商品详情 */

@property (nonatomic, strong) NSArray *customBannerViewImages; /**< 自定义玩法 */

@end
