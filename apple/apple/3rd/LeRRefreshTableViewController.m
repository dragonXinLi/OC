//
//  LeRRefreshTableViewController.m
//  apple
//
//  Created by sangfor on 17/4/7.
//  Copyright © 2017年 com.sangfor. All rights reserved.
//

#import "LeRRefreshTableViewController.h"

@interface LeRRefreshTableViewController ()<LeRRefreshTableViewDelegate>
{
    UIActivityIndicatorView *activityView;
    NSMutableArray *triggerEventArray;
    
    BOOL hasEverPullSucess;
    LeRRefreshType firstRefreshType;
}

@property (nonatomic , strong) NSNumber *fetchingIndex;

@end

@implementation LeRRefreshTableViewController


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self)
    {
        triggerEventArray = [[NSMutableArray alloc] init];
        self.pullDownReloadDelay = 0;
        self.autoShowTableViewWhenSucess = YES;
        self.autoPullUpFirstTime = YES;
        self.updateTimeSpaceOn3G = -1;
        self.updateTimeSpaceOnWIFI = -1;
        
        self.autoFetchFirstTime = YES;
        self.lastFetchIndex = @(-1);
        self.fetchingIndex = @0;
        self.localFetchTouchCount = 0;
        
        self.isBlankRefresh = YES;
    }
    return self;
}


- (Class)tableViewClass
{
    return [LeRRefreshTableView class];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    if([self.tableView isMemberOfClass:[UITableView class]])
    {
        UILabel *emptyLabel = (UILabel *)[self.tableView viewWithTag:10000];
        UILabel *subTipsLabel = (UILabel *)[self.tableView viewWithTag:10001];
        [self.tableView removeFromSuperview];
        self.tableView = [[[self tableViewClass] alloc] initWithFrame:self.tableView.frame style:self.tableViewStyle];
        ((LeRRefreshTableView *)self.tableView).rowDelegate = self;
        ((LeRRefreshTableView *)self.tableView).refreshViewStyle = self.refreshViewStyle;
        [self.tableView addSubview:emptyLabel];
        [self.tableView addSubview:subTipsLabel];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:self.tableView];
    }
    
    if(self.lerRefreshType & LeRRefreshTypePullDown)
    {
        refreshControl = (LeRrefreshControl *)[self.tableView refreshControl];
        weak(self);
        [refreshControl setRefreshRequest:^BOOL(LeRrefreshControl *sender) {
            return [weakself refresh]
        }];
    }
}


- (BOOL)

@end
