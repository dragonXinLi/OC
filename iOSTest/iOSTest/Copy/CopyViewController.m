//
//  CopyViewController.m
//  iOSTest
//
//  Created by lilong on 2018/7/18.
//  Copyright © 2018年 lilong. All rights reserved.
//

#import "CopyViewController.h"
#import "person.h"
#import "NSStringStrongCopy.h"

@interface CopyViewController ()

@end

@implementation CopyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self test1];
//    [self test2];
    [self test3];
}


- (void)test1
{
    NSString *name=@"Kenshin";
    NSString *str1=[NSString stringWithFormat:@"I'm %@.",name];//注意此时str1的计数器是1
//    NSLog(@"%lu",[str1 retainCount]); //结果：1
    
    NSMutableString *str2=[str1 mutableCopy];//注意此时str2的计数器为1，str1的计数器还是1，因为str2是个新对象

    [str2 appendString:@"def"];//改变str2，str1不变
    NSLog(@"%zi",str1==str2);//二者不是向同一个对象,结果：0
    NSLog(@"str1=%@",str1); //结果：str1=I'm Kenshin.
    NSLog(@"str2=%@",str2); //结果：str2=I'm Kenshin.def
    
    NSString *str3=[str1 copy];//str3不是产生的新对象而是复制了对象指针，但是str1的计数器+1（当然既然str3同样指向同一个对象，那么如果计算str3指向的对象引用计数器肯定等于str1的对象引用计数器）
    NSLog(@"%zi",str1==str3);//二者相等指向同一个对象,结果：1
    
    //需要注意的是使用copy和mutableCopy是深复制还是浅复制不是绝对，关键看由什么对象产生什么样的对象
    NSString *str4=[str2 copy];//由NSMutableString产生了NSString，二者类型都不同肯定是深拷贝，此时str2的计数器还是1，str4的计数器也是1
    [str2 appendString:@"g"];//改变原对象不影响str4
    NSLog(@"%zi",str2==str4); //结果：0
    NSLog(@"str2=%@",str2); //结果：str2=I'm Kenshin.defg
    NSLog(@"str4=%@",str4); //结果：str4=I'm Kenshin.def
    
    NSMutableString *str5=[str2 mutableCopy];//由NSMutableString产生了NSString，二者类型都不同肯定是深拷贝，此时str2的计数器还是1，str4的计数器也是1

    [str2 appendString:@"g"];//改变原对象不影响str4
    NSLog(@"%zi",str2==str5); //结果：0
    NSLog(@"str2=%@",str2); //结果：str2=I'm Kenshin.defg
    NSLog(@"str5=%@",str5); //结果：str4=I'm Kenshin.def
    
   //上面只有一种情况是浅拷贝：不可变对象调用copy方法
}

- (void)test2
{
    person *person1 = [[person alloc] init];
    
    NSMutableString *str1 = [NSMutableString stringWithString:@"Kenshin"];
    // *****如果name属性修饰符是strong，那么str1和name指向同一对象*****
    person1.name = str1;
    
    [str1 appendString:@"  Cui"];
    NSLog(@"%@",str1);
    NSLog(@"%@",person1.name);
    
    
}

- (void)test3
{
    NSStringStrongCopy *person = [[NSStringStrongCopy alloc] init];
//    [person test];
//    [person test2];
//    [person test3];
    [person test4];
}
@end
