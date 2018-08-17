//
//  person.m
//  iOSTest
//
//  Created by lilong on 2018/7/19.
//  Copyright © 2018年 lilong. All rights reserved.
//

#import "person.h"

@implementation person

-(NSString *)description
{
    return [NSString stringWithFormat:@"name = %@ , age = %i" , _name ,_age];
}

// *****实现copy方法*****
- (id)copyWithZone:(NSZone *)zone
{
    // *****注意zone是系统已经分配好的用于存储当前对象的内存*****
    // *****注意下面创建对象最好不要用[Person allocWithZone:zone]，因为子类如果没有实现该方法copy时会调用父类的copy方法，此时需要使用子类对象初始化，如果此时用self就可以表示子类对象，还要就是如果子类调用了父类的这个方法进行重写copy也需要调用子类对象而不是父类person*****
    person *person1 = [[[self class] allocWithZone:zone] init];
    person1.name = _name;
    person1.age = _age;
    return person1;
}

@end
