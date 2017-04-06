//
//  LeRTitleButton.h
//  apple
//
//  Created by sangfor on 17/4/6.
//  Copyright © 2017年 com.sangfor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeRTitleButton : UIButton

- (id)initWithLeftImage:(UIImage *)image;
- (id)initWithLeftTitle:(NSString *)title;
- (id)initWithRightTitle:(NSString *)title;

@property (nonatomic , assign) CGRect titleRect;
@property (nonatomic , assign) CGRect imageRect;
@end
