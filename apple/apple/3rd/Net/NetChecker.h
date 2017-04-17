//
//  NetChecker.h
//  apple
//
//  Created by sangfor on 17/4/11.
//  Copyright © 2017年 com.sangfor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetChecker : NSObject

+ (BOOL)checkNetStatus;
+ (BOOL)checkNetWithoutAlert;
+ (BOOL)isWifi;
+ (BOOL)checkNetWithTitle:(NSString *)title;
+ (BOOL)checkNetForAsynchronousRequest;

@end
