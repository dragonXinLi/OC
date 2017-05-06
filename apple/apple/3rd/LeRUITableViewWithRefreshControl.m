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


- (LeRrefreshControl *)refreshControl
{
    if(refreshControl == nil)
    {
        refreshControl = [[LeRrefreshControl alloc] init];
        [self addSubview:refreshControl];
    }
    return refreshControl;
}
@end
