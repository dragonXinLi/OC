//
//  UILabel+TextAlignmentAdditions.h
//  MOA
//
//  Created by sangfor on 2017/12/26.
//  Copyright © 2017年 moa. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, NSTextAlignmentExpand) {
    NSTextAlignmentTop           = 5,     //  top aligned
    NSTextAlignmentBottom        = 6,     //  bottom aligned
    NSTextAlignmentLeftTop       = 7,     //  left and top aligned
    NSTextAlignmentRightTop      = 8,     //  right and top aligned
    NSTextAlignmentLeftBottom    = 9,     //  left and bottom aligned
    NSTextAlignmentRightBottom   = 10,    //  right and bottom aligned
} NS_ENUM_AVAILABLE_IOS(6_0);

@interface UILabel (TextAlignmentAdditions)

@end
