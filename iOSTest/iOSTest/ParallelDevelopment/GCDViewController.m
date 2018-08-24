//
//  GCDViewController.m
//  iOSTest
//
//  Created by lilong on 2018/8/17.
//  Copyright © 2018年 lilong. All rights reserved.
//

#import "GCDViewController.h"
#define ROW_COUNT 5
#define COLUMN_COUNT 3
#define ROW_HEIGHT 100
#define ROW_WIDTH ROW_HEIGHT
#define CELL_SPACING 10
@interface GCDViewController ()
{
    
    NSMutableArray *_imageViews;
    NSMutableArray *_imageNames;
}
@end

@implementation GCDViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    if (0) {
        /*
         dispatch_barrier_async()：使用此方法创建的任务首先会查看队列中有没有别的任务要执行，如果有，则会等待已有任务执行完毕再执行；同时在此方法后添加的任务必须等待此方法中任务执行后才能执行。（利用这个方法可以控制执行顺序，例如前面先加载最后一张图片的需求就可以先使用这个方法将最后一张图片加载的操作添加到队列，然后调用dispatch_async()添加其他图片加载任务）
         */
        dispatch_queue_t queue = dispatch_queue_create("barrier", DISPATCH_QUEUE_CONCURRENT);
        
        dispatch_async(queue, ^{
            NSLog(@"111111 %@",[NSThread currentThread]);
        });
        
        dispatch_async(queue, ^{
            NSLog(@"22222 %@",[NSThread currentThread]);
        });
        
        dispatch_barrier_async(queue, ^{
            NSLog(@"barrier %@",[NSThread currentThread]);
        });
        
        dispatch_async(queue, ^{
            NSLog(@"333333 %@",[NSThread currentThread]);
        });
        
        dispatch_async(queue, ^{
            NSLog(@"44444 %@",[NSThread currentThread]);
        });
    }

    if (0) {
        [self layoutUI];
    }
    
    if (0) {
        NSMutableArray *arrayM = @[].mutableCopy;
        for (int i = 0; i < 100; i ++) {
            [arrayM addObject:[NSString stringWithFormat:@"%d",i]];
        }
        //这里需要注意：在当前线程同步执行全局队列任务时，全局队列不会生成子线程，采用当前线程执行
        //    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            while (arrayM.count>0) {
                NSLog(@"%@------%@",[NSThread currentThread] , [arrayM lastObject]);
                [arrayM removeLastObject];
            }
            //        for (NSNumber *i in arrayM) {
            //            NSLog(@"%@------%@",[NSThread currentThread] , i);
            //        }
        });
    }
    
    if (1) {
        dispatch_queue_t queue1 = dispatch_queue_create("com.demo.serialQueue", DISPATCH_QUEUE_SERIAL);
        dispatch_queue_t queue2 = dispatch_queue_create("com.demo.serialQueue2", DISPATCH_QUEUE_SERIAL);
        dispatch_queue_t queue3 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

        NSLog(@"1"); // 任务1
        /*
        //是否在串/并行队列里创建新子线程，决定于线程同/异步
        //但是需要注意：不是async都会创建新的子线程，是否创建子线程取决于新加入的任务是否在同当前线程队列里执行
         */
        
        //dispatch_sync
        /*
        dispatch_async(queue1, ^{
            NSLog(@"-------%@",[NSThread currentThread]);
            NSLog(@"2"); // 任务2
            dispatch_sync(queue1, ^{
                //1.当前线程同步的把任务加入到当前queue1串行队列中，会导致死锁
                NSLog(@"-%@",[NSThread currentThread]);
                NSLog(@"3"); // 任务3
            });
            NSLog(@"4"); // 任务4
        });
        NSLog(@"5"); // 任务5
//        2018-08-20 14:23:42.562529+0800 iOSTest[28059:285149] 1
//        2018-08-20 14:23:42.562694+0800 iOSTest[28059:285149] 5
//        2018-08-20 14:23:42.562803+0800 iOSTest[28059:285182] -------<NSThread: 0x6000006770c0>{number = 7, name = (null)}
//        2018-08-20 14:23:42.562996+0800 iOSTest[28059:285182] 2
        */
        
/*
        dispatch_async(queue1, ^{
            NSLog(@"-------%@",[NSThread currentThread]);
            NSLog(@"2"); // 任务2
            dispatch_sync(queue2, ^{
                //1.当前线程同步的把任务加入到非当前queue2串行队列中，不会生成新的子线程，采用当前线程在queue2队列里执行任务
                NSLog(@"-%@",[NSThread currentThread]);
                NSLog(@"3"); // 任务3
            });
            NSLog(@"4"); // 任务4
        });
        NSLog(@"5"); // 任务5
//        2018-08-20 14:22:26.923184+0800 iOSTest[28006:283264] 1
//        2018-08-20 14:22:26.923341+0800 iOSTest[28006:283264] 5
//        2018-08-20 14:22:26.923434+0800 iOSTest[28006:283331] -------<NSThread: 0x600000475340>{number = 7, name = (null)}
//        2018-08-20 14:22:26.923586+0800 iOSTest[28006:283331] 2
//        2018-08-20 14:22:26.924229+0800 iOSTest[28006:283331] -<NSThread: 0x600000475340>{number = 7, name = (null)}
//        2018-08-20 14:22:26.924746+0800 iOSTest[28006:283331] 3
//        2018-08-20 14:22:26.925551+0800 iOSTest[28006:283331] 4
*/
        
        /*
        dispatch_async(queue1, ^{
            NSLog(@"-------%@",[NSThread currentThread]);
            NSLog(@"2"); // 任务2
            dispatch_sync(queue3, ^{
                //1.当前线程同步的把任务加入到非当前queue3并行队列中，不会生成新的子线程，采用当前线程在queue3队列里执行任务
                NSLog(@"-%@",[NSThread currentThread]);
                NSLog(@"3"); // 任务3
            });
            NSLog(@"4"); // 任务4
        });
        NSLog(@"5"); // 任务5
//        2018-08-20 14:21:16.414458+0800 iOSTest[27968:281640] 1
//        2018-08-20 14:21:16.414599+0800 iOSTest[27968:281640] 5
//        2018-08-20 14:21:16.414702+0800 iOSTest[27968:281673] -------<NSThread: 0x600000674580>{number = 6, name = (null)}
//        2018-08-20 14:21:16.414862+0800 iOSTest[27968:281673] 2
//        2018-08-20 14:21:16.415072+0800 iOSTest[27968:281673] -<NSThread: 0x600000674580>{number = 6, name = (null)}
//        2018-08-20 14:21:16.415638+0800 iOSTest[27968:281673] 3
//        2018-08-20 14:21:16.416152+0800 iOSTest[27968:281673] 4
        */
        
        /*
        dispatch_async(queue1, ^{
            NSLog(@"-------%@",[NSThread currentThread]);
            NSLog(@"2"); // 任务2
            dispatch_sync(dispatch_get_main_queue(), ^{
                //1.当前线程同步的把任务加入到非当前mainQueue主队列中，不会生成新的子线程，采用主线程在mainQueue队列里执行任务
                NSLog(@"-%@",[NSThread currentThread]);
                NSLog(@"3"); // 任务3
            });
            NSLog(@"4"); // 任务4
        });
        NSLog(@"5"); // 任务5
//        2018-08-20 14:24:47.984896+0800 iOSTest[28089:286556] 1
//        2018-08-20 14:24:47.985284+0800 iOSTest[28089:286556] 5
//        2018-08-20 14:24:47.985379+0800 iOSTest[28089:286660] -------<NSThread: 0x600000677f00>{number = 6, name = (null)}
//        2018-08-20 14:24:47.985761+0800 iOSTest[28089:286660] 2
//        2018-08-20 14:24:48.024734+0800 iOSTest[28089:286556] -<NSThread: 0x60400006d880>{number = 1, name = main}
//        2018-08-20 14:24:48.024927+0800 iOSTest[28089:286556] 3
//        2018-08-20 14:24:48.025058+0800 iOSTest[28089:286660] 4
        */
        
        //dispatch_async
        /*
        dispatch_async(queue1, ^{
            NSLog(@"-------%@",[NSThread currentThread]);
            NSLog(@"2"); // 任务2
            dispatch_async(queue1, ^{
                //1.当前线程异步的把任务加入到当前队列queue1串行列中，不会生成新的子线程，采用当前线程在queue1队列里执行任务
                NSLog(@"-%@",[NSThread currentThread]);
                NSLog(@"3"); // 任务3
            });
            NSLog(@"4"); // 任务4
        });
        NSLog(@"5"); // 任务5
//        2018-08-20 14:27:16.224868+0800 iOSTest[28149:289352] 1
//        2018-08-20 14:27:16.225092+0800 iOSTest[28149:289352] 5
//        2018-08-20 14:27:16.225221+0800 iOSTest[28149:289421] -------<NSThread: 0x604000679500>{number = 7, name = (null)}
//        2018-08-20 14:27:16.226129+0800 iOSTest[28149:289421] 2
//        2018-08-20 14:27:16.227011+0800 iOSTest[28149:289421] 4
//        2018-08-20 14:27:16.227343+0800 iOSTest[28149:289421] -<NSThread: 0x604000679500>{number = 7, name = (null)}
//        2018-08-20 14:27:16.227943+0800 iOSTest[28149:289421] 3
        */
        
        /*
        dispatch_async(queue1, ^{
            NSLog(@"-------%@",[NSThread currentThread]);
            NSLog(@"2"); // 任务2
            dispatch_async(queue2, ^{
                //1.当前线程异步的把任务加入到非当前队列queue2串行列中，会生成新的子线程，采用子线程在queue2队列里执行任务
                NSLog(@"-%@",[NSThread currentThread]);
                NSLog(@"3"); // 任务3
            });
            NSLog(@"4"); // 任务4
        });
        NSLog(@"5"); // 任务5
//        2018-08-20 14:28:54.595839+0800 iOSTest[28195:291971] 1
//        2018-08-20 14:28:54.596009+0800 iOSTest[28195:291971] 5
//        2018-08-20 14:28:54.596108+0800 iOSTest[28195:292021] -------<NSThread: 0x60000067e100>{number = 6, name = (null)}
//        2018-08-20 14:28:54.596204+0800 iOSTest[28195:292021] 2
//        2018-08-20 14:28:54.596725+0800 iOSTest[28195:292021] 4
//        2018-08-20 14:28:54.596912+0800 iOSTest[28195:292009] -<NSThread: 0x60400027fc40>{number = 7, name = (null)}
//        2018-08-20 14:28:54.597216+0800 iOSTest[28195:292009] 3
        */
        
        /*
        dispatch_async(queue1, ^{
            NSLog(@"-------%@",[NSThread currentThread]);
            NSLog(@"2"); // 任务2
            dispatch_async(queue3, ^{
                //1.当前线程异步的把任务加入到非当前队列queue3并行列中，会生成新的子线程，采用子线程在queue3队列里执行任务
                NSLog(@"-%@",[NSThread currentThread]);
                NSLog(@"3"); // 任务3
            });
            NSLog(@"4"); // 任务4
        });
        NSLog(@"5"); // 任务5
//        2018-08-20 14:31:00.873696+0800 iOSTest[28243:294323] 1
//        2018-08-20 14:31:00.873844+0800 iOSTest[28243:294323] 5
//        2018-08-20 14:31:00.873943+0800 iOSTest[28243:294373] -------<NSThread: 0x604000679880>{number = 6, name = (null)}
//        2018-08-20 14:31:00.874053+0800 iOSTest[28243:294373] 2
//        2018-08-20 14:31:00.874212+0800 iOSTest[28243:294370] -<NSThread: 0x60000027d800>{number = 7, name = (null)}
//        2018-08-20 14:31:00.874158+0800 iOSTest[28243:294373] 4
//        2018-08-20 14:31:00.874742+0800 iOSTest[28243:294370] 3
        */
        
        /*
        dispatch_async(queue1, ^{
            NSLog(@"-------%@",[NSThread currentThread]);
            NSLog(@"2"); // 任务2
            dispatch_async(dispatch_get_main_queue(), ^{
                //1.当前线程异步的把任务加入到非当前队列main_queue主行列中，不会生成新的子线程，采用主线程在main_queue队列里执行任务
                NSLog(@"-%@",[NSThread currentThread]);
                NSLog(@"3"); // 任务3
            });
            NSLog(@"4"); // 任务4
        });
//        2018-08-20 14:31:52.450646+0800 iOSTest[28277:295631] 1
//        2018-08-20 14:31:52.450862+0800 iOSTest[28277:295716] -------<NSThread: 0x60400047d400>{number = 6, name = (null)}
//        2018-08-20 14:31:52.451736+0800 iOSTest[28277:295716] 2
//        2018-08-20 14:31:52.451887+0800 iOSTest[28277:295716] 4
//        2018-08-20 14:31:52.484815+0800 iOSTest[28277:295631] -<NSThread: 0x604000066640>{number = 1, name = main}
//        2018-08-20 14:31:52.484973+0800 iOSTest[28277:295631] 3
        */
    }
}


