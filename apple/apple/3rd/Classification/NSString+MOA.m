//
//  NSString+MOA.m
//  apple
//
//  Created by sangfor on 17/6/19.
//  Copyright © 2017年 com.sangfor. All rights reserved.
//

#import "NSString+MOA.h"

@implementation NSString (MOA)

- (NSString *)trimmingSpaceAndNewLine
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

@end
