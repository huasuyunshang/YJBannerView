//
//  YJBannerViewFooter.h
//  YJBannerViewDemo
//
//  Created by YJHou on 2015/5/24.
//  Copyright © 2015年 地址:https://github.com/stackhou/YJBannerViewOC . All rights reserved.
//

/**
 __   __  _ ____                            __     ___
 \ \ / / | | __ )  __ _ _ __  _ __   ___ _ __ \   / (_) _____      __
  \ V /  | |  _ \ / _` | '_ \| '_ \ / _ \ '__\ \ / /| |/ _ \ \ /\ / /
   | | |_| | |_) | (_| | | | | | | |  __/ |   \ V / | |  __/\ V  V /
   |_|\___/|____/ \__,_|_| |_|_| |_|\___|_|    \_/  |_|\___| \_/\_/
 
 */

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, YJBannerViewStatus) {
    YJBannerViewStatusIdle = 0,  // 闲置
    YJBannerViewStatusTrigger    // 触发
};

@interface YJBannerViewFooter : UICollectionReusableView

@property (nonatomic, assign) YJBannerViewStatus state;

@property (nonatomic, strong) UIFont *footerTitleFont;
@property (nonatomic, strong) UIColor *footerTitleColor;
@property (nonatomic, copy) NSString *IndicateImageName;    /**< 指示图片的名字 */
@property (nonatomic, copy) NSString *idleTitle;            /**< 闲置 */
@property (nonatomic, copy) NSString *triggerTitle;         /**< 触发 */

@end
