//
//  LeRRefreshTableViewController.m
//  apple
//
//  Created by sangfor on 17/4/7.
//  Copyright © 2017年 com.sangfor. All rights reserved.
//

#import "LeRRefreshTableViewController.h"

@interface LeRRefreshTableViewController ()<LeRRefreshTableViewDelegate,LeRBlankRefreshViewDelegate,LeRRefreshTableDelegate>
{
    UIActivityIndicatorView *activityView;
    NSMutableArray *triggerEventArray;
    
    BOOL hasEverPullSucess;
    LeRRefreshType firstRefreshType;
}

@property (nonatomic , strong) NSNumber *fetchingIndex;

@property (nonatomic , assign) BOOL pullDownSucess;
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
            return [weakself refreshWithCallBack:^{
                [sender endRefreshing:weakself.pullDownSucess];
            }];
        }];
    }
    
    if(self.showActivityView && !self.isBlankRefresh)
    {
        self.tableView.scrollEnabled = NO;
        activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        activityView.center = CGPointMake(self.view.width/2, self.view.height / 2);
        [activityView startAnimating];
        [self.view addSubview:activityView];
    }
    
    if(self.isBlankRefresh)
    {
        self.blankRefreshView = [[LeRBlankRefreshView alloc] initWithFrame:CGRectZero];
        self.blankRefreshView.delegate = self;
        [self.view addSubview:self.blankRefreshView];
    }
    
    if(self.lerRefreshType & LeRRefreshTypePullUp && self.refreshType != LeRPullUpRefreshTypeFetch)
    {
        //上拉加载的时候不是fetch加载
        CGFloat height = MAX(self.tableView.contentSize.height, self.tableView.height);
        refreshTableFooterView = [[LeRRefreshTableFooterView alloc] initWithFrame:CGRectMake(0, height, self.tableView.width, self.view.height)];
        refreshTableFooterView.delegate = self;
        [self.tableView addSubview:refreshTableFooterView];
        refreshTableFooterView.type = self.refreshType;
        
        if(self.autoPullUpFirstTime)
        {
            firstTimeLoad = YES;
            [self shouldShowTips:NO];
            //第一次上拉的时候，看到的上拉为正在加载状态
            [refreshTableFooterView setState:LeRPullRefreshStateLoading];
            [self LeRRefreshTableDidTriggerRefresh];
            firstTimeLoad = YES;
        }
    }
    
    if(self.fetchLabel)
    {
        self.blankRefreshView.refreshState = RefreshStateNormal;
        self.headActivityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        CGFloat titleWidth = [self.title sizeWithFont:[self.headView returnTitleLabel].font].width;
        self.headActivityView.center = CGPointMake((SCREEN_WIDTH - titleWidth)/2-20, (self.headView.height+STATUSBAR_SHIFT/2));
        [self.headView addSubview:self.headActivityView];
        
        if(self.autoFetchFirstTime)
        {
            NSAssert(0, nil);
            if(self.isEmptyTable)
            {
                self.blankRefreshView.refreshState = RefreshStateRefreshing;
            }
        }
    }
    //这里有一段耳机的代码
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    if([self shou])
}


- (BOOL)refreshWithCallBack:(void(^)(void))callBack
{
    refreshCallBack = callBack;
    [self pullDownRefreshData];
    return YES;
}


- (BOOL)isEmptyTable
{
    NSInteger rowCount = 0;
    for (int i =0 ; i < [self.tableView numberOfSections]; i++) {
        rowCount += [self.tableView numberOfRowsInSection:i];
    }
    return rowCount == 0;
}


- (void)fetch
{
    BOOL shouldFetch = NO;
    NSAssert(self.fetchingIndex, nil);
    
    if(![self.lastFetchIndex isEqualToNumber:self.fetchingIndex])
    {
        shouldFetch = YES;
    }
    
    if(shouldFetch)
    {
        if(![NetChecker checkNetWithoutAlert])
        {
            [self refetchCompletedWithSuccess:NO];
            return;
        }
        
        NSNumber *tempIndex = self.fetchingIndex;
        self.fetchingIndex = self.lastFetchIndex;
        
        if(! [self.lastFetchIndex isEqualToNumber:@(-1)])
        {
            if(self.lastFetchIndex)
            {
                self.fetchDict[@"prevID"] = self.lastFetchIndex;
            }
            [self.headActivityView startAnimating];
        }
        
        weak(self);
        
        
    }
}


- (BOOL)shouldUpdateForAPPTime
{
//    NSDate *appLauchDate = []
    return NO;
}

@end
