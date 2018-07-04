//
//  NSArrayViewController.m
//  iOSTest
//
//  Created by lilong on 2018/6/22.
//  Copyright © 2018年 LL. All rights reserved.
//

#import "NSArrayViewController.h"

@interface NSArrayViewController ()

@end

@implementation NSArrayViewController

#pragma mark - LifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSArray *arr = @[];
    id obj1 = [arr lastObject];
    id obj2 = [arr firstObject];
//    id obj3 = [arr objectAtIndex:0];
    NSAssert(1, nil);
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
