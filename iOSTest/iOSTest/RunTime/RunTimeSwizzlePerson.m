//
//  RunTimeSwizzlePerson.m
//  iOSTest
//
//  Created by lilong on 2018/8/27.
//  Copyright © 2018年 lilong. All rights reserved.
//

#import "RunTimeSwizzlePerson.h"
#import <objc/runtime.h>
@implementation RunTimeSwizzlePerson

+ (void)load
{
    //获取两个类的类方法
    Method m1 = class_getClassMethod([self class], @selector(run));
    Method m2 = class_getClassMethod([self class], @selector(study));
    //交换方法实现
    method_exchangeImplementations(m1, m2);
}

+ (void)run
{
    NSLog(@"跑");
}

+ (void)study
{
    NSLog(@"学习");
}

@end
