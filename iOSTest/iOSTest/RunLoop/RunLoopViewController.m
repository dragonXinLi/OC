//
//  RunLoopViewController.m
//  iOSTest
//
//  Created by lilong on 2018/7/17.
//  Copyright © 2018年 lilong. All rights reserved.
//

#import "RunLoopViewController.h"

@interface RunLoopViewController ()
@property (nonatomic,weak) NSTimer *timer1;
@property (nonatomic,strong) NSThread *thread1;
@end

@implementation RunLoopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    
    // 由于下面的方法无法拿到NSThread的引用，也就无法控制线程的状态
    //[NSThread detachNewThreadSelector:@selector(performTask) toTarget:self withObject:nil];
    self.thread1 = [[NSThread alloc] initWithTarget:self selector:@selector(performTask) object:nil];
    [self.thread1 start];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.thread1 cancel];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc {
    [self.timer1 invalidate];
    NSLog(@"ViewController dealloc.");
}

- (void)performTask {
    // 使用下面的方式创建定时器虽然会自动加入到当前线程的RunLoop中，但是除了主线程外其他线程的RunLoop默认是不会运行的，必须手动调用
    __weak typeof(self) weakSelf = self;
    self.timer1 = [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
        if ([NSThread currentThread].isCancelled) {
            //[NSObject cancelPreviousPerformRequestsWithTarget:weakSelf selector:@selector(caculate) object:nil];
            //[NSThread exit];
            [weakSelf.timer1 invalidate];
        }
        NSLog(@"timer1...");
    }];
//
    NSLog(@"runloop before performSelector:%@",[NSRunLoop currentRunLoop]);
    
    // 区分直接调用和「performSelector:withObject:afterDelay:」区别,下面的直接调用无论是否运行RunLoop一样可以执行，但是后者则不行。
    // *****performSelector:withObject:afterDelay:该方法必须运行在runloop中，performSelector:withObject:不是必须，应该是和延时调用有关*****
    //[self caculate];
    [self performSelector:@selector(caculate) withObject:nil afterDelay:2.0];
    
    // 取消当前RunLoop中注册测selector（注意：只是当前RunLoop，所以也只能在当前RunLoop中取消）
    // [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(caculate) object:nil];
    NSLog(@"runloop after performSelector:%@",[NSRunLoop currentRunLoop]);
    
    // 非主线程RunLoop必须手动调用
//    [[NSRunLoop currentRunLoop] run];
    [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];

    
    NSLog(@"注意：如果RunLoop不退出（运行中），这里的代码并不会执行，RunLoop本身就是一个循环.");
    
    
}

- (void)caculate {
    for (int i = 0;i < 9999;++i) {
        NSLog(@"%i,%@",i,[NSThread currentThread]);
        if ([NSThread currentThread].isCancelled) {
            return;
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
