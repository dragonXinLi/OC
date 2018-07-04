//
//  RTSendMessageViewController.m
//  RN
//
//  Created by sangfor on 2017/8/1.
//  Copyright © 2017年 LL. All rights reserved.
//

#import "RTSendMessageViewController.h"
#import "RTPerson.h"
#import <objc/message.h>
#import "NSObject+Property.h"
#import "NSObject+Model.h"
#import "NSObject+Log.h"
@interface RTSendMessageViewController ()

@end

@implementation RTSendMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    RTPerson *p = [[RTPerson alloc] init];
    //[p eat];
    
    //objc_msgSend(p,@selector(eat));
    
    //[[RTPerson class] eat];
    
    //objc_msgSend([RTPerson class] , @selector(eat));
    
    
    
    //3.动态添加方法
    //[p run];
    [p performSelector:@selector(run)];
    
    
    //4.给分类添加属性
    
    NSObject *obj = [[NSObject alloc] init];
    obj.name = @"LL";
    NSLog(@"%@",obj.name);
    
    //5.字典转模型
    
    
    // 解析Plist文件
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"status.plist" ofType:nil];
    NSDictionary *statusDict = [NSDictionary dictionaryWithContentsOfFile:filePath];
    // 获取字典数组
    NSArray *dictArr = statusDict[@"statuses"];
    
    // 遍历字典数组
    for (NSDictionary *dict in dictArr) {
        [RTPerson resolveDict:dict];

        //RTPerson *status = [RTPerson modelWithDict:dict];
        
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
