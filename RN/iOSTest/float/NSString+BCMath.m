//
//  NSString+BCMath.m
//  iOSTest
//
//  Created by lilong on 2018/6/28.
//  Copyright © 2018年 LL. All rights reserved.
//

#import "NSString+BCMath.h"

@implementation NSString (BCMath)

- (NSDecimalNumber *)decimalWrapper
{
    return [NSDecimalNumber decimalNumberWithString:self];
}

- (NSDecimal)decimalStruct
{
    return self.decimalWrapper.decimalValue;
}

// >
- (CompareBlock)g
{
    return ^BOOL (NSString *other)
    {
        return [self.decimalWrapper compare:other.decimalWrapper] == NSOrderedDescending;
    };
}

// >=
- (CompareBlock)ge
{
    return ^BOOL (NSString *other)
    {
        NSComparisonResult rel = [self.decimalWrapper compare:other.decimalWrapper];
        return rel == NSOrderedDescending || rel == NSOrderedSame;
    };
}

// <
- (CompareBlock)l
{
    return ^BOOL (NSString *other)
    {
        return [self.decimalWrapper compare:other.decimalWrapper] == NSOrderedAscending;
    };
}

// <=
- (CompareBlock)le
{
    return  ^BOOL (NSString *other)
    {
        NSComparisonResult rel = [self.decimalWrapper compare:other.decimalWrapper];
        return rel == NSOrderedAscending || rel == NSOrderedSame;
    };
}

// ==
- (CompareBlock)e
{
    return ^BOOL (NSString *other)
    {
        return [self.decimalWrapper compare:other.decimalWrapper] == NSOrderedSame;
    };
}

// !=
- (CompareBlock)ne
{
    return ^BOOL (NSString *other)
    {
        return [self.decimalWrapper compare:other.decimalWrapper] != NSOrderedSame;
    };
}

// +
- (CalBlock)add
{
    return ^NSString * (NSString *other)
    {
        NSString *rel = nil;
        @try
        {
            rel = [self.decimalWrapper decimalNumberByAdding:other.decimalWrapper].stringValue;
            return rel;
        }@catch (NSException *exception)
        {
            return nil;
        }
    };
}

// -
- (CalBlock)sub
{
    return ^NSString * (NSString *other)
    {
        NSString *rel = nil;
        @try
        {
            rel = [self.decimalWrapper decimalNumberBySubtracting:other.decimalWrapper].stringValue;
            return rel;
        }@catch (NSException *exception)
        {
            return nil;
        }
    };
}

// *
- (CalBlock)mul
{
    return ^NSString * (NSString *other)
    {
        @try
        {
            return [self.decimalWrapper decimalNumberByMultiplyingBy:other.decimalWrapper].stringValue;
        }@catch (NSException *exception)
        {
            return nil;
        }
    };
}

// /
- (CalBlock)div
{
    return ^NSString * (NSString *other)
    {
      @try
        {
            return [self.decimalWrapper decimalNumberByDividingBy:other.decimalWrapper].stringValue;
        }@catch (NSException *exception)
        {
            return nil;
        }
    };
}

//在运算过程中保留指定位数，内部自己捕获异常
// +
- (CalRoundBlock)add_r
{
    return ^NSString * (NSString *other , NSInteger scale)
    {
        NSString *rel = nil;
        @try
        {
            rel = [self.decimalWrapper decimalNumberByAdding:other.decimalWrapper].stringValue;
            return rel.roundToPlain(scale);
        }@catch (NSException *exception)
        {
            return nil;
        }
    };
}

// -
- (CalRoundBlock)sub_r
{
    return ^NSString * (NSString *other , NSInteger scale)
    {
        NSString *rel = nil;
        @try
        {
            rel = [self.decimalWrapper decimalNumberBySubtracting:other.decimalWrapper].stringValue;
            return rel.roundToPlain(scale);
        }@catch (NSException *exception)
        {
            return nil;
        }
    };
}

// *
- (CalRoundBlock)mul_r
{
    return ^NSString * (NSString *other , NSInteger scale)
    {
        @try
        {
            return [self.decimalWrapper decimalNumberByMultiplyingBy:other.decimalWrapper].stringValue.roundToPlain(scale);
        }@catch (NSException *exception)
        {
            return nil;
        }
    };
}

// /
- (CalRoundBlock)div_r
{
    return ^NSString * (NSString *other , NSInteger scale)
    {
        @try
        {
            return [self.decimalWrapper decimalNumberByDividingBy:other.decimalWrapper].stringValue.roundToPlain(scale);
        }@catch (NSException *exception)
        {
            return nil;
        }
    };
}

//如果运算出现异常，将异常直接抛出
// +
- (CalBlock)add_exc
{
    return ^NSString * (NSString *other)
    {
        NSString *rel = nil;
        @try
        {
            rel = [self.decimalWrapper decimalNumberByAdding:other.decimalWrapper].stringValue;
            return rel;
        }@catch (NSException *exception)
        {
            @throw exception;
        }
    };
}

// -
- (CalBlock)sub_exc
{
    return ^NSString * (NSString *other)
    {
        NSString *rel = nil;
        @try
        {
            rel = [self.decimalWrapper decimalNumberBySubtracting:other.decimalWrapper].stringValue;
            return rel;
        }@catch (NSException *exception)
        {
            @throw  exception;
        }
    };
}

// *
- (CalBlock)mul_exc
{
    return ^NSString * (NSString *other)
    {
        @try
        {
            return [self.decimalWrapper decimalNumberByMultiplyingBy:other.decimalWrapper].stringValue;
        }@catch (NSException *exception)
        {
            @throw exception;
        }
    };
}

// /
- (CalBlock)div_exc
{
    return ^NSString * (NSString *other)
    {
        @try
        {
            return [self.decimalWrapper decimalNumberByDividingBy:other.decimalWrapper].stringValue;
        }@catch (NSException *exception)
        {
            @throw exception;
        }
    };
}

//四舍五入
- (RoundBlock)roundToPlain
{
    return ^NSString * (NSInteger scale)
    {
        NSDecimal result;
        NSDecimal origin = self.decimalStruct;
        NSDecimalRound(&result, &origin, scale, NSRoundPlain);
        return [NSDecimalNumber decimalNumberWithDecimal:result].stringValue;
    };
}

//四舍六入五去偶
- (RoundBlock)roundToBankers
{
    return ^NSString * (NSInteger scale)
    {
        NSDecimal result;
        NSDecimal orgin = self.decimalStruct;
        NSDecimalRound(&result, &orgin, scale, NSRoundBankers);
        return [NSDecimalNumber decimalNumberWithDecimal:result].stringValue;
    };
}

//向上取整
- (RoundBlock)roundToUp
{
    return ^NSString * (NSInteger scale)
    {
        NSDecimal result;
        NSDecimal origin = self.decimalStruct;
        NSDecimalRound(&result, &origin, scale, NSRoundUp);
        return [NSDecimalNumber decimalNumberWithDecimal:result].stringValue;
    };
}

//向下取整
- (RoundBlock)roundToDowm
{
    return ^NSString * (NSInteger scale)
    {
        NSDecimal result;
        NSDecimal origin = self.decimalStruct;
        NSDecimalRound(&result, &origin, scale, NSRoundDown);
        return [NSDecimalNumber decimalNumberWithDecimal:result].stringValue;
    };
}


@end
