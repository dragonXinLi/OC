//
//  EntrysOperateHelper.m
//  apple
//
//  Created by sangfor on 17/4/7.
//  Copyright © 2017年 com.sangfor. All rights reserved.
//

#import "EntrysOperateHelper.h"

@implementation EntrysOperateHelper

+(NSString *)stringFromDate:(NSDate *)date andFormat:(NSString *)format
{
    return [self stringFromDate:date andFormat:format withTimeZone:nil];
}


+ (NSString *)stringFromDate:(NSDate *)date andGMT8Format:(NSString *)format
{
//    return <#expression#>
    return nil;
}


+ (NSString *)stringFromDate:(NSDate *)date andFormat:(NSString *)format withTimeZone:(NSTimeZone *)timeZone
{
    if(!date)
    {
        date = [NSDate date];
    }
    if(!format)
    {
        format = @"yyyyMMdd HH:mm:ss";
    }
    
    NSMutableDictionary *threadDict = [NSThread currentThread].threadDictionary;
    NSMutableDictionary *dateFormatters = nil;
    
    @synchronized (threadDict) {
        dateFormatters = threadDict[@"dateFormatters"];
        if(dateFormatters == nil)
        {
            dateFormatters = [NSMutableDictionary dictionary];
            threadDict[@"dateFormatters"] = dateFormatters;
        }
    }
    
    NSDateFormatter *formatter = dateFormatters[format];
    
    if(formatter == nil)
    {
        formatter = [[NSDateFormatter alloc] init];
        formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        formatter.dateFormat = format;
        dateFormatters[format] = formatter;
    }
    
    if (timeZone == nil) {
        timeZone = [NSTimeZone systemTimeZone];
    }
    
    if(formatter.timeZone != timeZone)
    {
        formatter.timeZone = timeZone;
    }
    
    return [formatter stringFromDate:date];
}

@end
