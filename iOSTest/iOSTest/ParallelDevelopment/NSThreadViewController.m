//
//  NSThreadViewController.m
//  iOSTest
//
//  Created by lilong on 2018/8/17.
//  Copyright © 2018年 lilong. All rights reserved.
//

#import "NSThreadViewController.h"
#import "LLImageData.h"

#define ROW_COUNT 5      //5行
#define COLUMN_COUNT 3  //3列
#define ROW_HEIGHT 100
#define ROW_WIDTH ROW_HEIGHT
#define CELL_SPACING 10

@interface NSThreadViewController ()
{
    NSMutableArray *_imageViews;
     NSMutableArray *_imageNames;
    NSMutableArray *_threads;
}
@end

@implementation NSThreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    
    //停止按钮
    UIButton *buttonStop=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    buttonStop.frame=CGRectMake(160, 500, 100, 25);
    [buttonStop setTitle:@"停止加载" forState:UIControlStateNormal];
    [buttonStop addTarget:self action:@selector(stopLoadImage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonStop];
    
    //创建图片链接
    _imageNames=[NSMutableArray array];
    for (int i=0; i<ROW_COUNT*COLUMN_COUNT; i++) {
        [_imageNames addObject:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1534501084870&di=1ab4b1a4209e5342118ebc2074374be6&imgtype=0&src=http%3A%2F%2Fpic2.zhimg.com%2Fv2-3efa478d973dbaa2d8c4f098cf107724_1200x500.jpg"];
    }
    
}


- (void)loadImageWithMultiThread
{
     _threads =[NSMutableArray array];
     int count=ROW_COUNT*COLUMN_COUNT;
    //创建多个线程用于填充图片
    for (int i=0; i<count; ++i) {
        //        [NSThread detachNewThreadSelector:@selector(loadImage:) toTarget:self withObject:[NSNumber numberWithInt:i]];
        NSThread *thread=[[NSThread alloc]initWithTarget:self selector:@selector(loadImage:) object:[NSNumber numberWithInt:i]];
        thread.name=[NSString stringWithFormat:@"myThread%i",i];//设置线程名称
        //线程优先级范围为0~1，值越大优先级越高，每个线程的优先级默认为0.5.可以提高它被优先加载的几率，但是它也未必就第一个加载
        if(i==(count-1)){
            thread.threadPriority=1.0;
        }else{
            thread.threadPriority=0.0;
        }
        [_threads addObject:thread];
    }
    
    for (int i = 0; i < count; i++) {
        NSThread *thread = _threads[i];
        [thread start];
    }
}



#pragma mark 停止加载图片
-(void)stopLoadImage{
    for (int i=0; i<ROW_COUNT*COLUMN_COUNT; i++) {
        NSThread *thread= _threads[i];
        //判断线程是否完成，如果没有完成则设置为取消状态
        //注意设置为取消状态仅仅是改变了线程状态而言，并不能终止线程
        if (!thread.isFinished) {
            [thread cancel];
        }
    }
}

-(void)loadImage:(NSNumber *)index{
    //不是按顺序执行,因为线程启动后仅仅处于就绪状态，实际是否执行要由CPU根据当前状态调度。 主线程的编号永远为1
    NSLog(@"%@",[NSThread currentThread]);
    
    NSData *data= [self requestData:index.intValue];
    
    //如果当前线程处于取消状态，则退出当前线程，最好是写在异步请求之后，因为在异步请求之前，代码执行速度过快，没法拦截
    NSThread *currendThread = [NSThread currentThread];
    if (currendThread.isCancelled) {
        [NSThread exit];//取消当前线程，不能继续向下执行
    }
    
    LLImageData *imageData=[[LLImageData alloc]init];
    imageData.index=index.intValue;
    imageData.data=data;
    //performSelectorOnMainThread传递的参数只能是一个，所以必须要用LLImageData包装
    [self performSelectorOnMainThread:@selector(updateImage:) withObject:imageData waitUntilDone:YES];
    
}

#pragma mark 请求图片数据
-(NSData *)requestData:(int )index{
    //对非最后一张图片加载线程休眠2秒
//    if (index!=(ROW_COUNT*COLUMN_COUNT-1)) {
//        [NSThread sleepForTimeInterval:2.0];
//    }
    
    NSURL *url=[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1534501084870&di=1ab4b1a4209e5342118ebc2074374be6&imgtype=0&src=http%3A%2F%2Fpic2.zhimg.com%2Fv2-3efa478d973dbaa2d8c4f098cf107724_1200x500.jpg"];
    NSData *data=[NSData dataWithContentsOfURL:url];
    return data;
}


#pragma mark 将图片显示到界面
-(void)updateImage:(LLImageData *)imageData{
    UIImage *image=[UIImage imageWithData:imageData.data];
    UIImageView *imageView= _imageViews[imageData.index];
    imageView.image=image;
}
@end
