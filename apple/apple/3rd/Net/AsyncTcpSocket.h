//
//  AsyncTcpSocket.h
//  apple
//
//  Created by sangfor on 17/5/9.
//  Copyright © 2017年 com.sangfor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LRDealThead.h"

@protocol AsyncTcpSocketDelegate;

@interface AsyncTcpSocket : NSObject

@property (nonatomic , strong) NSString *ip;
@property (nonatomic , assign) NSInteger   port;
@property (nonatomic , assign) BOOL useSSL;

@property (nonatomic , strong , readonly) NSString *host;

- (id)initWithDelegate:(id <AsyncTcpSocketDelegate>)delegate delegateDealThread:(LRDealThead *)dp socketDealThread:(LRDealThead *)sq;
- (void)connectToHost:(NSString *)host onPort:(uint16_t)port withTimeout:(NSTimeInterval)timeout;
- (void)removeTimerWithTag:(NSNumber *)tag;
- (void)sendData:(NSData *)data withTimeout:(NSTimeInterval)timeout andTag:(NSInteger)tag;
- (BOOL)isConnected;
- (void)asyncDisconnect;

+ (NSString *)v42v6:(NSString *)v4 flag:(BOOL)flag;
+ (NSString *)getip:(NSString *)ip port:(NSInteger)port;
+ (BOOL)maybeV6;
+ (BOOL)allowV4;

@end

@protocol AsyncTcpSocketDelegate

- (void)socket:(AsyncTcpSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port;

- (void)socket:(AsyncTcpSocket *)sock didReadData:(NSData *)data;

- (void)socket:(AsyncTcpSocket *)sock timeoutForTag:(NSInteger)tag disconnect:(BOOL)disconnect;

- (void)socketDidDisconnect:(AsyncTcpSocket *)sock withError:(NSError *)err;

@end
