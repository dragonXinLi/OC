//
//  ViewController.m
//  RN
//
//  Created by LL on 2017/7/9.
//  Copyright © 2017年 LL. All rights reserved.
//

#import "ViewController.h"
#import "CSSViewController.h"
#import "FirstViewController.h"
#import "ImageViewController.h"
#import "FlexViewController.h"
#import "ProjectOneViewController.h"
#import "StateViewController.h"
#import "InputTextViewController.h"
#import "ScrollViewController.h"
#import "FlatListViewController.h"
#import "FetchViewController.h"
#import "MeiViewController.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) UITableView *tableView;
@property (nonatomic , strong) NSArray *dataList;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStyleGrouped];
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
    [self.view addSubview:self.tableView];
    
    self.dataList = @[@"FirstViewController",
                      @"ImageViewController",
                      @"CSSViewController",
                      @"FlexViewController",
                      @"ProjectOneViewController",
                      @"StateViewController",
                      @"InputTextViewController",
                      @"ScrollViewController",
                      @"FlatListViewController",
                      @"FetchViewController",
                      @"MeiViewController",
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
    BaseViewController *viewContrllor = [[class alloc] init];
    [viewContrllor setTitle:self.dataList[indexPath.row]];
    [viewContrllor setIndex:indexPath.row];
    [self.navigationController pushViewController:viewContrllor animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of ny resources that can be recreated.
}


@end
