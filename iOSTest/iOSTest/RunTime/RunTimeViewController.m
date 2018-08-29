//
//  RunTimeViewController.m
//  iOSTest
//
//  Created by lilong on 2018/8/24.
//  Copyright © 2018年 lilong. All rights reserved.
//

#import "RunTimeViewController.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "RuntimePerson.h"
#import "NSObject+RuntimeLog.h"
#import "RuntimeStatus.h"
#import "RunTimeSwizzlePerson.h"
#import "RuntimeUser.h"
@interface RunTimeViewController ()

@end

@implementation RunTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (0) {
        [self addClass];
    }
    
    if (0) {
        [self getClassIvar];
    }
    
    if (0) {
        [self changeIvarValue];
    }
    
    if (0) {
        BOOL has = [self hasProperty:@"_name"];
    }
    
    if (0) {
        [self archiverObject];
    }
    
    if (0) {
        [self dictToModel];
    }
    
    if (0) {
        [self exchangeImp];
    }
    
    if (0) {
        [self addMethod];
    }
    
    if (1) {
        [self propertyChange];
    }
}

- (void)addClass
{
    //创建一个类(size_t extraBytes该参数通常指定为0，该参数是分配非类和元类对象尾部的索引ivars的字节数)
    Class clazz = objc_allocateClassPair([NSObject class], "GoodPerson", 0);
    
    //添加ivar
    //@encode(aType):返回该类型的c字符串
    class_addIvar(clazz, "_name", sizeof(NSString *), log2(sizeof(NSString *)), @encode(NSString *));
    class_addIvar(clazz, "_age", sizeof(NSInteger), log2(sizeof(NSInteger)), @encode(NSString *));
    //    class_addIvar(clazz, "_age", sizeof(NSNumber *), log2(sizeof(NSNumber *)), @encode(NSNumber *));值一样
    
    //注册该类
    objc_registerClassPair(clazz);
    
    //创建实例对象
    id object = [[clazz alloc] init];
    
    //设置ivar
    [object setValue:@"Tracy" forKey:@"name"];
    
    Ivar ageIvar = class_getInstanceVariable(clazz, "_age");
    object_setIvar(object, ageIvar, @18);
    
    //打印对象的类和内存地址
    NSLog(@"%@",object);
    //打印对象的属性值
    NSLog(@"name = %@ , age = %@",[object valueForKey:@"name"],object_getIvar(object, ageIvar));
    
    //当类或者它的子类的实例还存在，则不能调用objc_disposeClassPair方法
    object = nil;
    //销毁类
    objc_disposeClassPair(clazz);
    
    //    2018-08-26 22:48:06.046046+0800 iOSTest[53090:4108346] <GoodPerson: 0x6040004394c0>
    //    2018-08-26 22:48:06.046331+0800 iOSTest[53090:4108346] name = Tracy , age = 18
}

- (void)getClassIvar
{
    RuntimePerson *p = [[RuntimePerson alloc] init];
    [p setValue:@"Kobe" forKey:@"name"];
    [p setValue:@18 forKey:@"name"];
    p.weight = 110.f;
    
    //打印所有的ivars
    unsigned int ivarCount = 0;
    //用一个字段装ivarName和value(_name,_age,_weight)
    NSMutableDictionary *ivarDict = [NSMutableDictionary dictionary];
    Ivar *ivarList = class_copyIvarList([p class], &ivarCount);
    for (int i = 0; i < ivarCount; i++) {
        //RuntimePerson的私有成员变量取到直接是privateName,属性是_name
        NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(ivarList[i])];
        id value = [p valueForKey:ivarName];
        
        if (value) {
            ivarDict[ivarName] = value;
        }else
        {
            ivarDict[ivarName] = @"值为nil";
        }
    }
    //打印ivar
    for (NSString *ivarName in ivarDict.allKeys) {
        NSLog(@"ivarName:%@ , ivarValue:%@",ivarName,ivarDict[ivarName]);
    }
    
    //打印所有的properties
    unsigned int propertyCount = 0;
    //用字典装propertyName和value(name,age,weight)
    NSMutableDictionary *propertyDict = @{}.mutableCopy;
    objc_property_t *propertyList = class_copyPropertyList([p class], &propertyCount);
    for (int i = 0; i < propertyCount; i++) {
        //class_copyPropertyList只能取到属性(.h和.m)，取不到成员变量
        NSString *propertyName = [NSString stringWithUTF8String:property_getName(propertyList[i])];
        id value = [p valueForKey:propertyName];
        
        if (value) {
            propertyDict[propertyName] = value;
        }else
        {
            propertyDict[propertyName] = @"值为nil";
        }
    }
    //打印所有的properties
    for (NSString *propertyName in propertyDict.allKeys) {
        NSLog(@"propertyName:%@,propertyValue:%@",propertyName,propertyDict[propertyName]);
    }
    //打印所有的methods
    unsigned int methodCount = 0;
    NSMutableDictionary *methodDict = @{}.mutableCopy;
    Method *methodList = class_copyMethodList([p class], &methodCount);
    for (int i = 0; i < methodCount; i++) {
        SEL methodSEL = method_getName(methodList[i]);
        NSString *methodName = [NSString stringWithUTF8String:sel_getName(methodSEL)];
        
        unsigned int argumentNums = method_getNumberOfArguments(methodList[i]);
        methodDict[methodName] = @(argumentNums -2 );
    }
    
    for (NSString *methodName in methodDict.allKeys) {
        NSLog(@"methodName:%@,argumentCount:%@",methodName,methodDict[methodName]);
    }
