//
//  FloatViewController.m
//  iOSTest
//
//  Created by lilong on 2018/6/26.
//  Copyright © 2018年 LL. All rights reserved.
//

#import "FloatViewController.h"
#import "BCMath.h"
#import "NSString+BCMath.h"
#import "BCMath+dateTest.h"
#import "NSDate+string.h"
@interface FloatViewController ()

@end

@implementation FloatViewController

#pragma mark - LifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(0)
    {
        double firstMonthCapital = 2.56251;
        double firstMonthInterest = 2.56258;

        NSString *fmCStr = [NSString stringWithFormat:@"%.2f",firstMonthCapital];
        NSString *fmIStr = [NSString stringWithFormat:@"%.2f",firstMonthInterest];
        
        double fc = [fmCStr doubleValue];
        double fi = [fmIStr doubleValue];
        
        NSLog(@"%f",fc);
        NSLog(@"%f",fi);
        
        NSLog(@"%.10f",fc);
        NSLog(@"%.10f",fi);
        
        NSLog(@"%.12f",fc);
        NSLog(@"%.12f",fi);
        NSAssert(1, nil);
    }
    
    if(0)
    {
        double a = 2.56251;
        double b = 2.56258;
        double c = 2.56250;
        double d = 2.56350;
        double e = 2.5631;
        double f = 2.5638;

        NSLog(@"%.3f",a);//2.563
        NSLog(@"%.3f",b);//2.563
        NSLog(@"%.3f",c);//2.562
        NSLog(@"%.3f",d);//2.564? (2.563)这里没有看5前面的奇数，不知为何
        NSLog(@"%.3f",e);//2.563
        NSLog(@"%.3f",f);//2.564
    }
    
    if(0)
    {
        NSDecimalNumber *num1 = [NSDecimalNumber decimalNumberWithString:@"1.99999999999999999999999999991"];
        NSDecimalNumber *num2 = [NSDecimalNumber decimalNumberWithString:@"2.00000000000000000000000000002"];
        {
            NSDecimalNumber *result = [num1 decimalNumberByAdding:num2];
            NSLog(@"高精度加法 : %@",[result stringValue]); //3999.99999999999999999999999999993
            NSLog(@"基础数据类型：%.30f\n",1999.99999999999999999999999999991+ 2000.00000000000000000000000000002);//4000.000000000000000000000000000000
        }
        
        {
            NSDecimalNumber *result = [num1 decimalNumberBySubtracting:num2];
            NSLog(@"高精度减法：%@",[result stringValue]);//-0.00000000000000000000000000011
            NSLog(@"基础数据类型：%.30f\n",1999.99999999999999999999999999991- 2000.00000000000000000000000000002);//0.000000000000000000000000000000
        }
        
        {
            NSDecimalNumber *result = [num1 decimalNumberByMultiplyingBy:num2];
            NSLog(@"高精度乘法：%@",[result stringValue]);//3.99999999999999999999999999986
            NSLog(@"基础数据类型：%.30f\n",1999.99999999999999999999999999991* 2000.00000000000000000000000000002);//4000000.000000000000000000000000000000
        }
        
        {
            NSDecimalNumber *result = [num1 decimalNumberByDividingBy:num2];
            NSLog(@"高精度除法：%@",[result stringValue]);//0.999999999999999999999999999945
            NSLog(@"基础数据类型：%.30f\n",1999.99999999999999999999999999991/ 2000.00000000000000000000000000002);//1.000000000000000000000000000000
        }
    }
    
    if(1)
    {
        BCMath *person = [BCMath new];
//        person.sleep(100).sleep(100).sleep(50);
//        NSLog(@"%@",person);
        
        
        NSDate *date = [NSDate date];
//        [date description];
        NSLog(@"%@",date);
    }
    
    if(0)
    {
        
        NSString *a = @"1.225";
        NSString *b = @"3.001";
        NSString *a1 = a.add(b);
        NSString *a2 = a.add(b).add(a);//5.451
        NSString *a3 = a.add(b).add(a).sub(a);//4.226
        NSString *a4 = a.add_r(b,2);//4.23
        NSString *a5 = a.add_exc(a);//2.45
        NSString *a6 = a.roundToUp(2);//1.23
        NSString *a7= a.roundToDowm(2);//1.22
        NSString *a8= a.roundToPlain(2);//1.23
        NSString *a9 = a.roundToBankers(2);//1.22
        NSAssert(1, nil);
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

#pragma mark - Initial Methods

#pragma mark - Override Methods

#pragma mark - Target Methods

#pragma mark - Privater Methods

#pragma mark - Notification Methods

#pragma mark - KVO Methods

#pragma mark - UITableViewDelegate, UITableViewDataSource

#pragma mark - Setter Getter Methods

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
