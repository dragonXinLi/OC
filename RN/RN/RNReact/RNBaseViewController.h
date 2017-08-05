//
//  BaseViewController.h
//  RN
//
//  Created by LL on 2017/7/9.
//  Copyright © 2017年 LL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RCTRootView.h"

@interface RNBaseViewController : UIViewController

@property (nonatomic , assign) NSInteger index;
- (void)loadNRJS:(NSInteger)index;

@end
