//
//  NSDate+string.m
//  iOSTest
//
//  Created by lilong on 2018/7/18.
//  Copyright © 2018年 lilong. All rights reserved.
//

#import "NSDate+string.h"

@implementation NSDate (string)

-(NSDate *)getDateFormGMT0ToGMT8
{
    NSDate *date = [NSDate date];
    
    //设置源日期时区
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];//或GMT
    //设置转换后的目标日期时区
    NSTimeZone* destinationTimeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    //得到源日期与世界标准时间的偏移量
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:date];
    //目标日期与本地时区的偏移量
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:date];
    //得到时间偏移量的差值
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    return [self dateByAddingTimeInterval:interval];
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"%@",self];
}

@end
