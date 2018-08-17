//
//  NSObject+BCMath.m
//  iOSTest
//
//  Created by lilong on 2018/6/28.
//  Copyright © 2018年 LL. All rights reserved.
//
#import "BCMath.h"

@implementation BCMath

//返回 一个没有返回值的block
//- (void (^)(NSInteger duration))sleep

//返回 一个调用者本身的block
- (BCMath * (^)(NSInteger duration))sleep
{
    return ^(NSInteger duration){
        NSLog(@"睡了%ld分钟",duration);
        return self;
    };
}

- (NSString *)description
{
    
//    return [NSString stringWithFormat:@"输出本身 %@",self];
//        return [NSString stringWithFormat:@"<%@:%p>",[self class],self];
        return [super description];
}


@end
