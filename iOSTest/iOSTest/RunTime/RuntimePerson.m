//
//  Person.m
//  iOSTest
//
//  Created by LL on 2018/8/26.
//  Copyright © 2018年 lilong. All rights reserved.
//

#import "RuntimePerson.h"
#import <objc/runtime.h>

@interface RuntimePerson()
{
    NSString *privateName2;
}

@property(strong , nonatomic ) NSString * privateName;

@end

@implementation RuntimePerson

//- (void)encodeWithCoder:(NSCoder *)aCoder
//{
//    [aCoder encodeObject:_name forKey:@"name"];
//    [aCoder encodeObject:_age forKey:@"age"];
//    [aCoder encodeDouble:_weight forKey:@"weight"];
//}
//
//- (id)initWithCoder:(NSCoder *)aDecoder
//{
//    if (self = [super init]) {
//        self.name = [aDecoder decodeObjectForKey:@"name"];
//        self.age = [aDecoder decodeObjectForKey:@"age"];
//        self.weight = [aDecoder decodeDoubleForKey:@"weight"];
//    }
//    return self;
//}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    unsigned int count = 0;
    Ivar *ivarList = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i++) {
        //取出i位置对应的成员变量
        Ivar ivar = ivarList[i];
        //查看成员变量
        const char *name = ivar_getName(ivar);
        //归档
        NSString *key = [NSString stringWithUTF8String:name];
        
        //CGFloat weight：取出来的value还是NSNumber类型
        id value = [self valueForKey:key];

        if ([value isKindOfClass:[NSObject class]]) {
            [aCoder encodeObject:value forKey:key];
        }
    }
    free(ivarList);
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        unsigned int count = 0;

        Ivar *ivarList = class_copyIvarList([self class], &count);
        for (int i = 0; i < count; i++) {
            NSString *key = [NSString stringWithUTF8String:ivar_getName(ivarList[i])];
            //解档
            id value = [aDecoder decodeObjectForKey:key];
            if (value) {
                //设置到成员变量身上
                [self setValue:value forKey:key];
            }
        }
        free(ivarList);
    }
    return self;
}


#define encodeRuntime(A) \
\
unsigned int count = 0;\
Ivar *ivarList = class_copyIvarList([A class], &count);\
for (int i = 0; i < count; i++) {\
    Ivar ivar = ivarList[i];\
    const char *name = ivar_getName(ivar);\
    NSString *key = [NSString stringWithUTF8String:name];\
    id value = [self valueForKey:key];\
    if ([value isKindOfClass:[NSObject class]]) {\
    [aCoder encodeObject:value forKey:key];\
    }\
}\
free(ivarList);

#define initCoderRuntime(A)\
\
if (self = [super init]) {\
unsigned int count = 0;\
Ivar *ivarList = class_copyIvarList([A class], &count);\
for (int i = 0; i < count; i++) {\
    NSString *key = [NSString stringWithUTF8String:ivar_getName(ivarList[i])];\
    id value = [aDecoder decodeObjectForKey:key];\
    if (value) {\
    [self setValue:value forKey:key];\
    }\
}\
free(ivarList);\
}\
return self;

//- (void)encodeWithCoder:(NSCoder *)aCoder
//{
//    encodeRuntime(RuntimePerson);
//}
//
//- (id)initWithCoder:(NSCoder *)aDecoder
//{
//    if (self = [super init]) {
//        initCoderRuntime(RuntimePerson);
//    }
//    return self;
//}


- (NSNumber *)getAge3
{
    //只是绕过了不返回_age3的值，但是_age3的值实际上还是15
    return @(1);
}

- (void)testAge3Value
{
    NSLog(@"%@",_age3);//15
}

@end
