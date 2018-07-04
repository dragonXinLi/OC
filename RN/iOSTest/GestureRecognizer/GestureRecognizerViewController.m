//
//  GestureRecognizerViewController.m
//  RN
//
//  Created by sangfor on 2018/2/1.
//  Copyright © 2018年 LL. All rights reserved.
//

#import "GestureRecognizerViewController.h"
#import "GestureRecognizerView.h"
#import "UIView+Frame.h"



@interface viewc()


@end

@implementation viewc

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    BOOL a = [super pointInside:point withEvent:event];
    return a;
}

@end


@interface GestureRecognizerViewController ()

@end

@implementation GestureRecognizerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataList  = @[];
    
    GestureRecognizerView *view = [[GestureRecognizerView alloc] initWithFrame:self.view.bounds];
//    GestureRecognizerView *view = [[GestureRecognizerView alloc] initWithFrame:CGRectMake(0, 300, self.view.width, 300)];

//    [view setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:view];
    
    viewc *c = [self viewa];
    [view addSubview:c];
    [c addSubview:[self button]];
    
    
    UILabel *a = [self label];
    view.viewa = a;
    [view addSubview:a];
    
    UIButton *btn = [self button];
    [view addSubview:btn];
    
    [view addHittingView:c];
//    [view addHittingView:a];
    [view addHittingView:btn];
}


- (viewc *)viewa
{
    viewc *view = [[viewc alloc] initWithFrame:CGRectMake(0, 300, self.view.width, 300)];
    [view setBackgroundColor:[UIColor grayColor]];
    return view;
}

- (UILabel *)label
{
//    UILabel *a = [[UILabel alloc] initWithFrame:CGRectMake(0 , - 60, self.view.frame.size.width, 50)];
    UILabel *a = [[UILabel alloc] initWithFrame:CGRectMake(0 , 64, self.view.frame.size.width, 50)];
    [a setText:@"111111"];
    [a setTextColor:[UIColor blackColor]];
    [a setUserInteractionEnabled:YES];
    return a;
}

- (UIButton *)button
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btn setFrame:CGRectMake(0, - 60 - 50 - 50, self.view.frame.size.width, 50)];
    [btn setFrame:CGRectMake(0, 64 + 50, self.view.frame.size.width, 50)];
    [btn setTitle:@"2222222" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(bbbbbb:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

- (void)bbbbbb:(UIButton *)btn
{
    [btn setTitle:@"444444444" forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
