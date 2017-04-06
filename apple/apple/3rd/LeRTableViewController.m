//
//  LeRTableViewController.m
//  apple
//
//  Created by sangfor on 17/4/1.
//  Copyright © 2017年 com.sangfor. All rights reserved.
//

#import "LeRTableViewController.h"

@interface LeRTableViewController ()
{
    UILabel *emptyLabel;
    UILabel *sunTipsLabel;
    LeRBlankRefreshView *blankRefreshView;
}

@end

@implementation LeRTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.headView = [[LeRHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44+STATUSBAR_SHIFT)];
    [self.headView addTitle:self.title];
    _backButton = [self.headView addbackButtonForDisappearingWay:self.disappearingWay];
    [self.view addSubview:self.headView];
    
    if(!self.tableView)
    {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44 + STATUSBAR_SHIFT, SCREEN_WIDTH, SCREEN_HEIGHT - 44 - STATUSBAR_SHIFT) style:self.tableViewStyle];
    }
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    if(self.tableView == UITableViewStylePlain)
    {
        self.tableView.backgroundColor = [UIColor colorWithHexString:TableBackgroundColor];
    }else
    {
        self.tableView.backgroundColor = [UIColor colorWithHexString:SetTableBackgroundColor];
    }
    
    [self.view addSubview:self.tableView];
    
    if(self.emptyTips)
    {
        emptyLabel = []
    }
    
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
