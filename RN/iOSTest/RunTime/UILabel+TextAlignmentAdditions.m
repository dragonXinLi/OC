//
//  UILabel+TextAlignmentAdditions.m
//  MOA
//
//  Created by sangfor on 2017/12/26.
//  Copyright © 2017年 moa. All rights reserved.
//

#import "UILabel+TextAlignmentAdditions.h"
#import <objc/runtime.h>

@implementation UILabel (TextAlignmentAdditions)

+(void)load {
    
    /** 获取原始的 textRectForBounds:limitedToNumberOfLines:方法*/
    
    Method originalTextRectForBounds = class_getInstanceMethod([self class], @selector(textRectForBounds:limitedToNumberOfLines:));
    Method exchageTextRectForBounds = class_getInstanceMethod([self class], @selector(ll_textRectForBounds:limitedToNumberOfLines:));
    method_exchangeImplementations(originalTextRectForBounds, exchageTextRectForBounds);
    
    /** 获取原始的 drawTextInRect:方法*/
    
    Method originalDrawTextInRect = class_getInstanceMethod([self class], @selector(drawTextInRect:));
    Method exchageDrawTextInRect = class_getInstanceMethod([self class], @selector(ll_drawTextInRect:));
    method_exchangeImplementations(originalDrawTextInRect, exchageDrawTextInRect);
    
}

- (CGRect)ll_textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines {
    
    /** 先调用系统的textRect...方法*/
    CGRect textRect = [self ll_textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
    
    switch ((NSTextAlignmentExpand)self.textAlignment) {
        case NSTextAlignmentTop:
            textRect.origin.y = bounds.origin.y;
            textRect.origin.x = 0.5 *(bounds.size.width - textRect.size.width);
            break;
        case NSTextAlignmentLeftTop:
            textRect.origin.y = bounds.origin.y;
            break;
        case NSTextAlignmentRightTop:
            textRect.origin.y = bounds.origin.y;
            textRect.origin.x = bounds.size.width - textRect.size.width;
            break;
        case NSTextAlignmentBottom:
            textRect.origin.y = bounds.origin.y + bounds.size.height - textRect.size.height;
            textRect.origin.x = 0.5 *(bounds.size.width - textRect.size.width);
            break;
        case NSTextAlignmentLeftBottom:
            textRect.origin.y = bounds.origin.y + bounds.size.height - textRect.size.height;
            break;
        case NSTextAlignmentRightBottom:
            textRect.origin.y = bounds.origin.y + bounds.size.height - textRect.size.height;
            textRect.origin.x = bounds.size.width - textRect.size.width;
            break;
        default:
            textRect.origin.y = bounds.origin.y + (bounds.size.height - textRect.size.height) / 2.0;
    }
    return textRect;
}

-(void)ll_drawTextInRect:(CGRect)requestedRect {
    
    /** 相当于调用ll_textRect...方法*/
    CGRect actualRect = [self textRectForBounds:requestedRect limitedToNumberOfLines:self.numberOfLines];
    
    /** 后调用系统的drawTextInRect:方法*/
    [self ll_drawTextInRect:actualRect];
}

@end
