//
//  ResultOne.m
//  RN
//
//  Created by sangfor on 2017/7/20.
//  Copyright © 2017年 LL. All rights reserved.
//

#import "ResultOne.h"

@implementation ResultOne

-(void)eat1
{
    NSLog(@"eat");
}
-(void)run1
{
    NSLog(@"run");
}


- (ResultOne *)eat2
{
    [self eat1];
    return self;
}
-(ResultOne *)run2
{
    [self run1];
    return self;
}


-(ResultOne *)eat3:(NSString *)food
{
    NSLog(@"eat : %@" , food);
    return self;
}
-(ResultOne *)run3:(float)metter
{
    NSLog(@"run :%f metter" , metter);
    return self;
}


-(void (^)())eat4
{
    //返回一个无返回值,无参数的的block
    void (^eat4Block)() = ^(void)
    {
        NSLog(@"eat4");
    };
    return eat4Block;
}
-(void (^)())run4
{
    return ^(void){
        NSLog(@"run4");
    };
}


-(ResultOne *(^)())eat5
{
    ResultOne *(^eat5Block)() = ^
    {
        NSLog(@"eat5");
        return self;
    };
    return eat5Block;
}
-(ResultOne *(^)())run5
{
    ResultOne *(^run5Block)() = ^{
        NSLog(@"run5");
        return self;
    };
    return run5Block;
}


-(ResultOne *(^)(NSString *))eat6
{
    ResultOne *(^eatBlock6)(NSString *) = ^(NSString *food){
        NSLog(@"eat:%@" , food);
        return self;
    };
    return eatBlock6;
}
-(ResultOne *(^)(float))run6
{
    ResultOne *(^runBlock6)(float) = ^(float metter){
        NSLog(@"run : %f",metter);
        return self;
    };
    return runBlock6;
}


-(void)eat7:(void (^)())block
{
    if (block) {
        block();
    }
}
-(void)run7:(void (^)())block
{
    if (block) {
        block();
    }
}


-(ResultOne *)eat8:(void (^)())block
{
    if (block) {
        block();
    }
    return self;
}
-(ResultOne *)run8:(void (^)())block
{
    if (block) {
        block();
    }
    return self;
}


-(ResultOne *)eat9:(void (^)(NSString *food))block
{
    if (block) {
        block(@"eat9");
    }
    return self;
}
-(ResultOne *)run9:(void (^)(float))block
{
    if (block) {
        block(100);
    }
    return self;
}


-(void (^)(NSString *, void (^)()))eat10
{
    void (^eat10Block)(NSString *food,void (^)()) = ^(NSString *food ,void (^needBlock)(void))
    {
        if(needBlock)
        {
            needBlock();
        }
    };
    return eat10Block;
}
-(void (^)(float, void (^)()))run10
{
    return ^(float metter , void (^needBlock)()){
      if(needBlock)
      {
          needBlock();
      }
    };
}


-(ResultOne *(^)(NSString *, void (^)(NSString *)))eat11
{
    ResultOne * (^eatBlock11)(NSString *,void (^needBlock)(NSString *)) = ^(NSString *food , void (^needBlock)(NSString *)){
        if(needBlock)
        {
            needBlock(food);
        }
        return self;
    };
    return eatBlock11;
}
-(ResultOne *(^)(float, void (^)(float)))run11
{
    ResultOne *(^run11Block)(float,void (^)(float)) = ^(float metter , void (^needBlock)(float metter))
    {
        if(needBlock)
        {
            needBlock(metter);
        }
        return self;
    };
    return run11Block;
}
@end
