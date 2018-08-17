//
//  NSStringStrongCopy.h
//  iOSTest
//
//  Created by lilong on 2018/7/19.
//  Copyright © 2018年 lilong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSStringStrongCopy : NSObject

@property (nonatomic , strong) NSString *name1;
@property (nonatomic , copy) NSString *name2;
@property  NSString *name3;

@property (nonatomic , strong) NSMutableString *name4;
@property (nonatomic , copy) NSMutableString *name5;
@property  NSMutableString *name6;


- (void)test;
- (void)test2;
- (void)test3;
- (void)test4;

@end
