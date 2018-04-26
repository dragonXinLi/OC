//
//  UIView+Frame.h
//  MOA
//
//  Created by jch jason on 14-8-21.
//  Copyright (c) 2014年 moa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) UIEdgeInsets touchExtendInset;

- (CGFloat)originX;
- (CGFloat)originY;

- (CGFloat)maxX;
- (CGFloat)maxY;

- (CGFloat)width;
- (CGFloat)height;

- (void)setOriginX:(CGFloat)x;
- (void)setOriginY:(CGFloat)y;
- (void)setOriginXOffset:(CGFloat)x;
- (void)setOriginYOffset:(CGFloat)y;
- (void)setWidth:(CGFloat)width;
- (void)setHeight:(CGFloat)height;

- (id)getNextResponder:(Class)theClass;
@end
