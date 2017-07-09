//
//  BaseViewController.m
//  RN
//
//  Created by LL on 2017/7/9.
//  Copyright © 2017年 LL. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadNRJS:self.index];
}

- (void)loadNRJS:(NSInteger)index
{
    NSString * strUrl = [NSString stringWithFormat:@"http://localhost:8081/index.ios%zd.bundle?platform=ios&dev=true",index];
    NSURL * jsCodeLocation = [NSURL URLWithString:strUrl];
    RCTRootView * rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation moduleName:@"RN" initialProperties:nil launchOptions:nil];
    [self.view addSubview:rootView];
    rootView.frame = CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
