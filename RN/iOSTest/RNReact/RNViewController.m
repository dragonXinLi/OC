//
//  RNViewController.m
//  RN
//
//  Created by sangfor on 2017/7/20.
//  Copyright © 2017年 LL. All rights reserved.
//

#import "RNViewController.h"
#import "CSSViewController.h"
#import "TextImageViewController.h"
#import "CustomUIController.h"
#import "FlexViewController.h"
#import "PickerViewController.h"
#import "StateViewController.h"
#import "InputTextViewController.h"
#import "ScrollViewController.h"
#import "FlatListViewController.h"
#import "FetchViewController.h"
#import "PushViewController.h"
#import "TouchableViewController.h"
#import "RefreshControlViewController.h"
#import "ShareViewController.h"

@interface RNViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) UITableView *tableView;


@end

@implementation RNViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStyleGrouped];
//    [self.tableView setDataSource:self];
//    [self.tableView setDelegate:self];
//    [self.view addSubview:self.tableView];
    
    self.dataList = @[@"TextImageViewController",
                      @"CustomUIController",
                      @"InputTextViewController",
                      @"CSSViewController",
                      @"FlexViewController",
                      @"StateViewController",
                      @"PickerViewController",
                      @"ScrollViewController",
                      @"FlatListViewController",
                      @"FetchViewController",
                      @"PushViewController",
                      @"TouchableViewController",
                      @"RefreshControlViewController",
                      @"ShareViewController",
                      ];
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
    RNBaseViewController *viewContrllor = [[class alloc] init];
    [viewContrllor setTitle:self.dataList[indexPath.row]];
    [viewContrllor setIndex:indexPath.row];
    [self.navigationController pushViewController:viewContrllor animated:YES];
}



@end
