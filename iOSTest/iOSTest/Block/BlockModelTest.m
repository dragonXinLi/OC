//
//  BlockModelTest.m
//  iOSTest
//
//  Created by lilong on 2018/8/31.
//  Copyright © 2018年 lilong. All rights reserved.
//

#import "BlockModelTest.h"

@implementation BlockModelTest

- (void)testWithBlock:(Block)blk
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        sleep(5);
        dispatch_sync(dispatch_get_main_queue(), blk);
    });
}

@end
