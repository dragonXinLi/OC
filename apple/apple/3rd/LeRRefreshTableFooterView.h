//
//  LeRRefreshTableFooterView.h
//  apple
//
//  Created by sangfor on 17/4/7.
//  Copyright © 2017年 com.sangfor. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger , LeRPullRefreshState)
{
    LeRPullRefreshStatePulling,
    LeRPullRefreshStateNormal,
    LeRPullRefreshStateLoading
};

typedef NS_ENUM(NSInteger , LeRPullUpRefreshType)
{
    LeRPullUpRefreshTypeManual,
    LeRPullUpRefreshTypeAutomatic,
    LeRPullUpRefreshTypeFetch
};

@protocol LeRRefreshTableDelegate <NSObject>

- (void)LeRRefreshTableDidTriggerRefresh;
- (BOOL)LeRRefreshTableDataSourceIsLoading:(UIView *)view;

@optional
- (NSDate *)LeRRefreshTableDataSourceLastUpdated:(UIView *)view;

@end

@interface LeRRefreshTableFooterView : UIView
{
    LeRPullRefreshState _state;
    
    UILabel *_lastUpdatedLabel;
    UILabel *_statusLabel;
    CALayer *_arrowImage;
    UIActivityIndicatorView *_activityView;
}

@property (nonatomic , weak) id<LeRRefreshTableDelegate> delegate;

@property (nonatomic , assign) LeRPullUpRefreshType type;

@property (nonatomic , assign) CGFloat refreshRegionHeight;

@property (nonatomic , assign) BOOL canLoadMore;

- (void)setState:(LeRPullRefreshState)aState;

- (id)initWithFrame:(CGRect)frame arrowImageName:(NSString *)arrow textColor:(UIColor *)textColor;

- (void)refreshLastUpdateDate;
- (void)LeRRefreshScrollViewDidScroll:(UIScrollView *)scrollView;
- (void)LeRRefreshScrollViewDidEndDragging:(UIScrollView *)scrollView;
- (void)LeRRefreshScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView;
- (CGFloat)getRefreshRegionHeight;

@end
