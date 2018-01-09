//
//  AppDelegate.m
//  YJBannerViewDemo
//
//  Created by YJHou on 2014/5/24.
//  Copyright © 2014年 Address:https://github.com/stackhou . All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    /**
     运行后，用两个手指头在状态栏上同时点击下就可以显示出这个调试的悬浮层。
     可以看到大概有这样几个选项，
     *     View Hierarchy（查看View的层级关系）
     *     VC Hierarchy（查看ViewController层级关系）
     *     Ivar Explorer（查看UIApplication 的成员属性）
     *     Measure （测量View的尺寸）
     *     Spec Compare （对比设计图）
     */
    id overlayClass = NSClassFromString(@"UIDebuggingInformationOverlay");
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [overlayClass performSelector:NSSelectorFromString(@"prepareDebuggingOverlay")];
#pragma clang diagnostic pop

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
