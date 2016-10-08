//
//  YJBannerViewModel.h
//  YJBannerView
//
//  Created by YJHou on 16/10/8.
//  Copyright © 2016年 YJHou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YJBannerViewModel : NSObject

@property (nonatomic, copy) NSString * imageUrl;      /**< 网络图片url */
@property (nonatomic, copy) NSString * localImageName; /**< 本地图片名字 */
@property (nonatomic, copy) NSString * title;         /**< 标题 */

@end
