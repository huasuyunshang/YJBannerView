//
//  YJBackgroundTask.m
//  YJBannerViewDemo
//
//  Created by YJHou on 2018/1/12.
//  Copyright © 2018年 Address:https://github.com/stackhou  . All rights reserved.
//

#import "YJBackgroundTask.h"

@interface YJBackgroundTask ()

@property (nonatomic, assign) UIBackgroundTaskIdentifier taskId;

@end

@implementation YJBackgroundTask
singleton_implementation(YJBackgroundTask)

- (void)beginBackgroundTaskWithLastTime:(NSTimeInterval)lastTime completion:(void (^)())completion {
    
    UIApplication *app = [UIApplication sharedApplication];
    
    __block UIBackgroundTaskIdentifier taskId = [app beginBackgroundTaskWithExpirationHandler:^{
        [app endBackgroundTask:taskId];
        taskId = UIBackgroundTaskInvalid;
    }];
    self.taskId = taskId;
    
    while (self.taskId != UIBackgroundTaskInvalid) {
        NSTimeInterval remainingTime = app.backgroundTimeRemaining;
        if (remainingTime <= lastTime) {
            if (completion) {
                completion();
            }
            break;
        }
        
        [NSThread sleepForTimeInterval:1.0];
        NSLog(@"倒计时-->%.f", remainingTime);
    }
    
    [app endBackgroundTask:taskId];
    taskId = UIBackgroundTaskInvalid;
}

- (void)endBackgroundTask{
    if (self.taskId) {
        UIApplication *app = [UIApplication sharedApplication];
        [app endBackgroundTask:self.taskId];
        self.taskId = UIBackgroundTaskInvalid;
    }
}

@end
