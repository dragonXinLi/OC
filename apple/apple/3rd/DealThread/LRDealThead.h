//
//  LRDealThead.h
//  apple
//
//  Created by sangfor on 17/5/8.
//  Copyright © 2017年 com.sangfor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LRDealThead : NSObject

@property (nonatomic , strong) NSThread *thread;
@property (nonatomic , assign) BOOL toExit;

- (id)initWithName:(NSString *)name;
- (void)start;
- (BOOL)isStarted;
- (void)exit;

- (void)performBlock:(void (^)())block;
- (void)performBlockAndWait:(void (^)())block;

- (void)tryAsyncPerformBlock:(void (^)())block;
- (void)trySyncPerformBlock:(void (^)())block;
- (BOOL)isCurrentThread;

@end
