//
//  UIImage+Image.m
//  RN
//
//  Created by sangfor on 2017/8/1.
//  Copyright © 2017年 LL. All rights reserved.
//

#import "UIImage+Image.h"
#import <objc/runtime.h>
@implementation UIImage (Image)

+ (void)load
{
    Method imageWithName = class_getClassMethod(self, @selector(imageWithNamed:));
    Method imageName = class_getClassMethod(self, @selector(imageNamed:));
    method_exchangeImplementations(imageWithName, imageName);
}

+ (UIImage *)imageWithNamed:(NSString *)name
{
    // 这里调用imageWithName，相当于调用imageName
    UIImage *image = [self imageWithNamed:name];
    
    if (image == nil) {
        NSLog(@"加载空的图片");
    }
    
    return image;
}
@end
