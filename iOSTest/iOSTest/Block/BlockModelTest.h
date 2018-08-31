//
//  BlockModelTest.h
//  iOSTest
//
//  Created by lilong on 2018/8/31.
//  Copyright © 2018年 lilong. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^Block)(void);

@interface BlockModelTest : NSObject

- (void)testWithBlock:(Block)blk;
@end
