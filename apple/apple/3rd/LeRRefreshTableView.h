//
//  LeRRefreshTableView.h
//  apple
//
//  Created by sangfor on 17/4/10.
//  Copyright © 2017年 com.sangfor. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSInteger, LeRRefreshViewStyle)
{
    LeRRefreshViewStyleNormal = 0,
    LeRRefreshViewStyleDeepBackground,
    LeRRefreshViewStyleNew,
};

@protocol LeRRefreshTableViewDelegate <NSObject>

@optional

- (void)LeRRefreshTableViewRowChanged:(NSInteger)count;
- (void)tableViewTouchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event;

@end

@interface LeRRefreshTableView : UITableView

@property (nonatomic , weak) id<LeRRefreshTableViewDelegate> rowDelegate;
@property (nonatomic , strong) id refreshControl;

@property (nonatomic , assign) LeRRefreshViewStyle refreshViewStyle;

@end
