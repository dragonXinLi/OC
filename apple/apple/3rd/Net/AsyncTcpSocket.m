//
//  AsyncTcpSocket.m
//  apple
//
//  Created by sangfor on 17/5/9.
//  Copyright © 2017年 com.sangfor. All rights reserved.
//

#import "AsyncTcpSocket.h"
#import <CFNetwork/CFNetwork.h>
#import <netdb.h>
#include <arpa/inet.h>


typedef  enum : NSUInteger{
    eConnectStateInit = 0,
    eConnectStateConnected,
    eConnectStateDisconnect,
} eConnectState;

static NSString *const AsyncTcpSocketQueueName = @"AsyncTcpSocketQueueName";
static NSString *const kConnectTimerName = @"ConnectTimerName";

#define kRecvBuffLength 1024
@interface AsyncTcpSocket()<NSStreamDelegate>
@property (nonatomic , strong) NSMutableData *toSendData;
@property (nonatomic , strong) NSMutableData *recvBuff;
@property (nonatomic , strong) NSMutableDictionary *timers;
@property (nonatomic , assign) eConnectState state;

@property (nonatomic , weak) id<AsyncTcpSocketDelegate> delegate;
@property (nonatomic , strong) LRDealThead *delegateDealThread;
@property (nonatomic , strong) LRDealThead *socketDealThread;

@property (nonatomic , strong) NSInputStream *inputStream;
@property (nonatomic , strong) NSOutputStream *outputStream;

@property (nonatomic , assign) BOOL readOpend;
@property (nonatomic , assign) BOOL writeOpend;
@property (nonatomic , assign) BOOL needReleaseDealThread;

@end

@implementation AsyncTcpSocket

- (id)initWithDelegate:(id<AsyncTcpSocketDelegate>)delegate delegateDealThread:(LRDealThead *)dq socketDealThread:(LRDealThead *)sq
{
    self = [super init];
    if(self)
    {
        self.toSendData = [NSMutableData dataWithCapacity:kRecvBuffLength];
        self.timers = [NSMutableDictionary dictionaryWithCapacity:20];
        
        self.delegate = delegate;
        
        if (sq) {
            self.socketDealThread = sq;
        }else
        {
            self.socketDealThread = [[LRDealThead alloc] initWithName:AsyncTcpSocketQueueName];
            [self.socketDealThread start];
            self.needReleaseDealThread = YES;
        }
        
        if (dq) {
            self.delegateDealThread = dq;
        }else
        {
            self.delegateDealThread = self.socketDealThread;
        }
    }
    return self;
}


-(void)dealloc
{
    NSAssert(self.socketDealThread != nil, nil);
    dispatch_block_t block = ^{
        [self.inputStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
        [self.outputStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
        
        [self.inputStream setDelegate:nil];
        [self.outputStream setDelegate:nil];
        [self.inputStream close];
        [self.outputStream close];
    };
    
    [self.socketDealThread trySyncPerformBlock:block];
    if(self.needReleaseDealThread)
    {
        [self.socketDealThread exit];
    }
}


+ (BOOL)isip:(NSString *)ip
{
    NSArray *components = [ip componentsSeparatedByString:@"."];
    if(components.count != 4)
    {
        return NO;
    }
    
    for (NSString *obj in components) {
        unsigned int value = obj.intValue;
        if(value >= 256 || obj.length > 3 || [@(value).stringValue isEqualToString:obj] == NO)
        {
            return NO;
        }
    }
    return YES;
}


+ (BOOL)maybeV6
{
    return NO;
}


+ (BOOL)allowV4
{
    if([AsyncTcpSocket maybeV6] == NO)
        return YES;
    NSString *version = [UIDevice currentDevice].systemVersion;
    if(version.floatValue >= 9.2 || [version hasPrefix:@"9.2"])
    {
        return YES;
    }
    return NO;
}


+ (NSString *)v42v6:(NSString *)v4 flag:(BOOL)flag
{
    NSString *result = nil;
    if([AsyncTcpSocket isip:v4] == NO || [AsyncTcpSocket allowV4])
    {
        struct addrinfo  hints = {0}, *ai = NULL;
        hints.ai_family =AF_UNSPEC;
        hints.ai_socktype = SOCK_STREAM;
        
        int ret = getaddrinfo(v4.UTF8String, NULL, &hints, &ai);
        NSAssertRet(nil, ret == 0 && ai->ai_addr, nil);
        
        char buf[INET6_ADDRSTRLEN] = {0};
        void *addr = NULL;
        if(ai->ai_family == AF_INET6)
        {
            struct sockaddr_in6 *v6 = (struct sockaddr_in6 *)ai->ai_addr;
            addr = &v6->sin6_addr;
        }else
        {
            struct sockaddr_in *v4 = (struct sockaddr_in *)ai->ai_addr;
            addr = &v4->sin_addr;
        }
        
        const char *s = inet_ntop(ai->ai_family, addr, buf, sizeof(buf));
        NSAssertRet(nil, s, nil);
        
        freeaddrinfo(ai);
        
        result = [NSString stringWithFormat:@"[%s]",s];
        
    }else
    {
        
    }
}

@end
