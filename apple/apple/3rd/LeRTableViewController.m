//
//  LeRTableViewController.m
//  apple
//
//  Created by sangfor on 17/4/1.
//  Copyright © 2017年 com.sangfor. All rights reserved.
//

#import "LeRTableViewController.h"

@interface LeRTableViewController ()<LeRBlankRefreshViewDelegate>
{
    UILabel *emptyLabel;
    UILabel *subTipsLabel;
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
        emptyLabel = [LeRTableAide generateEmptyLabel:self.emptyTips];
        emptyLabel.tag = 1000;
        [self.tableView addSubview:emptyLabel];
    }
    
    if(self.subTips)
    {
        [emptyLabel setOriginY:187 + (SCREEN_WIDTH - 320) / 2];
        subTipsLabel = [LeRTableAide generateSubTipsLabel:self.subTips andEmptyLabel:emptyLabel];
        subTipsLabel.tag = 10001;
        [self.tableView addSubview:subTipsLabel];
    }
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if(self.view.constraints.count == 0 && !self.notNeedAutoLayout)
    {
        //为tableView添加父视图约束
        [self addAutoLayoutConstrainWithView:self.tableView];
    }
}

- (void)setRefreshState:(RefreshState)refreshState
{
    _refreshState = refreshState;
    
    if(!blankRefreshView)
    {
        blankRefreshView = [[LeRBlankRefreshView alloc] initWithFrame:CGRectZero];
        blankRefreshView.delegate = self;
        blankRefreshView.tag = 20001;
        [self.view addSubview:blankRefreshView];
    }
    [blankRefreshView setRefreshState:refreshState];
}


- (void)tryToReloadFailedDate
{
    
}


- (void)shouldShowTips:(BOOL)show
{
    emptyLabel.hidden = !show;
}


- (void)adjustEmptyTipsFrame
{
    [emptyLabel setOriginY:(self.tableView.height - emptyLabel.height)/2];
}


- (void)setRefreshViewBackColor:(UIColor *)color
{
    blankRefreshView.backgroundColor = color;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)refreshConstraints
{
    [self addAutoLayoutConstrainWithView:self.tableView];
    [self.view layoutIfNeeded];
}


- (void)dealloc
{
    self.tableView.delegate = nil;
    self.tableView.dataSource = nil;
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
