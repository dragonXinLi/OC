//
//  ViewController.m
//  RN
//
//  Created by LL on 2017/7/9.
//  Copyright © 2017年 LL. All rights reserved.
//

#import "ViewController.h"
#import "RCTRootView.h"  
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString * strUrl = @"http://localhost:8081/index.ios.bundle?platform=ios&dev=true";
    NSURL * jsCodeLocation = [NSURL URLWithString:strUrl];
    RCTRootView * rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation moduleName:@"RN" initialProperties:nil launchOptions:nil];
    [self.view addSubview:rootView];rootView.frame = CGRectMake(0, 20, 300, 300);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
