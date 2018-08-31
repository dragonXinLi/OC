//
//  BlocklController.m
//  iOSTest
//
//  Created by lilong on 2018/8/31.
//  Copyright © 2018年 lilong. All rights reserved.
//

#import "BlocklController.h"
#import "BlockModelTest.h"

@interface BlocklController ()

@end

@implementation BlocklController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    BlockModelTest * test = [[BlockModelTest alloc] init];
    [test testWithBlock:^{
        NSLog(@"%@",self);
        NSLog(@"fsafdsfsd");
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dealloc
{
    NSLog(@"BlocklController: dealloc");
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
