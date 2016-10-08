//
//  YJBannerViewCell.h
//  YJBannerView
//
//  Created by YJHou on 16/10/8.
//  Copyright © 2016年 YJHou. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YJBannerViewModel;
@interface YJBannerViewCell : UICollectionViewCell

- (void)bannerViewCellWithDataSource:(YJBannerViewModel *)model;

@end
