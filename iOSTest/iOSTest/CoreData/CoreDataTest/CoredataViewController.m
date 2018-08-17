//
//  CoredataViewController.m
//  iOSTest
//
//  Created by lilong on 2018/7/4.
//  Copyright © 2018年 lilong. All rights reserved.
//

#import "CoredataViewController.h"
#import "CoreDataManager.h"
#import "DynamicSynthesize.h"
@interface CoredataViewController ()

@end

@implementation CoredataViewController

#pragma mark - LifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    CoreDataManager *a = [[CoreDataManager alloc] initWithTest:nil];
//    CoreDataManager *b = [[CoreDataManager alloc] initWithTest2:nil];
    if(1)
    {
    [[CoreDataManager shareManager] deleteData];

    for (int i = 0; i < 10; i++) {
//        NSString *name = [[NSString alloc] initWithFormat:@"%d",i];
        [[CoreDataManager shareManager] insertData:@(i)];
    }
    
    [[CoreDataManager shareManager] queryData];
//
    [[CoreDataManager shareManager] deleteData:@(5)];
//
//    [[CoreDataManager shareManager] queryData];
////
//    [[CoreDataManager shareManager] updateData:@(3)];
////
//    [[CoreDataManager shareManager] queryData];
//    
//    [[CoreDataManager shareManager] deleteData];
//    
//    [[CoreDataManager shareManager] queryData];
    }
    
    
    if(0)
    {
//        DynamicSynthesize *dys = [[DynamicSynthesize alloc] init];
        DynamicSynthesize *dys = [DynamicSynthesize new];
//        [dys setName:@"1"];
        dys.name = @"1";
        dys.yourName = @"2";
        NSLog(@"%@",dys.name);
        NSLog(@"%@",dys.yourName);
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

#pragma mark - Initial Methods

#pragma mark - Override Methods

#pragma mark - Target Methods

#pragma mark - Privater Methods

#pragma mark - Notification Methods

#pragma mark - KVO Methods

#pragma mark - UITableViewDelegate, UITableViewDataSource

#pragma mark - Setter Getter Methods

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
