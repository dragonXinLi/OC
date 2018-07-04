//
//  RACOneController.m
//  RN
//
//  Created by sangfor on 2017/7/20.
//  Copyright © 2017年 LL. All rights reserved.
//

#import "RACOneController.h"
#import "ResultOne.h"

@interface RACOneController ()

@end

@implementation RACOneController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    1.
    ResultOne *res = [[ResultOne alloc] init];
    [res eat1];
    [res run1];
    
//    2.
    [[res eat2] run2];
    
//    3.
    [[res eat3:@"panada"] run3:100];
    
//    4.
    /*
     block的写法
     void (^a)() = ^{ NSLog(@"调用了block"); }; a(); 从上面的代码可以看得出来，调用a()的时候就会执行block里面的代码，在上面我们定义的方法返回一个block
     我们可以这样子写： void (^x)() = [res eat4]; x(); 效果是一样的， .eat4调动的就是get方法，然后我们拿到了一个block，
     这个时候我么你直接()，就相当于上面的两步，所以我们可以这样子调用
     */
    res.eat4();
    res.run4();
    
//    5.
    res.eat5().run5();
    
//    6.
    /*
     带参数的block调用
     void (^a)(NSString *food) = ^(NSString *food){
     NSLog(@"调用了block");
     };
     a(@"");
     */
    res.eat6(@"sss").run6(100);
    
//    7.
    //点语法只适用于该方法无参数
    [res eat7:^{
        NSLog(@"eat7");
    }];
    [res run7:^{
        NSLog(@"run7");
    }];
    
//    8.
    [[res eat8:^{
        NSLog(@"eat8");
    }] run8:^{
        NSLog(@"run8");
    }];
    
    [[res eat8:nil] run8:^{
      NSLog(@"run8");
    }];
    
//    9
    [[res eat9:^(NSString *food) {
        NSLog(@"eat :%@",food);
    }] run9:^(float metter) {
        NSLog(@"run :%f",metter);
    }];
    
//    10.
    res.eat10(@"apple",^{
        NSLog(@"eat10:apple");
    });
    res.run10(100,^{
        NSLog(@"run10:100");
    });
    
//    11.
    res.eat11(@"pear", ^(NSString *food){
        NSLog(@"eat11: %@",food);
    }).run11(110, ^(float meeter){
        NSLog(@"run11: %f",meeter);
    });
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
