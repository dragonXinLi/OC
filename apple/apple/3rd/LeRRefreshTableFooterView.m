//
//  LeRRefreshTableFooterView.m
//  apple
//
//  Created by sangfor on 17/4/7.
//  Copyright © 2017年 com.sangfor. All rights reserved.
//

#import "LeRRefreshTableFooterView.h"
#import <QuartzCore/QuartzCore.h>


@implementation LeRRefreshTableFooterView

- (id)initWithFrame:(CGRect)frame arrowImageName:(NSString *)arrow textColor:(UIColor *)textColor
{
    if ((self = [super initWithFrame:frame])) {
        self.refreshRegionHeight = 65.0f;
        self.canLoadMore = YES;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//        self.backgroundColor = [UIColor colorWithRed:226.0 / 255.0 green:231.0 / 255.0 blue:237.0 / 255.0  alpha:1.0];
        self.backgroundColor = [UIColor clearColor];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 20.0f, self.width, 20.0f)];
        label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        label.font = [UIFont systemFontOfSize:12.0f];
        label.textColor = textColor;
        label.shadowColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
        label.shadowOffset = CGSizeMake(0.0f, 1.0f);
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        _lastUpdatedLabel = label;
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, 20.f)];
        label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        label.font = [UIFont boldSystemFontOfSize:13.0f];
        label.textColor = textColor;
        label.shadowColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
        label.shadowOffset = CGSizeMake(0.0f, 1.0f);
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        _statusLabel = label;
        
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(25.0f, 0.0f, 30.0f, 55.0f);
        layer.contentsGravity = kCAGravityResizeAspect;
        layer.contents = (id)[UIImage imageNamed:arrow].CGImage;
        
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 40000
        if([[UIScreen mainScreen] respondsToSelector:@selector(sacle)])
        {
            layer.contentsScale = [[UIScreen mainScreen] scale];
        }
#endif
        [[self layer] addSublayer:layer];
        
        UIActivityIndicatorView *view = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        view.frame = CGRectMake(25.f, 10.f, 20.f, 20.f);
        [self addSubview:view];
        _activityView = view;
        
        [self setState:LeRPullRefreshStateNormal];
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame arrowImageName:@"blueArrow.png" textColor:[UIColor grayColor]];
}


