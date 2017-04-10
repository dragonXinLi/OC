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




#endif /* VCDefine_h */
