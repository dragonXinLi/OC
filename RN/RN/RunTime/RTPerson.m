//
//  RTPerson.m
//  RN
//
//  Created by sangfor on 2017/8/1.
//  Copyright © 2017年 LL. All rights reserved.
//

#import "RTPerson.h"
#import <objc/runtime.h>
@implementation RTPerson

void run(id self , SEL sel)
{
    NSLog(@"%@%@",self , NSStringFromSelector(sel));
}


+(BOOL)resolveClassMethod:(SEL)sel
{
    if(sel == @selector(run))
    {
        class_addMethod(self, @selector(run), (IMP)run, "v@:");
    }
    
    return [super resolveClassMethod:sel];
}


+(BOOL)resolveInstanceMethod:(SEL)sel
{
    if(sel == @selector(run))
    {
      class_addMethod(self, @selector(run), (IMP)run, "v@:");
    }
    
    return [super resolveClassMethod:sel];
}

@end
