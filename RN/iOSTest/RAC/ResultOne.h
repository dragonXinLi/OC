//
//  ResultOne.h
//  RN
//
//  Created by sangfor on 2017/7/20.
//  Copyright © 2017年 LL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResultOne : NSObject

- (void)eat1;
- (void)run1;

- (ResultOne *)eat2;
- (ResultOne *)run2;

- (ResultOne *)eat3:(NSString *)food;
- (ResultOne *)run3:(float)metter;

- (void(^)())eat4;
- (void(^)())run4;

- (ResultOne *(^)())eat5;
- (ResultOne *(^)())run5;

- (ResultOne *(^)(NSString *food))eat6;
- (ResultOne *(^)(float metter))run6;

- (void)eat7:(void(^)())block;
- (void)run7:(void(^)())block;

- (ResultOne *)eat8:(void(^)())block;
- (ResultOne *)run8:(void(^)())block;

- (ResultOne *)eat9:(void(^)(NSString *food))block;
- (ResultOne *)run9:(void(^)(float metter))block;

- (void (^)(NSString *food , void (^)()))eat10;
- (void (^)(float metter , void (^)()))run10;

- (ResultOne* (^)(NSString *food , void (^)(NSString *food)))eat11;
- (ResultOne* (^)(float metter , void (^)(float metter)))run11;

@end
