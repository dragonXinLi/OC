//
//  MOAMemoryCache.h
//  iOSTest
//
//  Created by lilong on 2018/7/10.
//  Copyright © 2018年 lilong. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MOAMemoryCache : NSObject

@property(copy , nonatomic ) NSString * name;
@property(readonly) NSUInteger totalCount;



@end

NS_ASSUME_NONNULL_END
