//
//  LeRrefreshControl.m
//  apple
//
//  Created by sangfor on 17/4/7.
//  Copyright © 2017年 com.sangfor. All rights reserved.
//

#import "LeRrefreshControl.h"

static NSString *const kRefreshControlIdle = @"kRefreshControlIdle";
static NSString *const kRefreshControlPulling = @"kRefreshControlPulling";
static NSString *const kRefreshControlRefreshing = @"kRefreshControlRefreshing";
static NSString *const kRefreshControlRefreshDone = @"kRefreshControlRefreshDone";

@interface LeRrefreshControl ()
{
    UIActivityIndicatorView *activityView;
    UIImageView *arrowView;
    UITextView *tips;
    NSString *state;
    NSInteger dragCount;
}

@property (nonatomic , readonly) UITableView *superTableView;

@end

@implementation LeRrefreshControl

- (void)dealloc
{
    self.refreshRequest = nil;
    self.lastRefreshDate = nil;
}


- (instancetype)init
{
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
    if(self)
    {
        tips = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, self.width, 40)];
        tips.center = CGPointMake(self.width / 2, self.height / 2);
        tips.userInteractionEnabled = NO;
        tips.editable = NO;
        tips.textAlignment = NSTextAlignmentCenter;
        tips.textColor = [UIColor darkGrayColor];
        tips.backgroundColor = [UIColor clearColor];
        tips.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        tips.font = [UIFont systemFontOfSize:12.f];
        [self addSubview:tips];
        
        activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        activityView.center = CGPointMake(self.width / 2 - 43, tips.center.y);
        activityView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        activityView.color = [UIColor clearColor];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:activityView.frame];
        imageView.image = [UIImage imageNamed:@"loading"];
        [self addAnimationWith:imageView];
        [activityView addSubview:imageView];
        [self addSubview:activityView];
        
        arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"refreshArrow"]];
        arrowView.center = CGPointMake(activityView.center.x, tips.center.y);
        
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.backgroundColor = [UIColor clearColor];
        
        [self changeState:kRefreshControlIdle andValue:nil andForce:YES];
    }
    return self;
}


- (void)addAnimationWith:(UIImageView *)imageView
{
    CALayer *layer = imageView.layer;
    CAKeyframeAnimation *animation;
    animation.duration = 0.5f;
    animation.cumulative = YES;
    animation.repeatCount = 100000;
    animation.values = [NSArray arrayWithObjects:
                        [NSNumber numberWithFloat:0.0 * M_PI],
                        [NSNumber numberWithFloat:0.75 * M_PI],
                        [NSNumber numberWithFloat:1.5 * M_PI] , nil
                        ];
    animation.keyTimes = [NSArray arrayWithObjects:
                          [NSNumber numberWithFloat:0],
                          [NSNumber numberWithFloat:.5],
                          [NSNumber numberWithFloat:1.0]
                          , nil];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    [layer addAnimation:animation forKey:nil];
}


- (void)willMoveToSuperview:(UIView *)newSuperview
{
    // $$$$$$$$$$$$ 添加到superView时，调整自身的frame
    self.frame = CGRectMake(0, -self.height, newSuperview.width, self.height);
}


