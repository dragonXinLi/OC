//
//  HashPerson.m
//  iOSTest
//
//  Created by LL on 2018/9/1.
//  Copyright © 2018年 lilong. All rights reserved.
//

#import "HashPerson.h"

@interface HashPerson()
{
    BOOL _immutable;
}

@end

@implementation HashPerson

- (instancetype)initWithName:(NSString *)name age:(NSString *)age immutable:(BOOL)immutable
{
    self = [super init];
    if (self) {
        _name = name;
        _age = age;
        _immutable = immutable;
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone
{
    if (_immutable) {
        return self;
    }
    id ret = [[[self class] allocWithZone:zone] initWithName:_name age:_age immutable:_immutable];
    return ret;
}

- (id)mutableCopyWithZone:(NSZone *)zone
{
    id ret = [[[self class] allocWithZone:zone] initWithName:_name age:_age immutable:_immutable];
    return ret;
}

- (BOOL)isEqual:(id)object
{
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    
    return [self isEqualToPerson:object];
}

- (BOOL)isEqualToPerson:(HashPerson *)person
{
    if (!person) {
        return NO;
    }
    
    HashPerson *obj = (HashPerson *)person;
    
    BOOL haveEqualName = (!self.name && !obj.name)||[self.name isEqualToString:obj.name];
    BOOL haveEqualAge = (!self.age && !obj.age) || [self.age isEqualToString:obj.age];
    return haveEqualName && haveEqualAge;
}

- (NSUInteger)hash
{
//    NSLog(@"hash = %ld", [super hash]);
//    return [super hash];//系统默认实现的hash方法，和对象的内存地址值相同
    NSLog(@"has = %ld",self.name.hash ^ self.age.hash);
    return self.name.hash ^ self.age.hash;
}

@end
