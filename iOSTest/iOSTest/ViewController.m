//
//  ViewController.m
//  iOSTest
//
//  Created by lilong on 2018/7/4.
//  Copyright © 2018年 lilong. All rights reserved.
//

#import "ViewController.h"
#import "RNViewController.h"
#import "RACViewController.h"
#import "AVPlayerViewController.h"
#import "TestViewController.h"
#import "GestureRecognizerViewController.h"
#import "NSArrayViewController.h"
#import "TableViewControllerTestCarsh.h"
#import "FloatViewController.h"
#import "BitOperationViewController.h"
#import "CoredataViewController.h"
#import "RunLoopViewController.h"
#import "CopyViewController.h"
#import "ParallelDevelopmentController.h"//并行开发
#import "NSThreadViewController.h" //NSThread开发
#import "NSOperationViewController.h"  //NSOperation开发
#import "NSBlockOperationMViewController.h" //NSBlockOperation开发
#import "GCDViewController.h" //GCD开发
#import "LockViewController.h" //线程锁
#import "RunTimeViewController.h"//runTime
#import "BlocklController.h" //block
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStyleGrouped];
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
    [self.view addSubview:self.tableView];
    
    self.dataList = @[@"RNViewController",
                      @"RACViewController",
                      @"RunTimeViewController",
                      @"AVPlayerViewController",
                      @"TestViewController",
                      @"GestureRecognizerViewController",
                      @"NSArrayViewController",
                      @"TableViewControllerTestCarsh",
                      @"FloatViewController",
                      @"BitOperationViewController",
                      @"CoredataViewController",
                      @"RunLoopViewController",
                      @"CopyViewController",
                      @"ParallelDevelopmentController",
                      @"NSThreadViewController",
                      @"NSOperationViewController",
                      @"NSBlockOperationMViewController",
                      @"GCDViewController",
                      @"LockViewController",
                      @"RunTimeViewController",
                      @"BlocklController"
                      ];
    /*
     {
     "name": "RN",
     "version": "0.0.1",
     "private": true,
     "scripts": {
     "start": "node node_modules/react-native/local-cli/cli.js start"
     },
     "dependencies": {
     "react": "15.4.2",
     "react-native": "0.41.2"
     }
     }
     */
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *idertifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idertifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idertifier];
    }
    [cell.textLabel setText:self.dataList[indexPath.row]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Class class = NSClassFromString(self.dataList[indexPath.row]);
    UIViewController *viewContrllor = [[class alloc] init];
    [self.navigationController pushViewController:viewContrllor animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of ny resources that can be recreated.
}


@end
