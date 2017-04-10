//
//  LeRRefreshTableView.m
//  apple
//
//  Created by sangfor on 17/4/10.
//  Copyright © 2017年 com.sangfor. All rights reserved.
//

#import "LeRRefreshTableView.h"

@implementation LeRRefreshTableView

@synthesize refreshControl;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
    
    }
    return self;
}


- (void)insertRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation
{
    [super insertRowsAtIndexPaths:indexPaths withRowAnimation:animation];
    if([self.rowDelegate respondsToSelector:@selector(LeRRefreshTableViewRowChanged:)])
    {
        [self.rowDelegate LeRRefreshTableViewRowChanged:indexPaths.count];
    }
}


- (void)deleteRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation
{
    [super deleteRowsAtIndexPaths:indexPaths withRowAnimation:animation];
    
    if([self.rowDelegate respondsToSelector:@selector(LeRRefreshTableViewRowChanged:)])
    {
        [self.rowDelegate LeRRefreshTableViewRowChanged:indexPaths.count];
    }
}


- (BOOL)touchesShouldCancelInContentView:(UIView *)view
{
    return YES;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    if([self.rowDelegate respondsToSelector:@selector(tableViewTouchesBegan:withEvent:)])
    {
        [self.rowDelegate tableViewTouchesBegan:touches withEvent:event];
    }
}


- (id)refreshControl
{
    if(refreshControl == nil)
    {
        refreshControl = [[NSClassFromString([self refreshClassName]) alloc] init];
        [self addSubview:refreshControl];
    }
    return refreshControl;
}


- (NSString *)refreshClassName
{
    NSString *className = @"LeRRefreshControl";
    switch (self.refreshViewStyle) {
        case LeRRefreshViewStyleNew:
            className = @"LeRRefreshControlNewStyle";
            break;
        case LeRRefreshViewStyleDeepBackground:
            className = @"LeRRefreshControlDeepBackground";
            break;
        default:
            break;
    }
    return className;
}

@end
