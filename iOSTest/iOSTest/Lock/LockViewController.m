//
//  LockViewController.m
//  iOSTest
//
//  Created by lilong on 2018/8/20.
//  Copyright © 2018年 lilong. All rights reserved.
//

#import "LockViewController.h"

#include <pthread.h>

@interface Person : NSObject

@end

@implementation Person

- (void)personA
{
//    @synchronized(self)
//    {
        NSLog(@"执行personA");
        NSLog(@"sleepForTimeInterval:3");
        [NSThread sleepForTimeInterval:5];
//    }
}

- (void)personB
{
    NSLog(@"执行personB");
}

@end

@interface PersonB : NSObject

@end

@implementation PersonB

- (void)person
{
    NSLog(@"执行personB");
}

@end

@interface LockViewController ()

@end

@implementation LockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    Person *person = [[Person alloc] init];
    
    if (0) {
        [self synchronizedWithPerson:person];
    }

    if (0) {
        [self nsLockWithPerson:person];
    }
    
    if (0) {
        [self pthreadMutexTWithPerson:person];
    }
    
    if (1) {
        [self semaphoreWithPerson:person];
    }
    
    if (0) {
        [self nsRecursiveLockWithPerson:person];
    }
    
    if (0) {
        [self nsConditionLockWithPerson:person];
    }
    
    if (0) {
        [self nsDistributedLockWithPerson:person];
    }
}


- (void)synchronizedWithPerson:(Person *)person
{
    //@synchronized(anobj),只与anobj对象标识有关，不管代码块执行任何代码
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //关键字@synchronized的使用，锁定的对象为锁的唯一标示，只有标识相同时，才满足互斥。
        @synchronized(person)
        {
            [person personA];
        }
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @synchronized(person)
        {
            [person personA];
        }
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @synchronized(self)
        {
            //如果线程B锁对象改为self或者其他标识，那么线程2将不会被阻塞。
            [person personB];
        }
    });
    
//    2018-08-21 14:39:39.966079+0800 iOSTest[72959:1355857] 执行personA
//    2018-08-21 14:39:39.966088+0800 iOSTest[72959:1355847] 执行personB
//    2018-08-21 14:39:39.966733+0800 iOSTest[72959:1355857] sleepForTimeInterval:3
//    2018-08-21 14:39:44.971829+0800 iOSTest[72959:1355856] 执行personA
//    2018-08-21 14:39:44.972019+0800 iOSTest[72959:1355856] sleepForTimeInterval:3
    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        NSLog(@"dispatch_async1");
//        [person personA];
//    });
//
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        NSLog(@"dispatch_async2");
//        [person personA];
//    });
}

- (void)nsLockWithPerson:(Person *)person
{
    //线程B会等待线程A解锁后，才会去执行线程B，如果线程B把lock和unlock方法去掉之后，则线程B不会被阻塞
    //和synchroized一样，需要使用同样的锁对象才会互斥
    //注意：锁定(lock)和解锁(unLock)必须配对使用
    NSLock *myLock = [[NSLock alloc] init];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
        [myLock lock];
        [person personA];
        [myLock unlock];
    });
    
    /*
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
        [myLock lock];
        [person personA];
        [myLock unlock];
    });
    
//    2018-08-20 20:12:13.925308+0800 iOSTest[33431:589471] 执行personA
//    2018-08-20 20:12:13.925436+0800 iOSTest[33431:589471] sleepForTimeInterval:5
//    2018-08-20 20:12:18.926934+0800 iOSTest[33431:589217] 执行personA
//    2018-08-20 20:12:18.927153+0800 iOSTest[33431:589217] sleepForTimeInterval:5
    */
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
        sleep(1);
//        BOOL tryLock = [myLock tryLock];
        BOOL lock = [myLock lockBeforeDate:[NSDate dateWithTimeIntervalSinceNow:2]];
        [person personA];
        [myLock unlock];
    });
    
}

- (void)pthreadMutexTWithPerson:(Person *)person
{
    __block pthread_mutex_t mutex;
    pthread_mutex_init(&mutex , NULL);
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        pthread_mutex_lock(&mutex);
        [person personA];
        pthread_mutex_unlock(&mutex);
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(0);
        pthread_mutex_lock(&mutex);
        [person personA];
        pthread_mutex_unlock(&mutex);
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(1);
        pthread_mutex_lock(&mutex);
        [person personB];
        pthread_mutex_unlock(&mutex);
    });
}

- (void)semaphoreWithPerson:(Person *)person
{
    /*
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //返回 a = 0
        long a = dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        [person personA];
        //返回 b = 1
        long b = dispatch_semaphore_signal(semaphore);
        NSAssert(1, nil);
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //先让线程1执行personA,然后personA的工作时间是5S，线程2会在第2S进行获取信号量，若信号量为0，则阻塞在这里，一直等待信号量>0
        sleep(1);
        long a = dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        //5s后多线程才会进入这里执行代码
        [person personB];
        long b = dispatch_semaphore_signal(semaphore);
        NSAssert(1, nil);
    });
//    2018-08-21 15:07:34.578089+0800 iOSTest[73630:1391493] 执行personA
//    2018-08-21 15:07:34.578860+0800 iOSTest[73630:1391493] sleepForTimeInterval:3
//    2018-08-21 15:07:39.583496+0800 iOSTest[73630:1391482] 执行personB
     */
    [self testSemaphoreWithPerson:person];
}

