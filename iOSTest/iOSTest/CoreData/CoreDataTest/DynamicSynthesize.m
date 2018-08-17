//
//  DynamicSynthesize.m
//  iOSTest
//
//  Created by lilong on 2018/7/5.
//  Copyright © 2018年 lilong. All rights reserved.
//

#import "DynamicSynthesize.h"
#import <objc/runtime.h>

@interface DynamicSynthesize()
{
    NSString *_name;
}

@end

@implementation DynamicSynthesize

//1.直接注释
@dynamic name ; //iOS11下，直接访问name属性和赋值都不会崩溃，不清楚为什么
@synthesize yourName;

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}


////2.自己实现setter,getter
//- (void)setName:(NSString *)name
//{
//    _name = [name copy];
//}
//
//- (NSString *)name
//{
//    return _name;
//}


//3.消息转发在运行时添加属性的存取方法

void setName(id self , SEL _cmd , NSString *name)
{
    if (((DynamicSynthesize*)self)->_name != name) {
        ((DynamicSynthesize*)self)->_name = name;
    }
}

NSString * getName(id self , SEL _cmd)
{
    return ((DynamicSynthesize*)self)->_name;
}

+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    if (sel == @selector(setName:)) {
        class_addMethod([self class], sel, (IMP)setName, "v@:@");
        return YES;
    }else if (sel == @selector(name))
    {
        class_addMethod([self class], sel, (IMP)getName, "@@:");
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}



@end
