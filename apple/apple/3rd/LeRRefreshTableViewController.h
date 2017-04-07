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
    
}

@end