//    2018-08-26 23:39:35.018672+0800 iOSTest[55036:4270111] ivarName:_name , ivarValue:18
//    2018-08-26 23:39:35.018836+0800 iOSTest[55036:4270111] ivarName:_age , ivarValue:值为nil
//    2018-08-26 23:39:35.018993+0800 iOSTest[55036:4270111] ivarName:_weight , ivarValue:110
//    2018-08-26 23:39:35.019258+0800 iOSTest[55036:4270111] propertyName:name,propertyValue:18
//    2018-08-26 23:39:35.019634+0800 iOSTest[55036:4270111] propertyName:age,propertyValue:值为nil
//    2018-08-26 23:39:35.019775+0800 iOSTest[55036:4270111] propertyName:weight,propertyValue:110
//    2018-08-26 23:39:35.019924+0800 iOSTest[55036:4270111] methodName:weight,argumentCount:0
//    2018-08-26 23:39:35.020124+0800 iOSTest[55036:4270111] methodName:setName:,argumentCount:1
//    2018-08-26 23:39:35.020268+0800 iOSTest[55036:4270111] methodName:setWeight:,argumentCount:1
//    2018-08-26 23:39:35.020553+0800 iOSTest[55036:4270111] methodName:age,argumentCount:0
//    2018-08-26 23:39:35.020936+0800 iOSTest[55036:4270111] methodName:setAge:,argumentCount:1
//    2018-08-26 23:39:35.021185+0800 iOSTest[55036:4270111] methodName:.cxx_destruct,argumentCount:0
//    2018-08-26 23:39:35.021485+0800 iOSTest[55036:4270111] methodName:name,argumentCount:0

}

- (void)changeIvarValue
{
    RuntimePerson *p = [[RuntimePerson alloc] init];
    [p setValue:@"Kobe" forKey:@"name"];
    [p setValue:@18 forKey:@"name"];
    p.weight = 110.f;
    
    unsigned int count = 0;
    //动态获取person类中的所有属性（当然包括私有）
    Ivar *ivarList = class_copyIvarList([p class], &count);
    //遍历成员变量找到对应的_age字段
    for (int i = 0 ; i < count; i++) {
        Ivar var = ivarList[i];
        const char *varName = ivar_getName(var);
        NSString *name = [NSString stringWithUTF8String:varName];
        if ([name isEqualToString:@"_age"]) {
            //修改对应的字段值为20
            object_setIvar(p, var, @(20));
            break;
        }
    }
    
    NSLog(@"person's age is %@",p.age);
}

//判断类中是否有该成员变量（_name）
- (BOOL )hasProperty:(NSString *)propertyName
{
    BOOL flag = NO;
    
    unsigned int count = 0;
    Ivar *ivarList = class_copyIvarList([RuntimePerson class], &count);
    for (int i = 0 ; i < count; i++) {
        NSString *orgPropertyName = [NSString stringWithUTF8String:ivar_getName(ivarList[i])];
        if ([orgPropertyName isEqualToString:propertyName]) {
            flag = YES;
            break;
        }
    }
    return flag;
}

- (void)archiverObject
{
    RuntimePerson *p = [[RuntimePerson alloc] init];
    [p setValue:@"Kobe" forKey:@"name"];
    [p setValue:@18 forKey:@"age"];
    p.weight = 110.f;
    
    NSString *filePath = [NSHomeDirectory() stringByAppendingString:@"person.plist"];
    BOOL success = [NSKeyedArchiver archiveRootObject:p toFile:filePath];
    
    //外面取出来是CGFloat weight类型
    RuntimePerson *p2 = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    NSAssert(1, nil);
}

- (void)dictToModel
{
//    [NSObject resolveDict:@{@"name":@"ll",
//                                          @"age":@(26),
//                                          @"weight":@(75.5)
//                                          }];
    
    NSDictionary *dict = @{
                          @"reposts_count":@(20),
                          @"pic_urls":@[@{@"name":@"ll",@"age":@(19)},@{@"name":@"ll2",@"age":@(20)}],
                           @"user":@{@"name":@"ll",@"age":@(18)}
                          };
    [RuntimeStatus modelWithDict:dict];
}

- (void)exchangeImp
{
//    RunTimeSwizzlePerson * p = [[RunTimeSwizzlePerson alloc] init];
    [RunTimeSwizzlePerson run];
    [RunTimeSwizzlePerson study];
}

- (void)addMethod
{
    RuntimeUser *u = [[RuntimeUser alloc] init];
    //默认RuntimeUser没有实现eat方法，可以通过performSelector调用，但是会报错
    //动态添加方法就不会报错
    [u performSelector:@selector(eat)];
}

- (void)propertyChange
{
    RuntimePerson *p = [[RuntimePerson alloc] init];
    p.age3 = @(15);
    NSLog(@"%@",p.age3);
    NSNumber *value = [p valueForKey:@"age3"];
    [p  testAge3Value];
    NSAssert(1, nil);
    
    //属性被readonly修饰，不能在外界赋值(setter)
//    p.age4 = @(4);
//    [p setValue:@(4) forKey:@"age4"];crash,找不到setValue:forUndefinedKey:
    NSLog(@"age4:%@",p.age4);
}
@end
