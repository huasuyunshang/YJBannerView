//
//  YJCustomView.h
//  YJBannerViewDemo
//
//  Created by YJHou on 2018/1/9.
//  Copyright © 2018年 Address:https://github.com/stackhou . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YJCustomView : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imgView; /**< 图片 */
@property (nonatomic, strong) UIButton *button; /**< 按钮 */
@property (nonatomic, copy  ) void(^playBlock)(UIButton *);

- (void)cellWithcoverForFeed:(NSString *)coverForFeed;

@end