- (void)didMoveToSuperview
{
    //添加到superView时，观察上层UITableView的contentOffset
    [self.superTableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}


- (void)removeFromSuperview
{
    if(self.superTableView)
    {
        //移除时自身时，取消观察contentOffset
        [self.superTableView removeObserver:self forKeyPath:@"contentOffset"];
    }
}


- (void)changeState:(NSString *)newState andValue:(id)value andForce:(BOOL)force
{
    NSArray *stateMachie = [NSArray arrayWithObjects:kRefreshControlIdle , kRefreshControlPulling,kRefreshControlRefreshing,kRefreshControlRefreshDone, nil];
    if(state && force == NO)
    {
        if([stateMachie containsObject:newState])
        {
            NSUInteger old = [stateMachie indexOfObject:state];
            NSUInteger new = [stateMachie indexOfObject:newState];
            
            if((old + 1) % stateMachie.count == new || old == new)
            {
                
            }
        }
    }
}


- (void)changeStateEx:(NSString *)newState andValue:(id)value
{
    BOOL hasChanged = !(state == newState);
    
    if(newState)
    {
        state = newState;
        if([state isEqualToString:kRefreshControlIdle] && hasChanged)
        {
            arrowView.transform = CGAffineTransformMakeRotation(0);
            [activityView stopAnimating];
        }else if([state isEqualToString:kRefreshControlPulling])
        {
            NSString *str1 = NSLocalizedStringFromTable(@"Pull down to refresh", @"Common", nil);
            
            CGAffineTransform t = CGAffineTransformMakeRotation(0);
            if([value CGPointValue].y < -self.height)
            {
                str1 = NSLocalizedStringFromTable(@"Loosen to refresh", @"Common", nil);
                t = CGAffineTransformMakeRotation(M_PI);
            }
            
            NSString *str = [NSString stringWithFormat:@"%@",str1];
            if([tips.text isEqualToString:str] == NO)
            {
                [self setTipsString:str];
            }
            
            arrowView.hidden = NO;
            if(CGAffineTransformEqualToTransform(t, arrowView.transform) == NO)
            {
                [self setTipsString:str];
                [UIView animateWithDuration:0.15 animations:^{
                    arrowView.transform = t;
                }];
            }
        }else if ([state isEqualToString:kRefreshControlRefreshing] && hasChanged)
        {
            NSString *str1 = NSLocalizedStringFromTable(@"Refreshing...", @"Common", nil);
            [self setTipsString:[NSString stringWithFormat:@"%@",str1]];
            arrowView.hidden = YES;
            [activityView startAnimating];
        }
        else if ([state isEqualToString:kRefreshControlRefreshDone] && hasChanged)
        {
            if([value boolValue])
            {
                [self setTipsString:NSLocalizedStringFromTable(@"Refresh done", @"Common", nil)];
            }else
            {
                [self setTipsString:NSLocalizedStringFromTable(@"Refresh failed", @"Common", nil)];
            }
            arrowView.hidden = YES;
            [activityView stopAnimating];
        }
        
    }
}


- (void)setTipsString:(NSString *)str
{
    CGSize strSize = [str sizeWithFont:tips.font constrainedToSize:self.frame.size];
    strSize.height += tips.font.capHeight * 2;
    
    tips.text = str;
    tips.frame = CGRectMake(0, (self.height - strSize.height)/2, tips.width, strSize.height);
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if([keyPath isEqualToString:@"contentOffset"])
    {
        NSValue *offsetValue = [NSValue valueWithCGPoint:self.superTableView.contentOffset];
        if(self.superTableView.contentOffset.y > - self.height)
        {
            if(-self.height != self.originY)
            {
                self.frame = CGRectMake(0, -self.height, self.width, self.height);
            }
        }else
        {
            self.frame = CGRectMake(0, self.superTableView.contentOffset.y, self.width, self.height);
        }
        
        if(self.superTableView.dragging)
        {
            if(![state isEqualToString:kRefreshControlPulling] || self.superTableView.contentOffset.y < 0)
            {
                [self changeState:kRefreshControlPulling andValue:offsetValue andForce:NO];
            }
            
            dragCount ++ ;
        }else if (self.superTableView.decelerating)
        {
            if(self.refresh)
            {
                if(self.superTableView.contentOffset.y < -self.height / 2 && dragCount > 1)
                {
                    [self.superTableView setContentOffset:CGPointMake(0, -self.height) animated:YES];
                }
            }else
            {
                if([state isEqualToString:kRefreshControlPulling] && CGAffineTransformEqualToTransform(arrowView.transform, CGAffineTransformMakeRotation(0)) == NO)
                {
                    if(self.refreshRequest && self.refreshRequest(self))
                    {
                        [self changeState:kRefreshControlRefreshing andValue:offsetValue andForce:NO];
                        
                        weak(self);
                        [UIView animateWithDuration:0.3 animations:^{
                            [weakself.superTableView setContentOffset:CGPointMake(0, -self.height)];
                        }];
                    }
                }else
                {
                    [self changeState:kRefreshControlIdle andValue:offsetValue andForce:YES];
                }
            }
            
            dragCount = 0;
        }
    }
}


- (BOOL)refresh
{
    return [state isEqualToString:kRefreshControlRefreshing];
}


- (UITableView *)superTableView
{
    NSAssert([self.superTableView isKindOfClass:[UITableView class]] || self.superTableView == nil, @"%@'s superView should be a UITableView, but now is %@", self.class, self.superTableView.class);

    return (UITableView *)self.superview;
}


- (void)beginRefreshing
{
    [self changeState:kRefreshControlRefreshing andValue:nil andForce:YES];
    
    if(CGPointEqualToPoint(self.superTableView.contentOffset, CGPointMake(0, 0)))
    {
        [self.superTableView setContentOffset:CGPointMake(0, -self.height)];
    }
}


- (void)endRefreshing:(BOOL)success
{
    [self changeState:kRefreshControlRefreshDone andValue:[NSNumber numberWithBool:success] andForce:NO];
    
    weak(self);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if(weakself.refresh == NO && weakself.superTableView.dragging == NO)
        {
            if(CGPointEqualToPoint(weakself.superTableView.contentOffset, CGPointMake(0, -weakself.height)))
            {
                [UIView animateWithDuration:0.3 animations:^{
                    [weakself.superTableView setContentOffset:CGPointZero];
                }];
            }
            
            [weakself changeState:kRefreshControlIdle andValue:nil andForce:NO];
        }
    });
    
}

@end
