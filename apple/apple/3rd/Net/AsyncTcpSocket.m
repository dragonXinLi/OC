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



@end
