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
        tips = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 40)];
        tips.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
        tips.userInteractionEnabled = NO;
        tips.editable = NO;
        tips.textAlignment = NSTextAlignmentCenter;
        tips.textColor = [UIColor darkGrayColor];
        tips.backgroundColor = [UIColor clearColor];
        tips.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        tips.font = [UIFont systemFontOfSize:12.f];
        [self addSubview:tips];
        
        activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        activityView.center = CGPointMake(self.frame.size.width / 2 - 43, tips.center.y);
        activityView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        activityView.color = [UIColor clearColor];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:activityView.frame];
        imageView.image = [UIImage imageNamed:@"loading"];
        [self addAnimationWith:imageView];
        [activityView addSubview:imageView];
        [self addSubview:activityView];
        
        arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"refreshArrow"]];
//        arrowView.center = CGPointMake(activityView.center.x, <#CGFloat y#>)
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





@end
