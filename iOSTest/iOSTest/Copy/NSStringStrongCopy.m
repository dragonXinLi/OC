
//
//  NSStringStrongCopy.m
//  iOSTest
//
//  Created by lilong on 2018/7/19.
//  Copyright © 2018年 lilong. All rights reserved.
//

#import "NSStringStrongCopy.h"

@implementation NSStringStrongCopy

// *****NSMutableString -> NSString*****
- (void)test
{
    NSMutableString *str = [NSMutableString stringWithString:@"abc"];
    
    self.name1 = str;
    self.name2 = str;
    self.name3 = str;
    /***
     str==0x6000004465d0 , 0x7ffeeada2448
     name1==0x6000004465d0 , 0x60000043a928
     name2==0xa000000006362613 , 0x60000043a930
     name3==0x6000004465d0 , 0x60000043a938
     
     例如，str对象的地址为..5d0,也就是..5d0是@"abc"的首地址，str变量自身在内存中的地址为..2448;
     当把str赋值给strong的name1时，name1对象的地址为..5d0,name1变量自身在内存中的地址为..928，str和name1指向同样的地址，他们指向的是同一个对象@"abc",这个对象的地址为..5d0,所以他们的值是一样的
     
     当把str赋值给copy的name2时，name2对象的地址为..613,name2变量自身在内存中的地址为..930,str和name2指向的地址是不一样的，他们指向的是不同的对象，所以copy是深复制，一个新的对象，这个对象的地址..613，值为@"abc"
     
     name3和name1指向地址是一样的，说明默认情况下，对象属性是strong
     ***/
    NSLog(@"str==%p , %p" , str , &str);
    NSLog(@"name1==%p , %p" , _name1 , &_name1);
    NSLog(@"name2==%p , %p" , _name2 , &_name2);
    NSLog(@"name3==%p , %p" , _name3 , &_name3);
    
    
    [str appendString:@"de"];
    
    /***
     strong = abcde
     copy = abc
     default = abcde
     
     所以一般情况下，我们不希望字符串的值跟着str变化，一般用copy来设置string属性,如果希望字符串的值跟着赋值的字符串的值变化，可以使用retain,strong
     ***/
    
    NSLog(@"strong = %@" , _name1 );
    NSLog(@"copy = %@" , _name2 );
    NSLog(@"default = %@" , _name3 );
}

// *****NSString -> NSString*****
- (void)test2
{
    NSString *str = @"abc";
    self.name1 = str;
    self.name2 = str;
    self.name3 = str;
    
    
    /***
     str==0x104fe2e18 , 0x7ffeeac8b448
     name1==0x104fe2e18 , 0x6000004342e8
     name2==0x104fe2e18 , 0x6000004342f0
     name3==0x104fe2e18 , 0x6000004342f8
     
     全部都指向同一对象
     
     注意：上面的情况是针对于当把NSMutableString赋值给NSString的时候，才会有不同，如果是赋值是NSString对象，那么使用copy还是strong，结果都是一样的，因为NSString对象根本就不能改变自身的值，他是不可变的。
     ***/
    
    NSLog(@"str==%p , %p" , str , &str);
    NSLog(@"name1==%p , %p" , _name1 , &_name1);
    NSLog(@"name2==%p , %p" , _name2 , &_name2);
    NSLog(@"name3==%p , %p" , _name3 , &_name3);
    
    str = @"de";
    
    /***
      strong = abc
      copy = abc
      default = abc
     ***/
    NSLog(@"strong = %@" , _name1 );
    NSLog(@"copy = %@" , _name2 );
    NSLog(@"default = %@" , _name3 );
}


// *****NSMutableString -> NSMutableString*****
- (void)test3
{
    NSMutableString *str = [NSMutableString stringWithString:@"abc"];
    self.name4 = str;
    self.name5 = str;
    self.name6 = str;
    
    /***
        str==0x60000025d7c0 , 0x7ffee7b0d448
        name4==0x60000025d7c0 , 0x600000473ee0
        name5==0xa000000006362613 , 0x600000473ee8
        name6==0x60000025d7c0 , 0x600000473ef0
     ***/
    
    NSLog(@"str==%p , %p" , str , &str);
    NSLog(@"name4==%p , %p" , _name4 , &_name4);
    NSLog(@"name5==%p , %p" , _name5 , &_name5);
    NSLog(@"name6==%p , %p" , _name6 , &_name6);
    
    [str appendString:@"de"];
    
    /***
        strong = abcde
        copy = abc
        default = abcde
     ***/
    NSLog(@"strong = %@" , _name4 );
    NSLog(@"copy = %@" , _name5 );
    NSLog(@"default = %@" , _name6 );
}


// *****NSString -> NSMutableString*****
- (void)test4
{
    NSString *str = @"abc";
    self.name4 = str.mutableCopy;
    self.name5 = str.mutableCopy;
    self.name6 = str.mutableCopy;
    
    
    /***
        str==0x10fa74e18 , 0x7ffee01f9448
        name4==0x60400044d950 , 0x6040004757e0
        name5==0xa000000006362613 , 0x6040004757e8
        name6==0x6040004503b0 , 0x6040004757f0
     
     各自不同的指向对象
     ***/
    
    NSLog(@"str==%p , %p" , str , &str);
    NSLog(@"name4==%p , %p" , _name4 , &_name4);
    NSLog(@"name5==%p , %p" , _name5 , &_name5);
    NSLog(@"name6==%p , %p" , _name6 , &_name6);
    
    str = @"de";

    /***
        strong = abc
        copy = abc
        default = abc
     ***/
    NSLog(@"strong = %@" , _name4 );
    NSLog(@"copy = %@" , _name5 );
    NSLog(@"default = %@" , _name6 );
}
@end
