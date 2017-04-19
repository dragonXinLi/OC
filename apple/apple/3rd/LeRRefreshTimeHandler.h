//
//  LeRRefreshTimeHandler.h
//  apple
//
//  Created by LL on 17/4/19.
//  Copyright © 2017年 com.sangfor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LeRRefreshTimeHandler : NSObject

+ (NSDate *)getTableRefreshTime:(id)object;

+ (void)saveTableRefreshTime:(id)object;


@end
