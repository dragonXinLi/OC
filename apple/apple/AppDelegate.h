//
//  AppDelegate.h
//  apple
//
//  Created by sangfor on 17/3/20.
//  Copyright © 2017年 com.sangfor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Reachability.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;

+ (BOOL)isConnectedToInternet;
+ (BOOL)isConnectedWithWifi;

@end

