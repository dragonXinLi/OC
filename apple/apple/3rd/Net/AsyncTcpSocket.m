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

#define kRecvBuffLength
@interface AsyncTcpSocket()<NSStreamDelegate>



@end

@implementation AsyncTcpSocket

@end
