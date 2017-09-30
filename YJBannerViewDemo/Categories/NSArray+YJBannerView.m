//
//  NSArray+YJBannerView.m
//  YJBannerViewDemo
//
//  Created by YJHou on 2017/9/30.
//  Copyright © 2017年 地址:https://github.com/stackhou/YJBannerViewOC . All rights reserved.
//

#import "NSArray+YJBannerView.h"

@implementation NSArray (YJBannerView)

- (id)objectSafeAtIndex:(NSUInteger)index{
    if (self.count > index){
        return [self objectAtIndex:index];
    }
    return nil;
}

@end
