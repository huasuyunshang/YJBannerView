//
//  DetailViewController.m
//  YJBannerViewDemo
//
//  Created by YJHou on 2015/5/24.
//  Copyright © 2015年 地址:https://github.com/YJManager/YJBannerViewOC . All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kRANDOM_COLOR;
    self.navigationItem.title = @"详情页";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(closeCurrentController)];
}

- (void)closeCurrentController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
