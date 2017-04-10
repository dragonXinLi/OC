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
    [super viewDidLoad];
    
    
//    
//    UIView *viwe = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
//    [viwe setBackgroundColor:[UIColor orangeColor]];
//    
//    UIEdgeInsets inset = UIEdgeInsetsMake(10, 20, 30, 40);
//    [viwe setTouchExtendInset:inset];
//    
//    CGRect hitFrame = UIEdgeInsetsInsetRect(viwe.bounds, viwe.touchExtendInset);
//    hitFrame.size.width = MAX(hitFrame.size.width, 0);
//    hitFrame.size.height = MAX(hitFrame.size.height, 0);
//    
//    UIView *subView = [[UIView alloc] initWithFrame:hitFrame];
//    [subView setBackgroundColor:[UIColor redColor]];
//    [viwe addSubview:subView];
//    
//    
//    
//    [self.view addSubview:viwe];
    
    [self.headView addTitle:@"珍贵"];
    
    
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    
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
