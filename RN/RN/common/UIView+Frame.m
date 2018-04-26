//
//  UIView+Frame.m
//  MOA
//
//  Created by jch jason on 14-8-21.
//  Copyright (c) 2014年 moa. All rights reserved.
//

#import "UIView+Frame.h"
#import <objc/runtime.h>
//#import "MOAAlert.h"

@implementation UIView (Frame)
+ (void)load
{
    Method originalMethod = class_getInstanceMethod(self, @selector(pointInside:withEvent:));
    Method newMethod = class_getInstanceMethod(self, @selector(myPointInside:withEvent:));
    method_exchangeImplementations(originalMethod, newMethod);
}

- (BOOL)myPointInside:(CGPoint)point withEvent:(UIEvent *)event {
    if (UIEdgeInsetsEqualToEdgeInsets(self.touchExtendInset, UIEdgeInsetsZero) || self.hidden) {
        return [self myPointInside:point withEvent:event];
    }
    CGRect hitFrame = UIEdgeInsetsInsetRect(self.bounds, self.touchExtendInset);
    hitFrame.size.width = MAX(hitFrame.size.width, 0);
    hitFrame.size.height = MAX(hitFrame.size.height, 0);
    return CGRectContainsPoint(hitFrame, point);
}


- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}
- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}
- (CGFloat)centerY
{
    return self.center.y;
}

- (void) setTouchExtendInset:(UIEdgeInsets)touchExtendInset
{
    objc_setAssociatedObject(self, @selector(touchExtendInset), [NSValue valueWithUIEdgeInsets:touchExtendInset],
                             OBJC_ASSOCIATION_RETAIN);
}

- (UIEdgeInsets)touchExtendInset
{
    return [objc_getAssociatedObject(self, @selector(touchExtendInset)) UIEdgeInsetsValue];
}

- (CGFloat)originX
{
    return self.frame.origin.x;
}

- (CGFloat)originY
{
    return self.frame.origin.y;
}

- (CGFloat)maxX
{
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)maxY
{
    return CGRectGetMaxY(self.frame);
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setOriginXOffset:(CGFloat)x
{
    [self setOriginX:self.originX+x];
}

- (void)setOriginYOffset:(CGFloat)y
{
    [self setOriginY:self.originY+y];
}

- (void)setOriginX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setOriginY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

//获取下一个响应者
- (id)getNextResponder:(Class)theClass
{
    id next = [self nextResponder];
    if (!next) {
        return nil;
    }
    while(![next isKindOfClass:theClass])
    {
        next = [next nextResponder];
        if (!next) {
            break;
        }
    }
    return next;
}


// //纠正0.5在iphoen6上显示的问题
//- (void)mySetFrame:(CGRect)frame {
//    CGFloat height = frame.size.height==0.5?UNIT_PIXEL:frame.size.height;
//    CGFloat originY = frame.origin.y-floorf(frame.origin.y)==0.5?frame.origin.y+UNIT_PIXEL:frame.origin.y;
//    
//    [self mySetFrame:CGRectMake(frame.origin.x, originY, frame.size.width, height)];
//}
//
//- (id)myInitWithFrame:(CGRect)frame {
//    CGFloat height = frame.size.height==0.5?UNIT_PIXEL:frame.size.height;
//    CGFloat originY = frame.origin.y-floorf(frame.origin.y)==0.5?frame.origin.y+UNIT_PIXEL:frame.origin.y;
//    
//    return [self myInitWithFrame:CGRectMake(frame.origin.x, originY, frame.size.width, height)];
//}

//+ (void)load
//{
//    Method sefFrame = class_getInstanceMethod(self, @selector(setFrame:));
//    Method mySetFrame = class_getInstanceMethod(self, @selector(mySetFrame:));
//    method_exchangeImplementations(sefFrame, mySetFrame);
//    
//    Method initWithFrame = class_getInstanceMethod(self, @selector(initWithFrame:));
//    Method myInitWithFrame = class_getInstanceMethod(self, @selector(myInitWithFrame:));
//    method_exchangeImplementations(initWithFrame, myInitWithFrame);
//}

//- (void)showErrorAlertWithTitle:(NSString*)title
//{
//    MOAAlert *alert = [[MOAAlert alloc]initWithTitle:title andAlertPromptType:AlertPromptTypeError];
//    [alert show];
//}

@end
