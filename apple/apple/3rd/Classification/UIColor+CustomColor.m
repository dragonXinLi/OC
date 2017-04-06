//
//  UIColor+CustomColor.m
//  apple
//
//  Created by sangfor on 17/4/1.
//  Copyright © 2017年 com.sangfor. All rights reserved.
//

#import "UIColor+CustomColor.h"

NSString * const TableBackgroundColor = @"#FFFFFF";
NSString * const SetTableBckgroundColor = kTableBackgroundColorPublic;

@implementation UIColor (CustomColor)

+ (UIColor *)colorWithHexString:(const NSString *)color
{
    return [UIColor colorWithHexString:color alpha:1.0];
}

+ (UIColor *)colorWithHexString:(const NSString *)color alpha:(float)alpha
{
    //去空格,大写
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    if([cString length] < 6)
    {
        return [UIColor clearColor];
    }
    if([cString hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }
    if([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6) {
        //经过上面的处理最后的长度!=6,就返回透明
        return [UIColor clearColor];
    }
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    unsigned int r , g ,b ;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}

@end
