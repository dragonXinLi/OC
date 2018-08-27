//
//  RuntimeUser.m
//  iOSTest
//
//  Created by lilong on 2018/8/27.
//  Copyright © 2018年 lilong. All rights reserved.
//

#import "RuntimeUser.h"
#import <objc/runtime.h>
@implementation RuntimeUser

void eat(id self , SEL sel)
{
    NSLog(@"%@ %@",self,NSStringFromSelector(sel));
}

//当一个对象调用未实现的方法，会调用这个方法处理，并且会把对应的方法列表传过来
//刚好可以用来判断，未实现的方法是不是我们想要动态添加的方法
+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    if (sel == @selector(eat)) {
        //动态添加eat方法
        
        //第一个参数：给哪个类添加方法
        //第二个参数：添加方法的方法选择器
        //第三个参数：添加方法的函数实现（函数指针）
        //第四个参数：函数的类型，（返回值+参数类型）v:void @:对象->self :表示SEL->cmd
        class_addMethod(self, @selector(eat), eat, "v@:");
    }
    return [super resolveInstanceMethod:sel];
}

@end
