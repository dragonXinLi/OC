//
//  LRDealThead.m
//  apple
//
//  Created by sangfor on 17/5/8.
//  Copyright © 2017年 com.sangfor. All rights reserved.
//

#import "LRDealThead.h"

@interface LRDealThead()

@property (nonatomic , strong) NSTimer *timer;
@property (nonatomic , assign) BOOL started;
@property (nonatomic , strong) NSString  *name;

@end

@implementation LRDealThead

- (id)initWithName:(NSString *)name
{
    self = [super init];
    if(self != nil)
    {
        self.thread = [[NSThread alloc] initWithTarget:self selector:@selector(runloop:) object:nil];
        
        self.name = name;
    }
    return self;
}


- (void)start
{
    if(!self.started)
    {
        [self.thread start];
    }
}


- (BOOL)isStarted
{
    return self.started;
}


- (void)exit
{
    if(self.isStarted)
    {
        self.toExit = YES;
        [self.timer invalidate];
        [self performBlock:nil];
    }
}


- (void)runloop:(NSCondition *)readyLock
{
    [[NSThread currentThread] setName:self.name];
    self.started = YES;
    @autoreleasepool {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:100 target:self selector:@selector(beginCount) userInfo:nil repeats:YES];
        
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
        while (! self.toExit) {
            [self testThread:@4];
            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        }
    }
    NSLog(@"Info: Deal Thread is stoped:%@", self.thread.name);
    self.started = NO;
}


- (void)beginCount
{
    [self testThread:@5];
}


- (void)testThread:(NSNumber *)flag
{
    
}


- (void)tryAsyncPerformBlock:(void (^)())block
{
    if([[NSThread currentThread] isEqual:self.thread])
    {
        block();
    }else
    {
        [self performBlock:block];
    }
}


- (void)trySyncPerformBlock:(void (^)())block
{
    if([[NSThread currentThread] isEqual:self.thread])
    {
        block();
    }else
    {
        [self performBlock:block];
    }
}


- (BOOL)isCurrentThread
{
    return [[NSThread currentThread] isEqual:self.thread];
}


- (void)performBlock:(void (^)())block
{
    [self performSelector:@selector(runBlock:) onThread:self.thread withObject:block waitUntilDone:NO];
}


- (void)performBlockAndWait:(void (^)())block
{
    if([self isCurrentThread])
    {
        block();
    }else
    {
        [self performSelector:@selector(runBlock:) onThread:self.thread withObject:block waitUntilDone:YES];
    }
}


- (void)runBlock:(void (^)())block
{
    if(block)
    {
        block();
    }
}


@end
