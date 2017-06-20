//
//  VCDefine.h
//  apple
//
//  Created by sangfor on 17/4/6.
//  Copyright © 2017年 com.sangfor. All rights reserved.
//

#ifndef VCDefine_h
#define VCDefine_h

#ifndef __OPTIMIZE__
#define kFlagDebug YES
#else
#define kFlagDebug NO
#endif

#ifndef __OPTIMIZE__
#define NSLog(fmt,...) {\
                        NSString *retainString = [NSString stringWithFormat:(@"[%@:%d]" fmt), [[[NSString stringWithUTF8String:__FILE__] pathComponents] lastObject], __LINE__, ##__VA_ARGS__];\
                        NSLog(@"%@", retainString);}
#else
#define NSLog(fmt, ...) do{}while(0)
#endif

#undef NSAssert
#define NSAssert(condition, desc, ...)  if(desc) {NSCAssert(condition, desc, ##__VA_ARGS__);} else{NSCAssert(condition, @"%s:%d", __func__, __LINE__);}   //debug模式下使用系统的NSAssert会在block中引起循环引用

#define NSAssertRet(ret, condition, desc, ...)  \
NSAssert(condition, desc, ##__VA_ARGS__); \
if(!(condition)) { \
    NSLogToFile(@"Bug: assert!!! %s:%d", __func__, __LINE__); \
    return ret; \
}


#define NSLogToFile(fmt, ...) {\
                NSString *retainString = [NSString stringWithFormat:(@"[%@:%d]" fmt), [[[NSString stringWithUTF8String:__FILE__] pathComponents] lastObject], __LINE__, ##__VA_ARGS__];}
    //[LogServer logToFileWithFormat:@"%@", retainString];\ //存到本地的日志
    //[LogServer logWithFormat:@"%@", retainString];}发送给服务器的日志


#define MOAErrorMake(reason, num) [NSError errorWithDomain:@"customError" code:num userInfo:@{@"info":(reason), @"ext":[NSString stringWithFormat:@"[%@:%d] %@", [[[NSString stringWithUTF8String:__FILE__] pathComponents] lastObject], __LINE__, [EntrysOperateHelper stringFromDate:nil andFormat:nil]]}]
#define MOAErrorMakeOther(reason, other, num) [NSError errorWithDomain:@"customError" code:num userInfo:@{@"info":(reason), @"other":(other?other:[NSNull null]), @"ext":[NSString stringWithFormat:@"[%@:%d] %@", [[[NSString stringWithUTF8String:__FILE__] pathComponents] lastObject], __LINE__, [EntrysOperateHelper stringFromDate:nil andFormat:nil]]}]


#endif /* VCDefine_h */
