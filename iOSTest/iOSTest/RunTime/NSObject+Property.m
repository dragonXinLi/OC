//
//  NSObject+Property.m
//  RN
//
//  Created by sangfor on 2017/8/1.
//  Copyright © 2017年 LL. All rights reserved.
//

#import "NSObject+Property.h"
#import <objc/runtime.h>
static const char *key = "name";

@implementation NSObject (Property)

- (NSString *)name
{
    return objc_getAssociatedObject(self, key);
}


- (void)setName:(NSString *)name
{
    objc_setAssociatedObject(self, key, name, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


@end
