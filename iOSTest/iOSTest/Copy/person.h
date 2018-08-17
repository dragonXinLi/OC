//
//  person.h
//  iOSTest
//
//  Created by lilong on 2018/7/19.
//  Copyright © 2018年 lilong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface person : NSObject

/***
 对应基本数据类型，默认关键字为 atomic,assign , readwrite
 对应对象类型，默认关键字为 atomic , strong , readwrite
 ***/

@property NSMutableString *name;
@property (nonatomic , assign) int age;

@end
