//
//  GestureRecognizerView.m
//  RN
//
//  Created by sangfor on 2018/2/1.
//  Copyright © 2018年 LL. All rights reserved.
//

#import "GestureRecognizerView.h"
#import "UIView+Frame.h"
@interface GestureRecognizerView()<UIGestureRecognizerDelegate>
{
    NSHashTable *_hittingViews;
}

@end

@implementation GestureRecognizerView


@synthesize tapGesture = _tapGesture;//如果.m文件中不需要用全局用到该变量，那么就可以不用setter指定变量名


-(instancetype)initWithFrame:(CGRect)frame
{
    self= [super initWithFrame:frame];
    if(self)
    {
        [self addGestureRecognizer:self.tapGesture];
        _hittingViews = [NSHashTable weakObjectsHashTable];

    }
    return self;
}

- (UITapGestureRecognizer *)tapGesture
{
    if(_tapGesture == nil)
    {
        _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureHandle:)];
        _tapGesture.numberOfTapsRequired = 1;
        _tapGesture.numberOfTouchesRequired = 1;
        _tapGesture.delegate = self;
    }
    return _tapGesture;
}

//- (UITapGestureRecognizer *)tapGesture
//{
//    //直接通过其他方式返回值
//    return xx[@"sss"];
//}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (void)tapGestureHandle:(UIGestureRecognizer *)gestureRecognizer {
    CGPoint location = [gestureRecognizer locationInView:self.viewa];
    if(location.y > 0.f && location.y < self.viewa.height) {
        return;
    }
    
    for (UIView *view in _hittingViews) {
        CGPoint point = [gestureRecognizer locationInView:view];
        BOOL contain =CGRectContainsPoint(view.bounds, point);
        if(contain == NO)
        {
            continue;
        }
        
        UIResponder *responder = [view hitTest:point withEvent:nil];
        while ([responder isKindOfClass:[UIViewController class]] == NO && responder) {
            if([responder isKindOfClass:[UILabel class]])
            {
                UILabel *a = (UILabel *)responder;
                [a setText:@"33333333"];
                break;
            }else if ([responder isKindOfClass:[UIButton class]])
            {
                UIButton *btn = (UIButton *)responder;
                [btn setTitle:@"444444" forState:UIControlStateNormal];
                break;
            }
            responder = responder.nextResponder;
        }
    }
}


- (void)addHittingView:(UIView *)view {
    NSAssert(_hittingViews && (view == nil || [view isKindOfClass:[UIView class]]), nil);
    if(view) {
        [_hittingViews addObject:view];
    }
    //    view.hitting = YES;
}


@end
