//
//  NSObject+RuntimeModel.h
//  iOSTest
//
//  Created by lilong on 2018/8/27.
//  Copyright © 2018年 lilong. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RuntimeModelDelegate <NSObject>

//用在3级数组转换
+ (NSDictionary *)arrayContainModelClass;

@end

@interface NSObject (RuntimeModel)

+ (instancetype)modelWithDict:(NSDictionary *)dict;

@end
