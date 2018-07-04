//
//  blockTest.h
//  RN
//
//  Created by sangfor on 2018/4/10.
//  Copyright © 2018年 LL. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^block)(NSString *name);

@interface blockTest : NSObject

@property (nonatomic , copy) block test;


@end
