//
//  LeRrefreshControl.h
//  apple
//
//  Created by sangfor on 17/4/7.
//  Copyright © 2017年 com.sangfor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeRrefreshControl : UIView

@property (nonatomic , readonly) BOOL refresh;

@property (nonatomic , strong) NSDate *lastRefreshDate;

@property (nonatomic , copy) BOOL (^refreshRequest)(LeRrefreshControl *sender);

- (void)beginRefreshing;
- (void)endRefreshing:(BOOL)success;

@end