- (void)refreshLastUpdateDate
{
    NSDate *date = [_delegate LeRRefreshTableDataSourceLastUpdated:self];
    NSString *dateString = date ? [EntrysOperateHelper stringFromDate:date andFormat:@"yyyy-MM-dd HH:mm:ss"] : @"无";
    _lastUpdatedLabel.text = [NSString stringWithFormat:@"最近更新:%@",dateString];
    [[NSUserDefaults standardUserDefaults] setObject:_lastUpdatedLabel.text forKey:@"LeRRefreshTableView_LastRefresh"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


- (void)setState:(LeRPullRefreshState)aState
{
    switch (aState) {
        case LeRPullRefreshStatePulling:
            _statusLabel.text = @"释放加载更多...";
            
            [CATransaction begin];
            [CATransaction setAnimationDuration:0.2];
            
            _arrowImage.transform = CATransform3DIdentity;
            [CATransaction commit];
            break;
        case LeRPullRefreshStateNormal:
            if(_state == LeRPullRefreshStatePulling)
            {
                [CATransaction begin];
                [CATransaction setAnimationDuration:0.2];
                _arrowImage.transform = CATransform3DIdentity;
                [CATransaction commit];
            }
            
            _statusLabel.text = @"上拉获取更多...";
            [_activityView stopAnimating];
            [CATransaction begin];
            [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
            _arrowImage.hidden = NO;
            _arrowImage.transform = CATransform3DMakeRotation((M_PI / 180.0) * 180.0f, 0.0f, 0.0f, 0.0f);
            [CATransaction commit];
            
            [self refreshLastUpdateDate];
            break;
        case LeRPullRefreshStateLoading:
            _statusLabel.text = @"加载中...";
            [_activityView startAnimating];
            [CATransaction begin];
            [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
            _arrowImage.hidden = YES;
            [CATransaction commit];
            break;
        default:
            break;
    }
    _state = aState;
}


- (void)setCanLoadMore:(BOOL)canLoadMore
{
    if(!canLoadMore)
    {
        self.hidden = YES;
    }
    else
    {
        self.hidden = NO;
    }
    _canLoadMore = canLoadMore;
}


- (void)LeRRefreshScrollViewDidScroll:(UIScrollView *)scrollView
{
    if(!self.canLoadMore || scrollView.contentOffset.y <= 0)
    {
        return;
    }
    CGFloat regionHeight = self.refreshRegionHeight *(1 - self.type);
    
    if(_state == LeRPullRefreshStateLoading)
    {
        CGFloat offset = MAX(scrollView.contentOffset.y * -1, 0);
        offset = MIN(offset, 60);
        scrollView.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, self.refreshRegionHeight, 0.0f);
        return;
    }else if(scrollView.isDragging)
    {
        BOOL _loading = NO;
        _loading = [_delegate LeRRefreshTableDataSourceIsLoading:self];
        
        if(_state == LeRPullRefreshStatePulling && (scrollView.contentOffset.y + scrollView.height) < scrollView.contentSize.height + regionHeight && scrollView.contentOffset.y > 0.0f && !_loading)
        {
            [self setState:LeRPullRefreshStateNormal];
        }else if(_state == LeRPullRefreshStateNormal &&
                 scrollView.contentOffset.y + (scrollView.height) > scrollView.contentSize.height + regionHeight &&
                 ! _loading)
        {
            [self setState:LeRPullRefreshStatePulling];
        }
        
        if(scrollView.contentInset.top != 0)
        {
            scrollView.contentInset = UIEdgeInsetsZero;
        }
        
        if(self.type == LeRPullUpRefreshTypeAutomatic)
        {
            [self LeRRefreshScrollViewDidEndDragging:scrollView];
        }
    }
}


- (void)setType:(LeRPullUpRefreshType)type
{
    _type = type;
    self.refreshRegionHeight = [self getRefreshRegionHeight];
    if(type == LeRPullUpRefreshTypeManual)
    {
        _lastUpdatedLabel.hidden = NO;
        _activityView.frame = CGRectMake(25.0f, 15.0f, 20.0f, 20.0f);
        _statusLabel.frame = CGRectMake(0.0f, 0.0f, self.width, 20.0f);
    }else if(type == LeRPullUpRefreshTypeAutomatic)
    {
        _lastUpdatedLabel.hidden = YES;
        _activityView.frame = CGRectMake(105.f, 10.0f, 20.0f, 20.0f);
        _statusLabel.frame = CGRectMake(0.0f, 10.0f, self.width, 20.0f);
    }
}


- (CGFloat)getRefreshRegionHeight
{
    if(self.type == LeRPullUpRefreshTypeManual)
    {
        return 50;
    }
    if(self.type == LeRPullUpRefreshTypeAutomatic)
    {
        return 40;
    }
    return 0;
}


- (void)LeRRefreshScrollViewDidEndDragging:(UIScrollView *)scrollView
{
    if(!self.canLoadMore || scrollView.contentOffset.y < 0)
    {
        return;
    }
    CGFloat regionHeight = self.refreshRegionHeight*(1-self.type);
    
    BOOL _loading = [_delegate LeRRefreshTableDataSourceIsLoading:self];
    if(scrollView.contentOffset.y + (scrollView.height) >= scrollView.contentSize.height + regionHeight &&
       ! _loading)
    {
        [_delegate LeRRefreshTableDidTriggerRefresh];
        
        [self setState:LeRPullRefreshStateLoading];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.3];
        scrollView.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, self.refreshRegionHeight, 0.0f);
        [UIView commitAnimations];
    }
}


- (void)LeRRefreshScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.3];
    [scrollView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    [UIView commitAnimations];
    
    [self setState:LeRPullRefreshStateNormal];
}


@end
