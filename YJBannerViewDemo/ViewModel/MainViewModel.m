//
//  MainViewModel.m
//  YJBannerViewDemo
//
//  Created by YJHou on 2015/5/24.
//  Copyright © 2015年 Address:https://github.com/stackhou . All rights reserved.
//

#import "MainViewModel.h"

@implementation MainViewModel

- (NSArray *)normalBannerViewImages{
    
    NSArray *imageUrls = @[@"http://img.zcool.cn/community/01430a572eaaf76ac7255f9ca95d2b.jpg",
                           @"http://img.zcool.cn/community/0137e656cc5df16ac7252ce6828afb.jpg",
                           @"http://img.zcool.cn/community/01e5445654513e32f87512f6f748f0.png@900w_1l_2o_100sh.jpg",
                           @"http://www.aykj.net/front/images/subBanner/baiduV2.jpg"
                           ];
//    NSMutableArray *arrays = [NSMutableArray array];
//    for (NSInteger i = 0; i < arc4random() % imageUrls.count; i++) {
//        [arrays addObject:imageUrls[i]];
//    }
//    NSLog(@"正常的个数-->%ld", arrays.count);

    return imageUrls;
}

- (NSArray *)hotTitles{
    return @[@"打折活动开始了, 速来抢购",
             @"iOS 10.3.3 赶紧升级! 一个好消息",
             @"王者荣耀最强COS, 最后一个简直原版"];
}

- (NSArray *)goodDetailBannerViewImages{
    return @[@"http://pic.qiantucdn.com/58pic/18/52/34/91n58PICFBC_1024.jpg",
             @"http://fund.sufe.edu.cn/UpLoadFile/20141024/2f978ed4-1413-4e20-82e3-3f64f497796e.jpg",
             @"http://www.chn-tdzj.com/templates/images/banner2.jpg"
             ];
}

- (NSArray *)customBannerViewImages{
    return @[@"http://img.zcool.cn/community/01f5ce56e112ef6ac72531cb37bec4.png@900w_1l_2o_100sh.jpg",
             @"http://img.zcool.cn/community/01c41656cbf3eb32f875520f71f47a.png",
             @"http://pic.58pic.com/58pic/17/27/94/54d350c57f5f8_1024.jpg"
             ];
}

@end
