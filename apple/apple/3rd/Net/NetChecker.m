//
//  NetChecker.m
//  apple
//
//  Created by sangfor on 17/4/11.
//  Copyright © 2017年 com.sangfor. All rights reserved.
//

#import "NetChecker.h"
#import "Reachability.h"
#import <ifaddrs.h>
#import <net/if.h>
#import <SystemConfiguration/SystemConfiguration.h>

@implementation NetChecker

+ (BOOL)checkNetStatus
{
    if([AppDelegate isConnectedToInternet] == NO)
    {
        LeRAlert *alert = [[LeRAlert alloc] initWithTitle:@"网络不给力" andAlertPromptType:AlertPromptTypeError delegate:nil];
        [alert show];
        return NO;
    }
    return NO;
}


+ (BOOL)checkNetForAsynchronousRequest
{
    return [self checkNetWithTitle:@"当前网络不可用"];
}


+ (BOOL)checkNetWithTitle:(NSString *)title
{
    if([AppDelegate isConnectedToInternet] == NO)
    {
        LeRAlert *alert = [[LeRAlert alloc] initWithTitle:title andAlertPromptType:AlertPromptTypeError delegate:nil];
        [alert show];
        return NO;
    }
    return YES;
}


+ (BOOL)checkNetWithoutAlert
{
    if([AppDelegate isConnectedToInternet] == NO)
    {
        return NO;
    }
    return YES;
}


+ (BOOL)isWifi
{
    return [AppDelegate isConnectedWithWifi];
}

@end
