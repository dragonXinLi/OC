//
//  NSString+ContentSize.h
//  apple
//
//  Created by sangfor on 17/4/6.
//  Copyright © 2017年 com.sangfor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ContentSize)

- (CGSize)sizeWithFont:(UIFont *)font;

- (CGSize)sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;

- (CGSize)sizeWithFont:(UIFont *)font forWidth:(CGFloat)width lineBreakMode:(NSLineBreakMode)lineBreakMode;

- (CGSize)sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode;

- (CGSize)lerSizeWithFont:(UIFont *)font;

- (CGSize)sizeWithFont:(UIFont *)font maxWith:(CGFloat)maxW;

- (CGSize)sizeWithFont:(UIFont *)font maxWith:(CGFloat)maxW maxHeight:(CGFloat)maxH;



@end
