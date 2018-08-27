//
//  Person.h
//  iOSTest
//
//  Created by LL on 2018/8/26.
//  Copyright © 2018年 lilong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface RuntimePerson : NSObject<NSCopying>

@property (nonatomic , strong) NSString *name;
@property (nonatomic , strong) NSNumber *age;
@property (nonatomic , assign) CGFloat weight;

@end
