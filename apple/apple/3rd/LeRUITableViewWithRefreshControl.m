//
//  LeRUITableViewWithRefreshControl.m
//  apple
//
//  Created by sangfor on 17/5/6.
//  Copyright © 2017年 com.sangfor. All rights reserved.
//

#import "LeRUITableViewWithRefreshControl.h"

@implementation LeRUITableViewWithRefreshControl

@synthesize refreshControl;

- (void)dealloc
{
    refreshControl = nil;
}


- (LeRRefreshControl *)refreshControl
{
    if(refreshControl == nil)
    {
        refreshControl = [[LeRRefreshControl alloc] init];
        [self addSubview:refreshControl];
    }
    return refreshControl;
}
@end
