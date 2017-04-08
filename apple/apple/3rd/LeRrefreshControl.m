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
        arrowView.center = CGPointMake(activityView.center.x, tips.center.y);
        self.backgroundColor = [UIColor clearColor];
        
//        [self ]
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
            if([value CGPointValue].y < -self.frame.size.height)
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
@end
