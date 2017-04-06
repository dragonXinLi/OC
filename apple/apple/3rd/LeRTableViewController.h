//
//  LeRTableViewController.h
//  apple
//
//  Created by sangfor on 17/4/1.
//  Copyright © 2017年 com.sangfor. All rights reserved.
//

#import "LeRViewController.h"
#import "LeRBlankRefreshView.h"

@interface LeRTableViewController : LeRViewController

@property (nonatomic , strong) UITableView *tableView;
@property (nonatomic , strong) LeRHeadView *headView;
@property (nonatomic , strong) UIButton *backButton;

@property (nonatomic , assign) UITableViewStyle tableViewStyle;
@property (nonatomic , assign) DisappearingWay disappearingWay;

@property (nonatomic , strong) NSString *emptyTips;
@property (nonatomic , strong) NSString *subTips;

@property (nonatomic , assign) RefreshState refreshState;

@property (nonatomic , assign) BOOL notNeedAutoLayout;


- (void)shouldShowTips:(BOOL)show;
- (void)asjustEmptyTipsFrame;

- (void)setRefreshViewBackColor:(UIColor *)color;

- (void)refreshConstraints;

@end
