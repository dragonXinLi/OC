//
//  UIView+Frame.m
//  apple
//
//  Created by sangfor on 17/4/1.
//  Copyright © 2017年 com.sangfor. All rights reserved.
//

#import "UIView+Frame.h"
#import <objc/runtime.h>

@implementation UIView (Frame)

+ (void)load
{
    //判断触摸点在不在view内
    Method originalMethod = class_getInstanceMethod(self, @selector(pointInside:withEvent:));
    Method newMethod = class_getInstanceMethod(self, @selector(myPointInside:withEvent:));
    method_exchangeImplementations(originalMethod, newMethod);
}


- (BOOL)myPointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    //比较两个坐标点是否相同
    if(UIEdgeInsetsEqualToEdgeInsets(self.touchExtendInset, UIEdgeInsetsZero) || self.hidden)
    {
        return [self myPointInside:point withEvent:event];
    }
    //根据原来的rect基础上内切一个矩形
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


- (void)setTouchExtendInset:(UIEdgeInsets)touchExtendInset
{
    //设置view的可点击范围
    objc_setAssociatedObject(self, @selector(touchExtendInset), [NSValue valueWithUIEdgeInsets:touchExtendInset], OBJC_ASSOCIATION_RETAIN);
}


- (UIEdgeInsets)touchExtendInset
{
    return [objc_getAssociatedObject(self, @selector(touchExtendInset)) UIEdgeInsetsValue];
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


- (CGFloat)originX
{
    return  self.frame.origin.x;
}


- (CGFloat)originY
{
    return self.frame.origin.y;
}


- (void)setOriginXOffset:(CGFloat)x
{
    [self setOriginX:self.originX + x];
}


- (void)setOriginYOffset:(CGFloat)y
{
    [self setOriginY:self.originY + y];
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


- (CGFloat)width
{
    return self.frame.size.width;
}


- (CGFloat)height
{
    return self.frame.size.height;
}


- (CGFloat)maxX
{
    return CGRectGetMaxX(self.frame);
}


- (CGFloat)maxY
{
    return CGRectGetMaxY(self.frame);
}


- (id)getNextResponder:(Class)theClass
{
    id next = [self nextResponder];
    if(!next)
    {
        return nil;
    }
    while (![next isKindOfClass:theClass]) {
        next = [next nextResponder];
        if(!next)
        {
            break;
        }
    }
    return next;
}
@end
