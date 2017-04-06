//
//  LeRBlankRefreshView.h
//  apple
//
//  Created by sangfor on 17/4/1.
//  Copyright © 2017年 com.sangfor. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger , RefreshState)
{
    RefreshStateNormal,
    RefreshStateRefreshing,
    RefreshStateFailed,
    RefreshStateBlank
};


@protocol LeRBlankRefreshViewDelegate <NSObject>

//刷新失败点击重新刷新数据
- (void)tryToReloadFailedDate;

@end

@interface LeRBlankRefreshView : UIView
{
    UILabel *label;
    
    UIActivityIndicatorView *indicatorView;
}

@property (nonatomic , assign) RefreshState refreshState;

@property (nonatomic , weak) id<LeRBlankRefreshViewDelegate> delegate;

- (id)initWithRealFrame:(CGRect)realFrame;

- (UILabel *)getFailedLabel;

- (UIActivityIndicatorView *)getIndicatorView;

@end
