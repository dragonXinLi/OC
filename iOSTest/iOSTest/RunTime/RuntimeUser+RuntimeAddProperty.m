//
//  RuntimeUser+RuntimeAddProperty.m
//  iOSTest
//
//  Created by LL on 2018/8/27.
//  Copyright © 2018年 lilong. All rights reserved.
//

#import "RuntimeUser+RuntimeAddProperty.h"
#import <objc/runtime.h>
@implementation RuntimeUser (RuntimeAddProperty)

char nameKey;//利用char节省内存

-(void)setName:(NSString *)name
{
    //将某个值跟某个对象关联起来，将某个值存储到某个对象中
    objc_setAssociatedObject(self, &nameKey, name, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)name
{
    return objc_getAssociatedObject(self, &nameKey);
}

@end
