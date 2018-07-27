//
//  YJBackgroundTask.h
//  YJBannerViewDemo
//
//  Created by YJHou on 2018/1/12.
//  Copyright © 2018年 Address:https://github.com/stackhou  . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YJBackgroundTask : NSObject
singleton_interface(YJBackgroundTask)

/**
 开启后台运行

 @param lastTime 结束前的最后时间长度
 @param completion 结束时间前的回调
 */
- (void)beginBackgroundTaskWithLastTime:(NSTimeInterval)lastTime completion:(void (^)())completion ;

/**
 结束后台运行
 */
- (void)endBackgroundTask;

@end