#pragma mark 界面布局
-(void)layoutUI{
    //创建多个图片控件用于显示图片
    _imageViews=[NSMutableArray array];
    for (int r=0; r<ROW_COUNT; r++) {
        for (int c=0; c<COLUMN_COUNT; c++) {
            UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(c*ROW_WIDTH+(c*CELL_SPACING), r*ROW_HEIGHT+(r*CELL_SPACING                           ), ROW_WIDTH, ROW_HEIGHT)];
            imageView.contentMode=UIViewContentModeScaleAspectFit;
            //            imageView.backgroundColor=[UIColor redColor];
            [self.view addSubview:imageView];
            [_imageViews addObject:imageView];
        }
    }
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame=CGRectMake(50, 500, 220, 25);
    [button setTitle:@"加载图片" forState:UIControlStateNormal];
    //添加方法
    [button addTarget:self action:@selector(loadImageWithMultiThread) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    //创建图片链接
    _imageNames=[NSMutableArray array];
    for (int i=0; i<ROW_COUNT*COLUMN_COUNT; i++) {
        [_imageNames addObject:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1534501084870&di=1ab4b1a4209e5342118ebc2074374be6&imgtype=0&src=http%3A%2F%2Fpic2.zhimg.com%2Fv2-3efa478d973dbaa2d8c4f098cf107724_1200x500.jpg"];
    }
}


#pragma mark 多线程下载图片
-(void)loadImageWithMultiThread{
    int count=ROW_COUNT*COLUMN_COUNT;
    
//    /*创建一个串行队列
//     第一个参数：队列名称
//     第二个参数：队列类型
//     */
//    dispatch_queue_t serialQueue=dispatch_queue_create("myThreadQueue1", DISPATCH_QUEUE_SERIAL);//注意queue对象不是指针类型
//
//    //创建多个线程用于填充图片
//    for (int i=0; i<count; ++i) {
//        //只有一个线程，加入到队列中的操作按添加顺序依次执行
//        //异步执行队列任务
//        dispatch_async(serialQueue, ^{
//            [self loadImage:[NSNumber numberWithInt:i]];
//        });
//
//    }
    
    /*取得全局队列
     第一个参数：线程优先级
     第二个参数：标记参数，目前没有用，一般传入0
     */
    
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    //创建多个线程用于填充图片
    for (int i=0; i<count; ++i) {
//        //多个线程
//        //异步执行队列任务
//        dispatch_async(globalQueue, ^{
//            [self loadImage:[NSNumber numberWithInt:i]];
//        });
        
        //严重注意：若全局队列添加任务的时候用的是同步调用，那么就是在主线程中完成操作
        dispatch_sync(globalQueue, ^{
            [self loadImage:[NSNumber numberWithInt:i]];
        });
    }
    //非ARC环境请释放
    //    dispatch_release(seriQueue);
}

#pragma mark 加载图片
-(void)loadImage:(NSNumber *)index{
    
    //如果在串行队列中会发现当前线程打印变化完全一样，因为他们在一个线程中
    NSLog(@"thread is :%@",[NSThread currentThread]);
    
    int i=[index intValue];
    //请求数据
    NSData *data= [self requestData:i];
    //更新UI界面,此处调用了GCD主线程队列的方法
    dispatch_queue_t mainQueue= dispatch_get_main_queue();
    dispatch_async(mainQueue, ^{
        [self updateImageWithData:data andIndex:i];
    });
}

#pragma mark 请求图片数据
-(NSData *)requestData:(int )index{
    NSURL *url=[NSURL URLWithString:_imageNames[index]];
    NSData *data=[NSData dataWithContentsOfURL:url];
    
    return data;
}

#pragma mark 将图片显示到界面
-(void)updateImageWithData:(NSData *)data andIndex:(int )index{
    UIImage *image=[UIImage imageWithData:data];
    UIImageView *imageView= _imageViews[index];
    imageView.image=image;
}

@end
