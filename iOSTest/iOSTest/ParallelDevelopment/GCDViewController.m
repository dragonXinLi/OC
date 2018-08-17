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
    
//    dispatch_queue_t queue = dispatch_queue_create("barrier", DISPATCH_QUEUE_CONCURRENT);
//
//    dispatch_async(queue, ^{
//        NSLog(@"111111 %@",[NSThread currentThread]);
//    });
//
//    dispatch_async(queue, ^{
//        NSLog(@"22222 %@",[NSThread currentThread]);
//    });
//
//    dispatch_barrier_async(queue, ^{
//        NSLog(@"barrier %@",[NSThread currentThread]);
//    });
//
//    dispatch_async(queue, ^{
//       NSLog(@"333333 %@",[NSThread currentThread]);
//    });
//
//    dispatch_async(queue, ^{
//        NSLog(@"44444 %@",[NSThread currentThread]);
//    });
    
    [self layoutUI];
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
