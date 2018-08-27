//
//  UIImage+RuntimeCategory.m
//  iOSTest
//
//  Created by lilong on 2018/8/27.
//  Copyright © 2018年 lilong. All rights reserved.
//

#import "UIImage+RuntimeCategory.h"
#import <objc/runtime.h>
@implementation UIImage (RuntimeCategory)

+(void)load
{
    Method m1 = class_getClassMethod([self class], @selector(imageNamed:));
    Method m2 = class_getClassMethod([self class], @selector(ll_imageNamed:));
    
    method_exchangeImplementations(m1, m2);
}

+ (UIImage *)ll_imageNamed:(NSString *)name
{
    double verison = [[UIDevice currentDevice].systemName doubleValue];
    if (verison >=7.0) {
        name = [name stringByAppendingString:@"_os7"];
    }
    return [UIImage ll_imageNamed:name];
}

@end
