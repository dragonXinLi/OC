//
//  LeRGlobalDefinition.h
//  apple
//
//  Created by sangfor on 17/4/1.
//  Copyright © 2017年 com.sangfor. All rights reserved.
//

#ifndef LeRGlobalDefinition_h
#define LeRGlobalDefinition_h

#define STATUSBAR_SHIFT ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 ? 1 : 0)

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define SCREEN_FIXED_WIDTH (((NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_7_1) && UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) ? [UIScreen mainScreen].bounds.size.height : [UIScreen mainScreen].bounds.size.width)
#define SCREEN_FIXED_HEIGHT (((NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_7_1) && UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) ? [UIScreen mainScreen].bounds.size.width : [UIScreen mainScreen].bounds.size.height)

#define SCREEN_SCALE ([UIScreen mainScreen].scale)
#define UNIT_PIXEL (1/SCREEN_SCALE)

#define ISIOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)


#endif /* LeRGlobalDefinition_h */
