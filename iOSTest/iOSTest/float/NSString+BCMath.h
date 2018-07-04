//
//  NSString+BCMath.h
//  iOSTest
//
//  Created by lilong on 2018/6/28.
//  Copyright © 2018年 LL. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef BOOL (^CompareBlock)(NSString *);
typedef NSString * (^CalBlock)(NSString *);
typedef NSString * (^CalRoundBlock)(NSString * , NSInteger scale);
typedef NSString * (^RoundBlock)(NSInteger scale);

@interface NSString (BCMath)

- (NSDecimalNumber *)decimalWrapper;
- (NSDecimal)decimalStruct;


// >
- (CompareBlock)g;

// >=
- (CompareBlock)ge;

// <
- (CompareBlock)l;

// <=
- (CompareBlock)le;

// ==
- (CompareBlock)e;

// !=
- (CompareBlock)ne;

// +
- (CalBlock)add;
// -
- (CalBlock)sub;

// *
- (CalBlock)mul;

// /
- (CalBlock)div;

//在运算过程中保留指定位数，内部自己捕获异常
// +
- (CalRoundBlock)add_r;

// -
- (CalRoundBlock)sub_r;

// *
- (CalRoundBlock)mul_r;

// /
- (CalRoundBlock)div_r;

//如果运算出现异常，将异常直接抛出
// +
- (CalBlock)add_exc;

// -
- (CalBlock)sub_exc;
// *
- (CalBlock)mul_exc;

// /
- (CalBlock)div_exc;

- (RoundBlock)roundToPlain; //四舍五入
- (RoundBlock)roundToBankers; // 四舍六入五去偶
- (RoundBlock)roundToUp;    //向上取整
- (RoundBlock)roundToDowm;  //向下取整
@end
