//
//  RACViewController.m
//  RN
//
//  Created by sangfor on 2017/7/20.
//  Copyright © 2017年 LL. All rights reserved.
//

#import "RACViewController.h"
#import "RACOneController.h"
#import "AlertViewController.h"
@interface RACViewController ()

@end

@implementation RACViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.dataList = @[
                      @"RACOneController",
                      @"AlertViewController",
                      ];
    
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
