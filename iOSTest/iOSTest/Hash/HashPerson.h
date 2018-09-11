//
//  HashPerson.h
//  iOSTest
//
//  Created by LL on 2018/9/1.
//  Copyright © 2018年 lilong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HashPerson : NSObject<NSCopying,NSMutableCopying>

@property (nonatomic ,strong) NSString *name;

@property (nonatomic ,strong) NSString *age;

- (instancetype)initWithName:(NSString *)name age:(NSString *)age immutable:(BOOL)immutable;
@end
