//
//  RuntimeStatus.h
//  iOSTest
//
//  Created by lilong on 2018/8/27.
//  Copyright © 2018年 lilong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+RuntimeModel.h"

@class RuntimeUser;
@interface RuntimeStatus : NSObject<RuntimeModelDelegate>

@property (nonatomic, strong) NSString *source;

@property (nonatomic, assign) int reposts_count;

@property (nonatomic, strong) NSArray *pic_urls;

@property (nonatomic, strong) NSString *text;

@property (nonatomic, strong) RuntimeUser *user;

@end
