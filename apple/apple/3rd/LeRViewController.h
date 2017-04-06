//
//  LeRViewController.h
//  apple
//
//  Created by sangfor on 17/4/1.
//  Copyright © 2017年 com.sangfor. All rights reserved.
//

#import <UIKit/UIKit.h>

#define APP_ENTER_FOREGROUND_NOTIFICATION @"enterforegroundNotification"

@interface LeRViewController : UIViewController

@property (nonatomic , strong) NSString *viewType;

@property (nonatomic , assign) BOOL noNeedPopGesture;

- (id)initWithType:(NSString *)viewType;

- (void)backToRootViewController;

- (void)appEnterForeground;

- (void)appEnterBackground;


@end
