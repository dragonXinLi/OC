//
//  TestViewController.m
//  RN
//
//  Created by sangfor on 2018/1/30.
//  Copyright © 2018年 LL. All rights reserved.
//

#import "TestViewController.h"
#import <WebKit/WebKit.h>
#define IOS8_OR_LATER __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    id wkwebView = NSClassFromString(@"WKWebView");
    id wkwebView2 = NSClassFromString(@"ViewController");
    id cls = [[NSClassFromString(@"ViewController") alloc]init];
    

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
