//
//  UIColor+CustomColor.h
//  apple
//
//  Created by sangfor on 17/4/1.
//  Copyright © 2017年 com.sangfor. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * const TableBackgroundColor ;
extern NSString * const SetTableBackgroundColor;



@interface UIColor (CustomColor)

+ (UIColor *)colorWithHexString:(const NSString *)color;
+ (UIColor *)colorWithHexString:(const NSString *)color alpha:(float)alpha;

@end
