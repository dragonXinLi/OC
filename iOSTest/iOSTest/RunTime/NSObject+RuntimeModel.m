//
//  NSObject+RuntimeModel.m
//  iOSTest
//
//  Created by lilong on 2018/8/27.
//  Copyright © 2018年 lilong. All rights reserved.
//

#import "NSObject+RuntimeModel.h"
#import <objc/runtime.h>
@implementation NSObject (RuntimeModel)

/*
 把字典中所有value给模型中属性赋值
 kvc:遍历字典中所有key,去模型中查找
 runtime:根据模型中属性名去字典中查找对应value,如果找到就给模型的属性赋值
 */
+ (instancetype)modelWithDict:(NSDictionary *)dict
{
    /*
     picture =     (
     picture1,
     picture2
     );
     repostscount = 20;
     source = "https.xxx";
     text = text1;
     u =     {
     age = 18;
     name = ll;
     };
     */
    //创建对应的对象
    id objc = [[self alloc] init];
    
    unsigned int count = 0;
    
    //获取成员变量数组
    Ivar *ivarList = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i++) {
        //获取成员变量
        Ivar ivar = ivarList[i];
        //获取成员变量名c -> oc 字符串
        NSString *name = [NSString stringWithUTF8String:ivar_getName(ivar)];
        
        //成员变量名(因为带_)->字典key
        NSString *key = [name substringFromIndex:1];
        
        //去字典中取出对应value给模型属性赋值
        id value = dict[key];
        
        if ([value isKindOfClass:[NSDictionary class]]) {
            //获取成员变量类型(可以获取到该model类的类型 @"RuntimeUser")
            NSString *type = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
            
            //处理类型字符串 @\"RuntimeUser\" ->RuntimeUser
            NSRange range = [type rangeOfString:@"\""];
            type = [type substringFromIndex:range.location + range.length];
            
            range = [type rangeOfString:@"\""];
            type = [type substringToIndex:range.location];
            
            //自定义对象，并且值是字典
            //value:user字典->User模型
            //获取模型(user)类对象
            Class modelClass = NSClassFromString(type);
            
            //字典转模型
            if (modelClass) {
                //字典转模型 得到 user对象
                value = [modelClass modelWithDict:value];
            }
        }
        
        //3级转换：NSArray中也是字典，把数组中的字典转换成模型
        //判断值是否是数组
        if ([value isKindOfClass:[NSArray class]]) {
            //判断对应类有没有实现字典数组转模型数组的协议:在该方法中自定义对象类（需要转换成哪个存在的自定义model）
            if ([self respondsToSelector:@selector(arrayContainModelClass)]) {
                //转换成id类型，就能调用任何对象的方法
                id idSelf = self;
                
                //获取数组中字典对应的模型
                NSString *type = [idSelf arrayContainModelClass][key];
                
                //生成模型
                Class classModel = NSClassFromString(type);
                NSMutableArray *arrM = [NSMutableArray array];
                
                //遍历字典数组，生成模型数组
                for (NSDictionary *dict in value) {
                    //字典转模型
                    id model = [classModel modelWithDict:dict];
                    [arrM addObject:model];
                }
                //把模型数组赋值给value
                value = arrM;
            }
        }
        
        //kvc字典转模型
        if (value) {
            [objc setValue:value forKey:key];
        }
    }
    return objc;
}
@end
