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
        NSArray *components = [v4 componentsSeparatedByString:@"."];
        int v0 = [components[0] intValue],v1 = [components[1] intValue] , v2 = [components[2] intValue] , v3 = [components[3] intValue];
        result = [NSString stringWithFormat:@"64:ff9b::%02x%02x:%02x%02x",v0, v1, v2, v3];
    }
    
    if(flag)
    {
        result = [NSString stringWithFormat:@"[%@]",result];
    }
    
    return result;
}


+ (NSString *)getip:(NSString *)ip port:(NSInteger)port
{
    if([AsyncTcpSocket isip:ip] == NO
       || [AsyncTcpSocket allowV4]) {
        return ip;
    }
    
    return [AsyncTcpSocket v42v6:ip flag:NO];
}


- (void)connectToHost:(NSString *)host
               onPort:(uint16_t)port
          withTimeout:(NSTimeInterval)timeout
{
    NSAssert(self.ip == nil, nil);
    NSAssert(host != nil, nil);
    self.ip = host;
    self.port = port;
    dispatch_block_t block = ^{//@autoreleasepool {
        NSAssert(port > 0, nil);
        CFReadStreamRef readStream = NULL;
        CFWriteStreamRef writeStream = NULL;
        
        _host = [AsyncTcpSocket getip:_ip port:_port];
        
        if([self.ip isEqualToString:_host] == NO) {
            NSLogToFile(@"Info: %@ -> %@", self.ip, _host)
        }
        
        CFStreamCreatePairWithSocketToHost(kCFAllocatorDefault, (__bridge CFStringRef)_host, self.port, &readStream, &writeStream);
        
        if(self.useSSL) {
            NSDictionary *settings = @{(__bridge NSString *)kCFStreamSSLValidatesCertificateChain: @NO,
                                       (__bridge NSString *)kCFStreamSSLIsServer: @NO,
                                       (__bridge NSString *)kCFStreamSSLPeerName: [NSNull null],
                                       };
            
            CFReadStreamSetProperty(readStream, kCFStreamPropertySSLSettings, (__bridge CFTypeRef)settings);
            CFWriteStreamSetProperty(writeStream, kCFStreamPropertySSLSettings, (__bridge CFTypeRef)(settings));
        }
        
        self.inputStream = (__bridge_transfer NSInputStream *)readStream;
        self.outputStream = (__bridge_transfer NSOutputStream *)writeStream;
        
        [self.inputStream setDelegate:self];
        [self.outputStream setDelegate:self];
        
        [self.inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [self.outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        
        [self.inputStream open];
        [self.outputStream open];
        
        if (timeout > 0) {
            NSTimer *connectTimer = [NSTimer scheduledTimerWithTimeInterval:timeout target:self selector:@selector(timerFireMethod:) userInfo:kConnectTimerName repeats:NO];
            self.timers[kConnectTimerName] = connectTimer;
        }
        //}
    };
    [self.socketDealThread tryAsyncPerformBlock:block];
    //	if ([NSThread isMainThread]) {
    //		block();
    //	}else{
    //		dispatch_async(dispatch_get_main_queue(), block);
    //	}
    
}


#pragma mark - timer
- (void)timerFireMethod:(NSTimer *)timer
{
    NSAssert(timer.isValid, nil);
    id userInfo = timer.userInfo;
    if(userInfo && self.timers[userInfo])
    {
        if(timer.isValid)
        {
            [timer invalidate];
        }
        
        if([userInfo isKindOfClass:[NSString class]])
        {
            if([userInfo isEqualToString:kConnectTimerName])
            {
                NSLog(@"connect timeout");
                [self closeWithError:MOAErrorMakeOther(kResultNetFailed, @"Connect timeout", 0)];
            }
        }else if([userInfo isKindOfClass:[NSNumber class]])
        {
            dispatch_block_t block = ^{
                [self.delegate socket:self timeoutForTag:[userInfo integerValue] disconnect:NO];
            };
            [self.delegateDealThread trySyncPerformBlock:block];
        }
        [self.timers removeObjectForKey:userInfo];
    }
}


#pragma mark -  **************** api

- (BOOL)isConnected
{
    return self.state == eConnectStateConnected;
}


- (void)asyncDisconnect
{
    dispatch_block_t block = ^{
        [self closeWithError:nil];
    };
    
    [self.socketDealThread trySyncPerformBlock:block];
}


#pragma mark -  **************** 
- (void)closeWithError:(NSError *)error
{
    NSAssert([self.socketDealThread isCurrentThread], nil);
    if(error)
    {
        NSLogToFile(@"Close with Reason:<%p>%@ , %@",self,error,self.delegate);
    }
    
    if(self.state == eConnectStateDisconnect)
    {
        return;
    }
    
    self.state = eConnectStateDisconnect;
    NSArray *keys = [self.timers allKeys];
    for (id key in keys) {
        NSTimer *timer = self.timers[key];
        [self.timers removeObjectForKey:key];
        id userInfo = nil;
        if(timer.isValid)
        {
            userInfo = timer.userInfo;
            [timer invalidate];
        }
        
        if([key isKindOfClass:[NSNumber class]])
        {
            NSAssert(userInfo == nil || [userInfo isEqual:key], nil);
            dispatch_block_t block = ^{
                [self.delegate socket:self timeoutForTag:[key integerValue] disconnect:YES];
            };
            [self.delegateDealThread trySyncPerformBlock:block];
        }
    }
    
    dispatch_block_t block = ^{
        [self.delegate socketDidDisconnect:self withError:error];
    };
    [self.delegateDealThread trySyncPerformBlock:block];
    
    self.delegate = nil;
}


- (void)saveRecvData:(char *)bytes andLength:(NSUInteger)length new:(BOOL)isNew end:(BOOL)end
{
    NSAssert([self.socketDealThread isCurrentThread], @"should be socket queue");
    if(isNew)
    {
        NSAssert(self.recvBuff == nil, nil);
        self.recvBuff = [NSMutableData dataWithBytes:bytes length:length];
    }else
    {
        NSAssert(self.recvBuff != nil, nil);
        [self.recvBuff appendBytes:bytes length:length];
    }
    
    if(end)
    {
        NSData *data = [NSData dataWithData:self.recvBuff];
        self.recvBuff = nil;
        dispatch_block_t block = ^{
            [self.delegate socket:self didReadData:data];
        };
        
        [self.delegateDealThread trySyncPerformBlock:block];
    }
}


- (void)dealRecvData
{
    NSAssert([self.socketDealThread isCurrentThread], @"should be socket queue");
    CFReadStreamRef cfRead = (__bridge CFReadStreamRef)self.inputStream;
    char buff[kRecvBuffLength];
    NSInteger recvIndex = 0;
    for (;;)
    {
        CFIndex count = CFReadStreamRead(cfRead, (UInt8 *)buff , kRecvBuffLength);
        if(count == 0)
        {
            NSError *err = MOAErrorMakeOther(kResultNetFailed, @"remote server has close socket", 0);
            NSLogToFile(@"Tips: recv fin : %@" , err);
            [self closeWithError:err];
            break;
        }else if(count == -1)
        {
            NSError *err = [self getAnErrorWithStream:self.inputStream];
            NSLogToFile(@"Tips: recv err : %@", err);
            [self closeWithError:err];
            break;
        }else
        {
            NSAssert(count <= kRecvBuffLength, nil);
            BOOL more = CFReadStreamHasBytesAvailable(cfRead);
            [self saveRecvData:buff andLength:count new:(recvIndex == 0) end:!more];
            if(more)
            {
                recvIndex++;
                continue;
            }else
            {
                break;
            }
        }
    }
}


- (NSError *)getAnErrorWithStream:(NSStream *)aStream
{
    CFErrorRef cferr = NULL;
    if([aStream isEqual:self.inputStream])
    {
        cferr = CFReadStreamCopyError((__bridge CFReadStreamRef)self.inputStream);
    }else
    {
        cferr = CFReadStreamCopyError((__bridge CFReadStreamRef)self.outputStream);
    }
    
    NSError *err = nil;
    if(cferr != NULL)
    {
        err = (__bridge NSError *)cferr;
        err = MOAErrorMakeOther(kResultNetFailed, err, 0);
    }else
    {
        err = MOAErrorMakeOther(kResultNetFailed, @"unkown err", 0);
    }
    return err;
}


- (void)removeTimerWithTag:(NSNumber *)tag
{
    dispatch_block_t block = ^{
        NSTimer *timer = self.timers[tag];
        if(timer)
        {
            [self.timers removeObjectForKey:tag];
            if(timer.isValid)
            {
                [timer invalidate];
            }
        }
    };
    [self.socketDealThread trySyncPerformBlock:block];
}


- (void)sendData:(NSData *)data withTimeout:(NSTimeInterval)timeout andTag:(NSInteger)tag
{
    dispatch_block_t block = ^{
        NSAssert([self.socketDealThread isCurrentThread], @"should be socket queue");
        if(self.state != eConnectStateConnected)
        {
            dispatch_block_t block = ^{
                [self.delegate socket:self timeoutForTag:tag disconnect:YES];
            };
            [self.delegateDealThread trySyncPerformBlock:block];
            return ;
        }
        if(timeout >0)
        {
            NSAssert(self.timers[@(tag)] == nil, @"must not Repeat");
            NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:timeout target:self selector:@selector(timerFireMethod:) userInfo:@(tag) repeats:NO];
            self.timers[@(tag)] = timer;
        }
        [self.toSendData appendData:data];
        [self dealWriteData];
    };
    [self.socketDealThread trySyncPerformBlock:block];
}


- (void)dealWriteData
{
    NSAssert([self.socketDealThread isCurrentThread], @"should be socket queue");
    CFWriteStreamRef cfWrite = (__bridge CFWriteStreamRef)self.outputStream;
    for(;;)
    {
        if(self.toSendData.length > 0 && CFWriteStreamCanAcceptBytes(cfWrite))
        {
            CFIndex writeLength = CFWriteStreamWrite(cfWrite, self.toSendData.bytes, self.toSendData.length);
            if(writeLength == -1)
            {
                NSError *err = [self getAnErrorWithStream:self.outputStream];
                NSLog(@"Write error : %@" , err);
                [self closeWithError:err];
                return;
            }else if(writeLength == 0)
            {
                NSLog(@"Write == 0");
            }else
            {
                [self.toSendData replaceBytesInRange:NSMakeRange(0, writeLength) withBytes:NULL length:0];
                continue;
            }
        }else
        {
            break;
        }
    }
}


- (void)setState:(eConnectState)state
{
    NSAssert([self.socketDealThread isCurrentThread], @"should be socket queue");
    if (_state != state) {
        _state =  state;
        
        switch (_state) {
            case eConnectStateConnected:
            {
                NSTimer *connectTimer = self.timers[kConnectTimerName];
                if (connectTimer) {
                    [self.timers removeObjectForKey:kConnectTimerName];
                    @try {
                        if (connectTimer.isValid) {
                            [connectTimer invalidate];
                        }
                    }
                    @catch (NSException *exception) {
                        NSLogToFile(@"Warn: NSTimer crash:%@", exception);
                    }
                    @finally {
                        
                    }
                }
                dispatch_block_t block = ^{
                    [self.delegate socket:self didConnectToHost:self.ip port:self.port];
                };
                [self.delegateDealThread trySyncPerformBlock:block];
                //				if (dispatch_get_specific(self.IsOnDelegateQueue)) {
                //					block();
                //				}else{
                //					dispatch_sync(self.delegateQueue, block);
                //				}
                
                break;
            }
            case eConnectStateDisconnect:
            {
                NSTimer *connectTimer = self.timers[kConnectTimerName];
                if (connectTimer) {
                    [self.timers removeObjectForKey:kConnectTimerName];
                    @try {
                        if (connectTimer.isValid) {
                            [connectTimer invalidate];
                        }
                    }
                    @catch (NSException *exception) {
                        NSLogToFile(@"Warn: NSTimer crash:%@", exception);
                    }
                    @finally {
                        
                    }
                }
                break;
            }
            default:
                break;
        }
    }

}


#pragma mark NSStreamDelegate
-(void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode
{
    id strongRef = self;
    NSAssert([self.socketDealThread isCurrentThread], @"should be socket queue");
    @try {
        NSString *event;
        switch (eventCode) {
            case NSStreamEventNone:
                event = @"NSStreamEventNone";
                break;
            case NSStreamEventOpenCompleted:
                if ([aStream isEqual:self.inputStream]) {
                    self.readOpend = YES;
                    event = @"inputStream open";
                }else if ([aStream isEqual:self.outputStream]) {
                    self.writeOpend = YES;
                    event = @"outputStream open";
                }
                if (self.readOpend && self.writeOpend) {
                    self.state = eConnectStateConnected;
                    event = @"NSStreamEventOpenCompleted";
                }
                break;
            case NSStreamEventHasBytesAvailable:
            {
                event = @"NSStreamEventHasBytesAvailable";
                [self dealRecvData];
                break;
            }
            case NSStreamEventHasSpaceAvailable:
                event = @"NSStreamEventHasSpaceAvailable";
                [self dealWriteData];
                break;
            case NSStreamEventErrorOccurred:
            {
                event = @"NSStreamEventErrorOccurred";
                [self closeWithError:[self getAnErrorWithStream:aStream]];
                NSLogToFile(@"NSStreamEventErrorOccurred");
                break;
            }
            case NSStreamEventEndEncountered:
                [self closeWithError:nil];
                event = @"NSStreamEventEndEncountered";
                NSLogToFile(@"NSStreamEventEndEncountered");
                break;
            default:
                break;
        }
    }
    @catch (NSException *exception) {
        NSLogToFile(@"Warn:Catch exception:%@", exception);
    }
    @finally {
        
    }
    [strongRef description];
}
@end
