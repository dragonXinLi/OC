//
//  NSString+ContentSize.m
//  apple
//
//  Created by sangfor on 17/4/6.
//  Copyright © 2017年 com.sangfor. All rights reserved.
//

#import "NSString+ContentSize.h"

#define DEFAULT_FONT [UIFont systemFontOfSize:12]

@implementation NSString (ContentSize)

- (CGSize)sizeWithFont:(UIFont *)font
{
    return [self sizeWithAttributes:@{NSFontAttributeName:font ? font : DEFAULT_FONT}];
}


- (CGSize)sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size
{
    return [self boundingRectWithSize:size
                              options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin
                           attributes:@{NSFontAttributeName:font ? font : DEFAULT_FONT} context:nil].size;
}


- (CGSize)sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = lineBreakMode;
    
    return [self boundingRectWithSize:size
                              options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin
                           attributes:@{NSFontAttributeName : font ? font : DEFAULT_FONT , NSParagraphStyleAttributeName : paragraphStyle} context:nil].size;
}


- (CGSize)sizeWithFont:(UIFont *)font forWidth:(CGFloat)width lineBreakMode:(NSLineBreakMode)lineBreakMode
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = lineBreakMode;
    
    return [self boundingRectWithSize:CGSizeMake(width, 10000)
                              options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin
                           attributes:@{NSFontAttributeName :font ? font : DEFAULT_FONT} context:nil].size;
}


- (CGSize)sizeWithFont:(UIFont *)font maxWith:(CGFloat)maxW maxHeight:(CGFloat)maxH
{
    CGSize size;
    if(self.length == 0)
    {
        size = CGSizeMake(0, 0);
    }else
    {
        if([[UIDevice currentDevice] systemVersion].floatValue > 7.0)
        {
            size = [self boundingRectWithSize:CGSizeMake(maxW, maxH)
                                      options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin
                                   attributes:@{NSFontAttributeName : font ? font : DEFAULT_FONT} context:nil].size;
        }else
        {
            size = [self sizeWithFont:font
                    constrainedToSize:CGSizeMake(maxW, maxH)
                        lineBreakMode:NSLineBreakByWordWrapping];
        }
    }
    return size;
}


- (CGSize)sizeWithFont:(UIFont *)font maxWith:(CGFloat)maxW
{
    return [self sizeWithFont:font maxWith:maxW maxHeight:CGFLOAT_MAX];
}


- (CGSize)lerSizeWithFont:(UIFont *)font
{
    CGSize size ;
    if(self.length == 0)
    {
        size = CGSizeMake(0, 0);
    }else
    {
        if([[UIDevice currentDevice] systemVersion].floatValue > 7.0)
        {
            size = [self sizeWithAttributes:@{NSFontAttributeName : font ? font : DEFAULT_FONT}];
        }else
        {
            size = [self sizeWithFont:font];
        }
    }
    return size;
}

@end
