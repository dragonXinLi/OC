//
//  UIView+Frame.h
//  apple
//
//  Created by sangfor on 17/4/1.
//  Copyright © 2017年 com.sangfor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)

@property (nonatomic , assign) CGFloat centerX;
@property (nonatomic , assign) CGFloat centerY;
@property (nonatomic , assign) UIEdgeInsets touchExtendInset;

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
//- (void)showErrorAlertWithTitle:(NSString *)title;

@end
