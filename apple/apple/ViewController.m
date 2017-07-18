//
//  ViewController.m
//  apple
//
//  Created by sangfor on 17/3/20.
//  Copyright © 2017年 com.sangfor. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ViewController

- (void)viewDidLoad {
    
    self.lerRefreshType = LeRRefreshTypePullDown;
    self.autoPullUpFirstTime = NO;
    self.emptyTips = @"空白";
    self.isBlankRefresh = NO;
    [super viewDidLoad];
    [self.headView addTitle:@"珍贵"];
    
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    
}


-(void)pullDownRefreshData
{

}


-(void)pullUpRefreshData
{
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = @"打开了房卡掉了";
    return cell;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
