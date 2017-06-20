//
//  EntrysOperateHelper.h
//  apple
//
//  Created by sangfor on 17/4/7.
//  Copyright © 2017年 com.sangfor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EntrysOperateHelper : NSObject
/**
 *	系统时区的时间转字符串（默认系统时区）
 *
 *	@param date		时间
 *	@param format	时间格式
 *
 *	@return 时间字符串
 */
+ (NSString *)stringFromDate:(NSDate *)date andFormat:(NSString *)format;
/**
 *	json字符串转对象，若不是json, 则返回nil
 *
 *	@param jsonString	json字符串
 *
 *	@return id 对象
 */
+ (id)dictFromJsonString:(NSString *)jsonString;
/**
 *	jsondata转对象，若不是json, 则返回nil
 *
 *	@param jsonString	json字符串
 *
 *	@return id 对象
 */
+ (id)dictFromJson:(NSData *)jsonData;

@end
