//
//  LeRRefreshTimeHandler.m
//  apple
//
//  Created by LL on 17/4/19.
//  Copyright © 2017年 com.sangfor. All rights reserved.
//

#import "LeRRefreshTimeHandler.h"
#import <objc/runtime.h>
#import "FSFileOperation.h"


@implementation LeRRefreshTimeHandler

+ (NSDate *)getTableRefreshTime:(id)object
{
    NSString *keyString;
    if([object isKindOfClass:[NSString class]])
    {
        keyString = object;
    }else
    {
        keyString = [NSString stringWithUTF8String:class_getName([object class])];
    }
    
    NSDate *date = [FSFileOperation objectForKey:keyString andPath:TABLE_REFRESH_TIME];
    
    if(![date isKindOfClass:[NSDate class]])
    {
        return nil;
    }
    return date;
}


+ (void)saveTableRefreshTime:(id)object
{
    NSString *keyString;
    if([object isKindOfClass:[NSString class]])
    {
        keyString = object;
    }else
    {
        keyString = [NSString stringWithUTF8String:class_getName([object class])];
    }
    [FSFileOperation saveObject:[NSDate date] forKey:keyString andPath:TABLE_REFRESH_TIME];
}

@end
