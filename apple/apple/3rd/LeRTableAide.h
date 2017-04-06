//
//  LeRTableAide.h
//  apple
//
//  Created by sangfor on 17/4/6.
//  Copyright © 2017年 com.sangfor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LeRTableAide : NSObject

+ (UILabel *)generateEmptyLabel:(NSString *)text;
+ (UIView *)generateEmptyViewWithText:(NSString *)text frame:(CGRect)frame;
+ (UILabel *)generateSubTipsLabel:(NSString *)text andEmptyLabel:(UILabel *)label;

@end
