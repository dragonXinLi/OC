//
//  UIViewController+AutoLayout.m
//  apple
//
//  Created by sangfor on 17/4/6.
//  Copyright © 2017年 com.sangfor. All rights reserved.
//

#import "UIViewController+AutoLayout.h"

@implementation UIViewController (AutoLayout)


//为view添加父视图自动布局约束
- (void)addAutoLayoutConstrainWithView:(UIView *)view
{
    if(!ISIOS7)
    {
        return;
    }
    if(![self.view.subviews containsObject:view])
    {
        NSLog(@"warn:UIViewController Constraint donot has tableView subViews now");
        return ;
    }
    
    view.translatesAutoresizingMaskIntoConstraints = NO;
    static UILayoutPriority priority = UILayoutPriorityDefaultLow;
    
    [self removeConstraintWithPriority:priority];
    
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    constraint.priority = priority;
    
    [self.view addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:view.originY];
    constraint.priority = priority;
    
    [self.view addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:1 constant:view.height - self.view.height];
    constraint.priority = priority;
    
    [self.view addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1 constant:0];
    constraint.priority = priority;
    
    [self.view addConstraint:constraint];
}


- (void)removeConstraintWithPriority:(UILayoutPriority)priorty
{
    [self.view.constraints enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(__kindof NSLayoutConstraint * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLayoutConstraint *constraint = obj;
        if(constraint.priority == priorty)
        {
            [self.view removeConstraint:constraint];
        }
    }];
}

@end
