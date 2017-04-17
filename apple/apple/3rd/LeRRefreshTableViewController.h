//
//  LeRRefreshTableViewController.h
//  apple
//
//  Created by sangfor on 17/4/7.
//  Copyright © 2017年 com.sangfor. All rights reserved.
//

#import "LeRTableViewController.h"
#import "LeRBlankRefreshView.h"
#import "LeRRefreshTableFooterView.h"
#import "LeRrefreshControl.h"
#import "LeRRefreshTableView.h"

typedef NS_ENUM(NSInteger, TriggerEventType)
{
    TriggerEventTypeTimeRules,//时间规则触发刷新时间
};

typedef NS_OPTIONS(NSInteger, LeRRefreshType)
{
    LeRRefreshTypePullDown = 1 << 0,
    LeRRefreshTypePullUp   = 1 << 1
};

@interface LeRRefreshTableViewController : LeRTableViewController<LeRRefreshTableDelegate,LeRBlankRefreshViewDelegate>
{
    LeRRefreshTableFooterView *refreshTableFooterView;
    LeRrefreshControl *refreshControl;
    void (^refreshCallBack)(void);
    
    void(^fetchCallBack)(bool result);
    BOOL _reloading;
    
    BOOL firstTimeLoad;
}

@property (nonatomic , assign) LeRRefreshViewStyle refreshViewStyle;

@property (nonatomic , assign) LeRPullUpRefreshType refreshType;

@property (nonatomic , assign) LeRRefreshType lerRefreshType;

@property (nonatomic , assign) BOOL isBlankRefresh;
@property (nonatomic , assign) BOOL showActivityView;
@property (nonatomic , assign) BOOL autoPullUpFirstTime;
// $$$$$$$$$$$$ nullable和nonnull xcode6.3引入，为了解决swift兼容问题
@property (nonatomic , strong) NSString * loadFailPromptText;
@property (nonatomic , assign) NSTimeInterval pullDownReloadDelay;
@property (nonatomic , assign) BOOL autoShowTableViewWhenSucess;

@property (nonatomic , assign) NSTimeInterval updateTimeSpaceOn3G;
@property (nonatomic , assign) NSTimeInterval updateTimeSpaceOnWIFI;
@property (nonatomic , strong) NSString  *pageName;

@property (nonatomic , strong) id  fetchLabel;
@property (nonatomic , strong) id  fetchObject;
@property (nonatomic , strong) Class fetchClass;
@property (nonatomic , strong) NSMutableDictionary *fetchDict;
@property (nonatomic , strong) UIActivityIndicatorView *headActivityView;
@property (nonatomic , assign) NSInteger countInpage;
@property (nonatomic , strong) NSNumber *lastFetchIndex;
@property (nonatomic , assign) NSInteger localFetchTouchCount;
@property (nonatomic , assign) BOOL autoFetchFirstTime;
@property (nonatomic , strong) LeRBlankRefreshView *blankRefreshView;

- (void)setFooterView;

- (void)pullUpRefreshData;
- (void)downLoadingTableViewDataAndMore:(BOOL)more;
- (void)downLoadingDataFailed;

- (Class)tableViewClass;

- (void)pullDownRefreshData;
- (void)pullDownRefreshSucess:(BOOL)sucess;
- (void)pullDownRefreshSucess:(BOOL)sucess andMore:(BOOL)more;
- (void)setCanLoadMore:(BOOL)more;
- (void)setEverPullSucess:(BOOL)sucess;

- (void)addTarget:(id)target action:(nonnull SEL)action forTriggerEvent:(TriggerEventType)enentType;

- (void)refetch;
- (void)fetch;
- (void)refetchCompletedWithSuccess:(BOOL)sucess;
- (void)tryToLoadMoreLocalDataInTableView:(nonnull UITableView *)tableView andIndex:(nonnull NSIndexPath *)indexPath;

- (BOOL)isEmptyTable;

- (void)scrollViewDidScroll:(nonnull UIScrollView *)scrollView;
- (nonnull UIView *)tableFooterView;

- (void)refreshTableViewControllerTouchesBegan:(nonnull NSSet<UITouch *> *)touches WithEvent:(nonnull UIEvent *)event;

@end
