//
//  NSBlockOperationMViewController.m
//  iOSTest
//
//  Created by lilong on 2018/8/17.
//  Copyright © 2018年 lilong. All rights reserved.
//

#import "NSBlockOperationMViewController.h"
#import "LLImageData.h"
#define ROW_COUNT 5
#define COLUMN_COUNT 3
#define ROW_HEIGHT 100
#define ROW_WIDTH ROW_HEIGHT
#define CELL_SPACING 10

@interface NSBlockOperationMViewController ()
{
    NSMutableArray *_imageViews;
    NSMutableArray *_imageNames;
}
@end

@implementation NSBlockOperationMViewController

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
    
    //创建图片链接
    _imageNames=[NSMutableArray array];
    for (int i=0; i<COLUMN_COUNT*ROW_COUNT; i++) {
        [_imageNames addObject:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1534501084870&di=1ab4b1a4209e5342118ebc2074374be6&imgtype=0&src=http%3A%2F%2Fpic2.zhimg.com%2Fv2-3efa478d973dbaa2d8c4f098cf107724_1200x500.jpg"];
    }
}


#pragma mark 多线程下载图片
-(void)loadImageWithMultiThread{
    int count=ROW_COUNT*COLUMN_COUNT;
    //创建操作队列
    NSOperationQueue *operationQueue=[[NSOperationQueue alloc]init];
    //要是不设置最大并发线程数，则有可能有几个操作就会创建几个线程
    operationQueue.maxConcurrentOperationCount=5;//设置最大并发线程数
    
    NSBlockOperation *lastBlockOperation = [NSBlockOperation blockOperationWithBlock:^{
        [self loadImage:[NSNumber numberWithInt:count - 1]];
    }];
    
    //创建多个线程用于填充图片
    for (int i=0; i<count - 1; ++i) {
        //方法1：创建操作块添加到队列
        //        //创建多线程操作
                NSBlockOperation *blockOperation=[NSBlockOperation blockOperationWithBlock:^{
                    [self loadImage:[NSNumber numberWithInt:i]];
                }];
                //设置依赖操作为最后一张图片加载操作
                [blockOperation addDependency:lastBlockOperation];
        
                //创建操作队列
                [operationQueue addOperation:blockOperation];
        
//        //方法2：直接使用操队列添加操作
//        [operationQueue addOperationWithBlock:^{
//            [self loadImage:[NSNumber numberWithInt:i]];
//        }];
        
    }
    
    //将最后一个Operation操作加入线程队列
    [operationQueue addOperation:lastBlockOperation];
}

#pragma mark 加载图片
-(void)loadImage:(NSNumber *)index{
    int i=[index intValue];
    
    //请求数据
    NSData *data= [self requestData:i];
    NSLog(@"%@",[NSThread currentThread]);
    //更新UI界面,此处调用了主线程队列的方法（mainQueue是UI主线程）
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [self updateImageWithData:data andIndex:i];
    }];
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
