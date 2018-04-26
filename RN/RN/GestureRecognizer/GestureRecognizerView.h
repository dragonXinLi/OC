//
//  GestureRecognizerView.h
//  RN
//
//  Created by sangfor on 2018/2/1.
//  Copyright © 2018年 LL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GestureRecognizerView : UIView

@property (nonatomic , strong , readonly) UITapGestureRecognizer *tapGesture;

@property (nonatomic , strong) UIView *viewa;

- (void)addHittingView:(UIView *)view;

@end
