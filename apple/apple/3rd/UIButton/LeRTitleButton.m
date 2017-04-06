//
//  LeRTitleButton.m
//  apple
//
//  Created by sangfor on 17/4/6.
//  Copyright © 2017年 com.sangfor. All rights reserved.
//

#import "LeRTitleButton.h"

const CGFloat HeadButtonFontSize = 17;

@implementation LeRTitleButton

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        _titleRect = CGRectZero;
        _imageRect = CGRectZero;
    }
    return self;
}


- (id)initWithLeftTitle:(NSString *)title
{
    self = [self initWithFrame:CGRectMake(0, STATUSBAR_SHIFT, 80, 44)];
    if(self)
    {
        self.titleRect = CGRectMake(15, 0, 65, 44);
    }
    return  self;
}


- (id)initWithLeftImage:(UIImage *)image
{
    self = [self initWithFrame:CGRectMake(0, STATUSBAR_SHIFT, 54, 44)];
    if(self)
    {
        [self setImage:image forState:UIControlStateNormal];
        self.imageRect = CGRectMake(15, (44-image.size.height)/2, image.size.width, image.size.height);
        self.titleRect = CGRectMake(15, 0, 65, 44);
    }
    return  self;
}


- (id)initWithRightTitle:(NSString *)title
{
    CGSize size = [title sizeWithFont:[UIFont systemFontOfSize:HeadButtonFontSize]];
    CGFloat buttonWidth = MIN(90, size.width + 30);
    self = [self initWithFrame:CGRectMake(SCREEN_WIDTH - buttonWidth, STATUSBAR_SHIFT, buttonWidth, 44)];
    if(self)
    {
        self.titleRect = CGRectMake(0, 0, buttonWidth, 44);
    }
    return self;
}


- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    if(CGRectEqualToRect(self.titleRect, CGRectZero))
    {
        return contentRect;
    }
    return self.titleRect;
}


- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    if(CGRectEqualToRect(self.imageRect, CGRectZero))
    {
        return contentRect;
    }
    return self.imageRect;
}


- (void)setTitleRect:(CGRect)titleRect
{
    _titleRect = titleRect;
    [self setNeedsDisplay];
}


- (void)setImageRect:(CGRect)imageRect
{
    _imageRect = imageRect;
    [self setNeedsDisplay];
}


@end