- (void)testSemaphoreWithPerson:(Person *)person
{
    //dispatch_semaphore_create(0)如果创建时填的是0，那么只要遇到wait就会阻塞当前线程，这样做的一般情景是
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [person personA];
        long b = dispatch_semaphore_signal(semaphore);
        NSAssert(1, nil);
    });
    
    //这里会阻塞当前线程(如果当前线程是主线程，就会卡顿)
    long a = dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    //线程2需等到线程1释放了signal信号量才会执行
    [person personB];
    
//    2018-08-21 17:07:10.676409+0800 iOSTest[75478:1487636] 执行personA
//    2018-08-21 17:07:10.676548+0800 iOSTest[75478:1487636] sleepForTimeInterval:3
//    2018-08-21 17:07:15.679400+0800 iOSTest[75478:1487577] 执行personB
}

- (void)nsRecursiveLockWithPerson:(Person *)person
{
    NSRecursiveLock *theLock = [[NSRecursiveLock alloc] init];
    
    static void (^testCode)(int);
    testCode = ^(int value){
        [theLock tryLock];
        if (value > 0) {
            [person personA];
            testCode(value - 1);
        }
        [theLock unlock];
    };
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
        testCode(5);
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
        [theLock lock];
        [person personB];
        [theLock unlock];
    });
    //两个异步线程先后顺序不一定
//    2018-08-20 20:24:45.836440+0800 iOSTest[33915:604913] 执行personB
//    2018-08-20 20:24:45.836440+0800 iOSTest[33915:604914] 执行personA
//    2018-08-20 20:24:45.836776+0800 iOSTest[33915:604914] sleepForTimeInterval:2
//    2018-08-20 20:24:47.844135+0800 iOSTest[33915:604914] 执行personA
//    2018-08-20 20:24:47.844363+0800 iOSTest[33915:604914] sleepForTimeInterval:2
//    2018-08-20 20:24:49.847583+0800 iOSTest[33915:604914] 执行personA
//    2018-08-20 20:24:49.847780+0800 iOSTest[33915:604914] sleepForTimeInterval:2
//    2018-08-20 20:24:51.851597+0800 iOSTest[33915:604914] 执行personA
//    2018-08-20 20:24:51.851795+0800 iOSTest[33915:604914] sleepForTimeInterval:2
//    2018-08-20 20:24:53.853472+0800 iOSTest[33915:604914] 执行personA
//    2018-08-20 20:24:53.853728+0800 iOSTest[33915:604914] sleepForTimeInterval:2
}

- (void)nsConditionLockWithPerson:(Person *)person
{
    //条件锁,unlockWithCondition设置的条件必须一样，否则采用条件锁无效
    NSConditionLock *conditiononLock = [[NSConditionLock alloc] init];
    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        [conditiononLock lock];
//        [person personA];
//        [conditiononLock unlockWithCondition:10];
//    });
//
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        //线程一直在这里等待条件变量为10的被其他线程释放的锁，如果取不到该锁，则阻塞
//        [conditiononLock lockWhenCondition:10];
//        [person personB];
//        [conditiononLock unlock];
//    });
////    2018-08-21 15:33:35.458925+0800 iOSTest[74025:1416872] 执行personA
////    2018-08-21 15:33:35.459840+0800 iOSTest[74025:1416872] sleepForTimeInterval:3
    
    
    //在线程1中直接使用了lock，所以是不需要条件的，所以顺利的就锁住了
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (int i=0;i<=2;i++)
        {
            [conditiononLock lock];
            NSLog(@"thread1:%d",i);
            sleep(2);
            //在unlock的时候使用了一个整型的条件，它可以开启其他现在正在等待这把钥匙的临界池，而线程2则需要一把标识为2的钥匙，所以当线程循环到最后一次的时候，，才最终打开了线程2中的阻塞
            [conditiononLock unlockWithCondition:i];
        }
    });

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [conditiononLock lockWhenCondition:2];
        NSLog(@"thread2");
        [conditiononLock unlock];
    });
//    2018-08-20 20:40:36.996031+0800 iOSTest[34259:622466] thread1:0
//    2018-08-20 20:40:39.001330+0800 iOSTest[34259:622466] thread1:1
//    2018-08-20 20:40:41.002311+0800 iOSTest[34259:622466] thread1:2
//    2018-08-20 20:40:43.003147+0800 iOSTest[34259:622468] thread2

}

//多个进程或多个程序之间构建互斥的情景
- (void)nsDistributedLockWithPerson:(Person *)person
{
    
}

@end
